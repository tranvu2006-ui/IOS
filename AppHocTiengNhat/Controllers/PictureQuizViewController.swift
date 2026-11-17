//
//  PictureQuizViewController.swift
//  AppHocTiengNhat
//

import UIKit

public class PictureQuizViewController: UIViewController {
    
    private var allItems: [PictureQuizItem] = []
    private var quizList: [PictureQuizItem] = []
    private var currentIndex: Int = 0
    private var score: Int = 0
    private var isAnswerLocked: Bool = false
    
    private var currentCorrectItem: PictureQuizItem?
    private var optionButtons: [UIButton] = []
    
    // UI Elements
    private let progressView = UIProgressView(progressViewStyle: .default)
    private let headerLabel = UILabel()
    private let scoreBadgeLabel = UILabel()
    
    private let pictureCard = UIView()
    private let emojiLabel = UILabel()
    private let vietnamesePromptLabel = UILabel()
    private let speakButton = UIButton(type: .system)
    
    private let hintBubbleView = UIView()
    private let hintTextLabel = UILabel()
    
    private let optionsStackView = UIStackView()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        title = "Nhìn hình đoán chữ"
        view.backgroundColor = .systemGroupedBackground
        navigationItem.largeTitleDisplayMode = .never
        
        allItems = PictureQuizRepository.shared.allItems
        setupUI()
        startNewQuizSession()
    }
    
    private func setupUI() {
        // Progress view
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.progressTintColor = .systemPink
        progressView.trackTintColor = .systemGray5
        view.addSubview(progressView)
        
        // Header
        headerLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        headerLabel.textColor = .secondaryLabel
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerLabel)
        
        // Score badge
        scoreBadgeLabel.font = .systemFont(ofSize: 13, weight: .bold)
        scoreBadgeLabel.textColor = .systemPink
        scoreBadgeLabel.backgroundColor = UIColor.systemPink.withAlphaComponent(0.12)
        scoreBadgeLabel.layer.cornerRadius = 8
        scoreBadgeLabel.clipsToBounds = true
        scoreBadgeLabel.textAlignment = .center
        scoreBadgeLabel.text = " Điểm: 0 "
        scoreBadgeLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scoreBadgeLabel)
        
        // Picture Card (Khối ảnh to ở giữa)
        pictureCard.backgroundColor = .systemBackground
        pictureCard.layer.cornerRadius = 24
        pictureCard.layer.borderWidth = 1.5
        pictureCard.layer.borderColor = UIColor.systemGray5.cgColor
        pictureCard.layer.shadowColor = UIColor.black.cgColor
        pictureCard.layer.shadowOpacity = 0.08
        pictureCard.layer.shadowOffset = CGSize(width: 0, height: 6)
        pictureCard.layer.shadowRadius = 12
        pictureCard.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pictureCard)
        
        emojiLabel.font = .systemFont(ofSize: 84)
        emojiLabel.textAlignment = .center
        emojiLabel.translatesAutoresizingMaskIntoConstraints = false
        pictureCard.addSubview(emojiLabel)
        
        vietnamesePromptLabel.font = .systemFont(ofSize: 22, weight: .bold)
        vietnamesePromptLabel.textColor = .label
        vietnamesePromptLabel.textAlignment = .center
        vietnamesePromptLabel.translatesAutoresizingMaskIntoConstraints = false
        pictureCard.addSubview(vietnamesePromptLabel)
        
        var speakConfig = UIButton.Configuration.tinted()
        speakConfig.image = UIImage(systemName: "speaker.wave.2.fill")
        speakConfig.baseBackgroundColor = .systemPink
        speakConfig.baseForegroundColor = .systemPink
        speakButton.configuration = speakConfig
        speakButton.layer.cornerRadius = 18
        speakButton.clipsToBounds = true
        speakButton.translatesAutoresizingMaskIntoConstraints = false
        speakButton.addTarget(self, action: #selector(didTapSpeak), for: .touchUpInside)
        pictureCard.addSubview(speakButton)
        
        // Hint bubble
        hintBubbleView.backgroundColor = UIColor.systemPink.withAlphaComponent(0.08)
        hintBubbleView.layer.cornerRadius = 12
        hintBubbleView.layer.borderWidth = 1
        hintBubbleView.layer.borderColor = UIColor.systemPink.withAlphaComponent(0.2).cgColor
        hintBubbleView.isHidden = true
        hintBubbleView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(hintBubbleView)
        
        hintTextLabel.font = .systemFont(ofSize: 14, weight: .medium)
        hintTextLabel.textColor = .systemPink
        hintTextLabel.textAlignment = .center
        hintTextLabel.translatesAutoresizingMaskIntoConstraints = false
        hintBubbleView.addSubview(hintTextLabel)
        
        // Options Stack View (2x2 Grid)
        optionsStackView.axis = .vertical
        optionsStackView.spacing = 14
        optionsStackView.distribution = .fillEqually
        optionsStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(optionsStackView)
        
        let row1 = UIStackView()
        row1.axis = .horizontal
        row1.spacing = 14
        row1.distribution = .fillEqually
        
        let row2 = UIStackView()
        row2.axis = .horizontal
        row2.spacing = 14
        row2.distribution = .fillEqually
        
        for i in 0..<4 {
            let button = createOptionButton(tag: i)
            optionButtons.append(button)
            if i < 2 {
                row1.addArrangedSubview(button)
            } else {
                row2.addArrangedSubview(button)
            }
        }
        
        optionsStackView.addArrangedSubview(row1)
        optionsStackView.addArrangedSubview(row2)
        
        NSLayoutConstraint.activate([
            progressView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            progressView.heightAnchor.constraint(equalToConstant: 6),
            
            headerLabel.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 14),
            headerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            scoreBadgeLabel.centerYAnchor.constraint(equalTo: headerLabel.centerYAnchor),
            scoreBadgeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            scoreBadgeLabel.heightAnchor.constraint(equalToConstant: 26),
            scoreBadgeLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 80),
            
            pictureCard.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 16),
            pictureCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            pictureCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            pictureCard.heightAnchor.constraint(equalToConstant: 220),
            
            speakButton.topAnchor.constraint(equalTo: pictureCard.topAnchor, constant: 12),
            speakButton.trailingAnchor.constraint(equalTo: pictureCard.trailingAnchor, constant: -12),
            speakButton.widthAnchor.constraint(equalToConstant: 36),
            speakButton.heightAnchor.constraint(equalToConstant: 36),
            
            emojiLabel.centerXAnchor.constraint(equalTo: pictureCard.centerXAnchor),
            emojiLabel.topAnchor.constraint(equalTo: pictureCard.topAnchor, constant: 28),
            
            vietnamesePromptLabel.topAnchor.constraint(equalTo: emojiLabel.bottomAnchor, constant: 10),
            vietnamesePromptLabel.leadingAnchor.constraint(equalTo: pictureCard.leadingAnchor, constant: 16),
            vietnamesePromptLabel.trailingAnchor.constraint(equalTo: pictureCard.trailingAnchor, constant: -16),
            
            hintBubbleView.topAnchor.constraint(equalTo: pictureCard.bottomAnchor, constant: 14),
            hintBubbleView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            hintBubbleView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            hintBubbleView.heightAnchor.constraint(equalToConstant: 38),
            
            hintTextLabel.centerXAnchor.constraint(equalTo: hintBubbleView.centerXAnchor),
            hintTextLabel.centerYAnchor.constraint(equalTo: hintBubbleView.centerYAnchor),
            
            optionsStackView.topAnchor.constraint(equalTo: hintBubbleView.bottomAnchor, constant: 14),
            optionsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            optionsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            optionsStackView.heightAnchor.constraint(equalToConstant: 210)
        ])
    }
    
    private func createOptionButton(tag: Int) -> UIButton {
        let button = UIButton(type: .system)
        button.tag = tag
        button.titleLabel?.font = .systemFont(ofSize: 22, weight: .bold)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.backgroundColor = .systemBackground
        button.setTitleColor(.label, for: .normal)
        button.layer.cornerRadius = 18
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.systemGray5.cgColor
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.04
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowRadius = 5
        button.addTarget(self, action: #selector(didSelectOption(_:)), for: .touchUpInside)
        return button
    }
    
    private func startNewQuizSession() {
        score = 0
        currentIndex = 0
        // Trộn ngẫu nhiên toàn bộ danh sách nhìn hình đoán chữ
        quizList = allItems.shuffled()
        loadQuestion()
    }
    
    private func loadQuestion() {
        guard currentIndex < quizList.count else {
            showFinalResults()
            return
        }
        
        isAnswerLocked = false
        hintBubbleView.isHidden = true
        
        let correct = quizList[currentIndex]
        currentCorrectItem = correct
        
        headerLabel.text = "Câu \(currentIndex + 1) / \(quizList.count)"
        scoreBadgeLabel.text = " Điểm: \(score) "
        progressView.setProgress(Float(currentIndex + 1) / Float(quizList.count), animated: true)
        
        // Cập nhật hình ảnh & nghĩa tiếng Việt
        emojiLabel.text = correct.emoji
        vietnamesePromptLabel.text = correct.vietnameseMeaning
        
        // 3 từ gây nhiễu
        let distractors = allItems.filter { $0.id != correct.id }.shuffled().prefix(3)
        var options = Array(distractors)
        options.append(correct)
        options.shuffle()
        
        for (index, button) in optionButtons.enumerated() {
            let item = options[index]
            button.setTitle(item.japaneseWord, for: .normal)
            button.accessibilityIdentifier = item.id
            button.backgroundColor = .systemBackground
            button.layer.borderColor = UIColor.systemGray5.cgColor
            button.setTitleColor(.label, for: .normal)
            button.transform = .identity
            button.isEnabled = true
        }
        
        // Hiệu ứng nảy nhẹ hình ảnh khi sang câu mới
        emojiLabel.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.8, options: [], animations: {
            self.emojiLabel.transform = .identity
        })
    }
    
    @objc private func didTapSpeak() {
        guard let correct = currentCorrectItem else { return }
        AudioService.shared.speak(text: correct.romaji)
    }
    
    @objc private func didSelectOption(_ sender: UIButton) {
        guard !isAnswerLocked, let correct = currentCorrectItem else { return }
        isAnswerLocked = true
        
        let isCorrect = (sender.accessibilityIdentifier == correct.id)
        
        // Phát âm từ tiếng Nhật tương ứng
        AudioService.shared.speak(text: correct.romaji)
        
        hintBubbleView.isHidden = false
        hintTextLabel.text = "📖 Cách đọc: /\(correct.romaji)/"
        
        if isCorrect {
            score += 1
            scoreBadgeLabel.text = " Điểm: \(score) "
            sender.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.2)
            sender.layer.borderColor = UIColor.systemGreen.cgColor
            sender.setTitleColor(.systemGreen, for: .normal)
            AudioService.shared.playCorrectFeedback()
        } else {
            sender.backgroundColor = UIColor.systemRed.withAlphaComponent(0.2)
            sender.layer.borderColor = UIColor.systemRed.cgColor
            sender.setTitleColor(.systemRed, for: .normal)
            AudioService.shared.playWrongFeedback()
            
            // Chỉ rõ đáp án đúng
            for button in optionButtons where button.accessibilityIdentifier == correct.id {
                button.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.2)
                button.layer.borderColor = UIColor.systemGreen.cgColor
                button.setTitleColor(.systemGreen, for: .normal)
            }
        }
        
        // Chờ 1.2s rồi sang câu tiếp theo
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) { [weak self] in
            guard let self = self else { return }
            self.currentIndex += 1
            self.loadQuestion()
        }
    }
    
    private func showFinalResults() {
        let percentage = Int((Double(score) / Double(quizList.count)) * 100)
        let message = percentage >= 80 ?
            "Tuyệt vời! Bạn nhớ hình ảnh và từ vựng tiếng Nhật rất tốt (\(score)/\(quizList.count))." :
            "Bạn đạt \(score)/\(quizList.count). Hãy chơi lại để nhớ sâu hơn nhé!"
        
        let alert = UIAlertController(
            title: "Kết quả: \(percentage)%",
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Chơi lại", style: .default, handler: { [weak self] _ in
            self?.startNewQuizSession()
        }))
        alert.addAction(UIAlertAction(title: "Quay về Trang chủ", style: .cancel, handler: { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }))
        present(alert, animated: true)
    }
}
