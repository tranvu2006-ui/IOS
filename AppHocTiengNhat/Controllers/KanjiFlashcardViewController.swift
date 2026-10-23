//
//  KanjiFlashcardViewController.swift
//  AppHocTiengNhat
//

import UIKit

public class KanjiFlashcardViewController: UIViewController {
    
    private var kanjiList: [KanjiCharacter] = []
    private var currentIndex: Int = 0
    
    private let progressView = UIProgressView(progressViewStyle: .default)
    private let counterLabel = UILabel()
    private let flashcard = KanjiFlashcardView()
    
    private let prevButton = UIButton(type: .system)
    private let nextButton = UIButton(type: .system)
    private let speakButton = UIButton(type: .system)
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        title = "Flashcard Kanji N5"
        view.backgroundColor = .systemGroupedBackground
        
        kanjiList = KanjiRepository.shared.n5KanjiList
        setupUI()
        setupGestures()
        updateCard()
    }
    
    private func setupUI() {
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.progressTintColor = .systemOrange
        progressView.trackTintColor = .systemGray5
        view.addSubview(progressView)
        
        counterLabel.translatesAutoresizingMaskIntoConstraints = false
        counterLabel.font = .systemFont(ofSize: 15, weight: .medium)
        counterLabel.textColor = .secondaryLabel
        counterLabel.textAlignment = .center
        view.addSubview(counterLabel)
        
        flashcard.translatesAutoresizingMaskIntoConstraints = false
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
        nextConfig.baseBackgroundColor = .systemOrange
        nextConfig.baseForegroundColor = .white
        nextButton.configuration = nextConfig
        nextButton.layer.cornerRadius = 14
        nextButton.layer.shadowColor = UIColor.systemOrange.cgColor
        nextButton.layer.shadowOpacity = 0.2
        nextButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        nextButton.layer.shadowRadius = 6
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
        
        var speakConfig = UIButton.Configuration.tinted()
        speakConfig.image = UIImage(systemName: "speaker.wave.3.fill")
        speakConfig.baseBackgroundColor = .systemOrange
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
            flashcard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
            flashcard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28),
            flashcard.heightAnchor.constraint(equalToConstant: 410),
            
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
        guard !kanjiList.isEmpty, currentIndex < kanjiList.count else { return }
        
        let item = kanjiList[currentIndex]
        flashcard.configure(with: item)
        
        counterLabel.text = "\(currentIndex + 1) / \(kanjiList.count)"
        let progress = Float(currentIndex + 1) / Float(kanjiList.count)
        progressView.setProgress(progress, animated: true)
        
        prevButton.isEnabled = currentIndex > 0
        nextButton.setTitle(currentIndex == kanjiList.count - 1 ? "Hoàn thành" : "Tiếp theo", for: .normal)
        
        // Tự động phát âm ví dụ đầu tiên của chữ Kanji
        if let first = item.examples.first {
            AudioService.shared.speak(text: first.word)
        }
    }
    
    @objc private func didTapPrevious() {
        guard currentIndex > 0 else { return }
        currentIndex -= 1
        animateCardTransition(forward: false)
    }
    
    @objc private func didTapNext() {
        if currentIndex < kanjiList.count - 1 {
            currentIndex += 1
            animateCardTransition(forward: true)
        } else {
            showCompletionAlert()
        }
    }
    
    @objc private func didTapSpeak() {
        guard !kanjiList.isEmpty else { return }
        let item = kanjiList[currentIndex]
        if let first = item.examples.first {
            AudioService.shared.speak(text: first.word)
        }
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
            title: "Xuất sắc! 🏮",
            message: "Bạn đã học qua toàn bộ danh sách Hán tự Kanji N5!",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Học lại từ đầu", style: .default, handler: { [weak self] _ in
            self?.currentIndex = 0
            self?.updateCard()
        }))
        alert.addAction(UIAlertAction(title: "Luyện nghe Kanji", style: .default, handler: { [weak self] _ in
            guard let self = self else { return }
            let quizVC = KanjiQuizViewController()
            self.navigationController?.pushViewController(quizVC, animated: true)
        }))
        present(alert, animated: true)
    }
}
