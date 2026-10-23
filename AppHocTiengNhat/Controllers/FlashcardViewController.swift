//
//  FlashcardViewController.swift
//  AppHocTiengNhat
//

import UIKit

public class FlashcardViewController: UIViewController, FlashcardViewDelegate {
    
    private let kanaType: KanaType
    private var characters: [KanaCharacter] = []
    private var currentIndex: Int = 0
    
    private let progressView = UIProgressView(progressViewStyle: .default)
    private let counterLabel = UILabel()
    private let flashcard = FlashcardView()
    
    private let prevButton = UIButton(type: .system)
    private let nextButton = UIButton(type: .system)
    private let speakButton = UIButton(type: .system)
    
    public init(kanaType: KanaType) {
        self.kanaType = kanaType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.kanaType = .hiragana
        super.init(coder: coder)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        title = "Flashcard \(kanaType.rawValue)"
        view.backgroundColor = .systemGroupedBackground
        
        characters = KanaRepository.shared.getCharacters(for: kanaType)
        setupUI()
        setupGestures()
        updateCard()
    }
    
    private func setupUI() {
        navigationController?.navigationBar.prefersLargeTitles = false
        
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.progressTintColor = .systemBlue
        progressView.trackTintColor = .systemGray5
        view.addSubview(progressView)
        
        counterLabel.translatesAutoresizingMaskIntoConstraints = false
        counterLabel.font = .systemFont(ofSize: 15, weight: .medium)
        counterLabel.textColor = .secondaryLabel
        counterLabel.textAlignment = .center
        view.addSubview(counterLabel)
        
        flashcard.translatesAutoresizingMaskIntoConstraints = false
        flashcard.delegate = self
        view.addSubview(flashcard)
        
        // Navigation buttons
        var prevConfig = UIButton.Configuration.filled()
        prevConfig.title = "Trước"
        prevConfig.image = UIImage(systemName: "chevron.left")
        prevConfig.imagePlacement = .leading
        prevConfig.imagePadding = 6
        prevConfig.baseBackgroundColor = .secondarySystemGroupedBackground
        prevConfig.baseForegroundColor = .label
        prevButton.configuration = prevConfig
        prevButton.layer.cornerRadius = 14
        prevButton.layer.shadowColor = UIColor.black.cgColor
        prevButton.layer.shadowOpacity = 0.05
        prevButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        prevButton.layer.shadowRadius = 4
        prevButton.translatesAutoresizingMaskIntoConstraints = false
        prevButton.addTarget(self, action: #selector(didTapPrevious), for: .touchUpInside)
        
        var nextConfig = UIButton.Configuration.filled()
        nextConfig.title = "Tiếp theo"
        nextConfig.image = UIImage(systemName: "chevron.right")
        nextConfig.imagePlacement = .trailing
        nextConfig.imagePadding = 6
        nextConfig.baseBackgroundColor = .systemBlue
        nextConfig.baseForegroundColor = .white
        nextButton.configuration = nextConfig
        nextButton.layer.cornerRadius = 14
        nextButton.layer.shadowColor = UIColor.systemBlue.cgColor
        nextButton.layer.shadowOpacity = 0.2
        nextButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        nextButton.layer.shadowRadius = 6
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
        
        var speakConfig = UIButton.Configuration.tinted()
        speakConfig.image = UIImage(systemName: "speaker.wave.3.fill")
        speakConfig.baseBackgroundColor = .systemBlue
        speakButton.configuration = speakConfig
        speakButton.layer.cornerRadius = 24
        speakButton.clipsToBounds = true
        speakButton.translatesAutoresizingMaskIntoConstraints = false
        speakButton.addTarget(self, action: #selector(didTapSpeak), for: .touchUpInside)
        
        let buttonStack = UIStackView(arrangedSubviews: [prevButton, speakButton, nextButton])
        buttonStack.axis = .horizontal
        buttonStack.distribution = .fillProportionally
        buttonStack.alignment = .center
        buttonStack.spacing = 16
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonStack)
        
        NSLayoutConstraint.activate([
            progressView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            progressView.heightAnchor.constraint(equalToConstant: 6),
            
            counterLabel.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 12),
            counterLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            flashcard.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            flashcard.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -30),
            flashcard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            flashcard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            flashcard.heightAnchor.constraint(equalToConstant: 380),
            
            speakButton.widthAnchor.constraint(equalToConstant: 50),
            speakButton.heightAnchor.constraint(equalToConstant: 50),
            prevButton.heightAnchor.constraint(equalToConstant: 50),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            
            buttonStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            buttonStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            buttonStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
    }
    
    private func setupGestures() {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(didTapNext))
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(didTapPrevious))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)
    }
    
    private func updateCard() {
        guard !characters.isEmpty, currentIndex < characters.count else { return }
        
        let item = characters[currentIndex]
        flashcard.configure(with: item)
        
        counterLabel.text = "\(currentIndex + 1) / \(characters.count)"
        let progress = Float(currentIndex + 1) / Float(characters.count)
        progressView.setProgress(progress, animated: true)
        
        prevButton.isEnabled = currentIndex > 0
        nextButton.setTitle(currentIndex == characters.count - 1 ? "Hoàn thành" : "Tiếp theo", for: .normal)
        
        // Tự động phát âm khi chuyển thẻ
        AudioService.shared.speak(text: item.character)
    }
    
    @objc private func didTapPrevious() {
        guard currentIndex > 0 else { return }
        currentIndex -= 1
        animateCardTransition(forward: false)
    }
    
    @objc private func didTapNext() {
        if currentIndex < characters.count - 1 {
            currentIndex += 1
            animateCardTransition(forward: true)
        } else {
            showCompletionAlert()
        }
    }
    
    @objc private func didTapSpeak() {
        guard !characters.isEmpty else { return }
        let item = characters[currentIndex]
        AudioService.shared.speak(text: item.character)
    }
    
    private func animateCardTransition(forward: Bool) {
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = .push
        transition.subtype = forward ? .fromRight : .fromLeft
        flashcard.layer.add(transition, forKey: kCATransition)
        updateCard()
    }
    
    private func showCompletionAlert() {
        let alert = UIAlertController(
            title: "Tuyệt vời! 🎉",
            message: "Bạn đã xem hết toàn bộ bảng chữ cái \(kanaType.rawValue)!",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Học lại từ đầu", style: .default, handler: { [weak self] _ in
            self?.currentIndex = 0
            self?.updateCard()
        }))
        alert.addAction(UIAlertAction(title: "Luyện nghe ngay", style: .default, handler: { [weak self] _ in
            guard let self = self else { return }
            let quizVC = AudioQuizViewController(kanaType: self.kanaType)
            self.navigationController?.pushViewController(quizVC, animated: true)
        }))
        present(alert, animated: true)
    }
    
    // MARK: - FlashcardViewDelegate
    public func flashcardViewDidTapAudio(_ view: FlashcardView, character: KanaCharacter) {
        if view.isFlipped {
            AudioService.shared.speak(text: character.exampleWord)
        } else {
            AudioService.shared.speak(text: character.character)
        }
    }
}
