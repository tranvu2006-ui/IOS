//
//  KanaChartViewController.swift
//  AppHocTiengNhat
//

import UIKit

public class KanaChartViewController: UIViewController, KanaGridViewDelegate {
    
    private var currentType: KanaType = .hiragana
    private let gridView = KanaGridView()
    
    // Bottom Tab Bar
    private let bottomTabBar = UIView()
    private let hiraganaTabButton = UIButton(type: .custom)
    private let katakanaTabButton = UIButton(type: .custom)
    
    // Auto-play state
    private var isAutoPlaying: Bool = false
    private var autoPlayTimer: Timer?
    private var autoPlayIndex: Int = 0
    private var autoPlayList: [(char: String, romaji: String)] = []
    
    // Navigation Bar items
    private var playBarButton: UIBarButtonItem!
    private var eyeBarButton: UIBarButtonItem!
    
    public init(initialType: KanaType = .hiragana) {
        self.currentType = initialType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.currentType = .hiragana
        super.init(coder: coder)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupUI()
        selectTab(type: currentType)
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopAutoPlay()
    }
    
    private func setupNavigationBar() {
        title = "Bảng chữ cái"
        
        // Nền xanh dương chuẩn như ảnh mẫu của người dùng
        let headerBlue = UIColor(red: 68/255, green: 104/255, blue: 184/255, alpha: 1.0)
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = headerBlue
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 18, weight: .semibold)
        ]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.tintColor = .white
        
        // Right Bar Button Items: [Play ⏵] và [Eye 👁 / Eye.slash]
        let playImg = UIImage(systemName: "play.fill")
        playBarButton = UIBarButtonItem(image: playImg, style: .plain, target: self, action: #selector(didTapAutoPlay))
        
        let eyeImg = UIImage(systemName: "eye.slash.fill")
        eyeBarButton = UIBarButtonItem(image: eyeImg, style: .plain, target: self, action: #selector(didTapToggleRomaji))
        
        navigationItem.rightBarButtonItems = [eyeBarButton, playBarButton]
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        // Grid View
        gridView.translatesAutoresizingMaskIntoConstraints = false
        gridView.delegate = self
        view.addSubview(gridView)
        
        // Bottom Tab Bar
        bottomTabBar.backgroundColor = UIColor(red: 242/255, green: 244/255, blue: 248/255, alpha: 1.0)
        bottomTabBar.layer.borderWidth = 0.5
        bottomTabBar.layer.borderColor = UIColor.systemGray4.cgColor
        bottomTabBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomTabBar)
        
        setupTabButton(hiraganaTabButton, title: "Hiragana", action: #selector(didTapHiraganaTab))
        setupTabButton(katakanaTabButton, title: "Katakana", action: #selector(didTapKatakanaTab))
        
        let tabStack = UIStackView(arrangedSubviews: [hiraganaTabButton, katakanaTabButton])
        tabStack.axis = .horizontal
        tabStack.distribution = .fillEqually
        tabStack.translatesAutoresizingMaskIntoConstraints = false
        bottomTabBar.addSubview(tabStack)
        
        NSLayoutConstraint.activate([
            gridView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            gridView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gridView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gridView.bottomAnchor.constraint(equalTo: bottomTabBar.topAnchor),
            
            bottomTabBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomTabBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomTabBar.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomTabBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -56),
            
            tabStack.topAnchor.constraint(equalTo: bottomTabBar.topAnchor),
            tabStack.leadingAnchor.constraint(equalTo: bottomTabBar.leadingAnchor),
            tabStack.trailingAnchor.constraint(equalTo: bottomTabBar.trailingAnchor),
            tabStack.heightAnchor.constraint(equalToConstant: 54)
        ])
    }
    
    private func setupTabButton(_ btn: UIButton, title: String, action: Selector) {
        btn.setTitle(title, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 17, weight: .regular)
        btn.setTitleColor(UIColor(red: 44/255, green: 76/255, blue: 135/255, alpha: 1.0), for: .selected)
        btn.setTitleColor(.secondaryLabel, for: .normal)
        btn.addTarget(self, action: action, for: .touchUpInside)
    }
    
    private func selectTab(type: KanaType) {
        currentType = type
        stopAutoPlay()
        gridView.setKanaType(type)
        
        hiraganaTabButton.isSelected = (type == .hiragana)
        hiraganaTabButton.titleLabel?.font = (type == .hiragana) ? .systemFont(ofSize: 17, weight: .bold) : .systemFont(ofSize: 17, weight: .regular)
        
        katakanaTabButton.isSelected = (type == .katakana)
        katakanaTabButton.titleLabel?.font = (type == .katakana) ? .systemFont(ofSize: 17, weight: .bold) : .systemFont(ofSize: 17, weight: .regular)
    }
    
    @objc private func didTapHiraganaTab() {
        selectTab(type: .hiragana)
    }
    
    @objc private func didTapKatakanaTab() {
        selectTab(type: .katakana)
    }
    
    // MARK: - Actions
    @objc private func didTapToggleRomaji() {
        let isHidden = gridView.toggleRomajiVisibility()
        let iconName = isHidden ? "eye.fill" : "eye.slash.fill"
        eyeBarButton.image = UIImage(systemName: iconName)
    }
    
    @objc private func didTapAutoPlay() {
        if isAutoPlaying {
            stopAutoPlay()
        } else {
            startAutoPlay()
        }
    }
    
    private func startAutoPlay() {
        isAutoPlaying = true
        playBarButton.image = UIImage(systemName: "pause.fill")
        autoPlayList = gridView.getAllCharactersInOrder()
        autoPlayIndex = 0
        
        playCurrentAutoPlayStep()
        
        autoPlayTimer?.invalidate()
        autoPlayTimer = Timer.scheduledTimer(withTimeInterval: 1.1, repeats: true) { [weak self] _ in
            self?.playCurrentAutoPlayStep()
        }
    }
    
    private func playCurrentAutoPlayStep() {
        guard isAutoPlaying, autoPlayIndex < autoPlayList.count else {
            stopAutoPlay()
            return
        }
        let item = autoPlayList[autoPlayIndex]
        AudioService.shared.speak(text: item.char)
        autoPlayIndex += 1
    }
    
    private func stopAutoPlay() {
        isAutoPlaying = false
        autoPlayTimer?.invalidate()
        autoPlayTimer = nil
        playBarButton.image = UIImage(systemName: "play.fill")
    }
    
    // MARK: - KanaGridViewDelegate
    public func kanaGridViewDidSelect(character: String, romaji: String) {
        AudioService.shared.speak(text: character)
    }
}
