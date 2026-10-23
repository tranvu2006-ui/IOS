//
//  AudioQuizViewController.swift
//  AppHocTiengNhat
//

import UIKit

public class AudioQuizViewController: UIViewController {
    
    private let kanaType: KanaType
    private var allCharacters: [KanaCharacter] = []
    private var quizList: [KanaCharacter] = []
    private var currentIndex: Int = 0
    private var score: Int = 0
    private let totalQuestions: Int = 10
    
    private var currentCorrectCharacter: KanaCharacter?
    private var optionButtons: [UIButton] = []
    private var isAnswerLocked: Bool = false
    
    // UI Elements
    private let progressView = UIProgressView(progressViewStyle: .default)
    private let headerLabel = UILabel()
    private let scoreBadgeLabel = UILabel()
    
    private let soundBoxView = UIView()
    private let replayAudioButton = UIButton(type: .system)
    private let replayHintLabel = UILabel()
    
    private let optionsStackView = UIStackView()
    
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
        title = "Luyện nghe \(kanaType.rawValue)"
        view.backgroundColor = .systemGroupedBackground
        
        allCharacters = KanaRepository.shared.getCharacters(for: kanaType)
        setupUI()
        startNewQuizSession()
    }
    
    private func setupUI() {
        // Progress view
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.progressTintColor = .systemTeal
        progressView.trackTintColor = .systemGray5
        view.addSubview(progressView)
        
        // Header
        headerLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        headerLabel.textColor = .secondaryLabel
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerLabel)
        
        // Score badge
        scoreBadgeLabel.font = .systemFont(ofSize: 14, weight: .bold)
        scoreBadgeLabel.textColor = .systemGreen
        scoreBadgeLabel.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.12)
        scoreBadgeLabel.layer.cornerRadius = 8
        scoreBadgeLabel.clipsToBounds = true
        scoreBadgeLabel.textAlignment = .center
        scoreBadgeLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scoreBadgeLabel)
        
        // Sound Box View
        soundBoxView.backgroundColor = .systemBackground
        soundBoxView.layer.cornerRadius = 20
        soundBoxView.layer.borderWidth = 1
        soundBoxView.layer.borderColor = UIColor.systemGray5.cgColor
        soundBoxView.layer.shadowColor = UIColor.black.cgColor
        soundBoxView.layer.shadowOpacity = 0.08
        soundBoxView.layer.shadowOffset = CGSize(width: 0, height: 4)
        soundBoxView.layer.shadowRadius = 10
        soundBoxView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(soundBoxView)
        
        var replayConfig = UIButton.Configuration.filled()
        replayConfig.image = UIImage(systemName: "speaker.wave.3.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 32, weight: .bold))
        replayConfig.baseBackgroundColor = .systemTeal
        replayConfig.baseForegroundColor = .white
        replayConfig.cornerStyle = .capsule
        replayAudioButton.configuration = replayConfig
        replayAudioButton.translatesAutoresizingMaskIntoConstraints = false
        replayAudioButton.addTarget(self, action: #selector(didTapPlaySound), for: .touchUpInside)
        soundBoxView.addSubview(replayAudioButton)
        
        replayHintLabel.text = "Chạm để nghe lại âm thanh"
        replayHintLabel.font = .systemFont(ofSize: 13, weight: .medium)
        replayHintLabel.textColor = .secondaryLabel
        replayHintLabel.textAlignment = .center
        replayHintLabel.translatesAutoresizingMaskIntoConstraints = false
        soundBoxView.addSubview(replayHintLabel)
        
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
            scoreBadgeLabel.heightAnchor.constraint(equalToConstant: 28),
            scoreBadgeLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 80),
            
            soundBoxView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 24),
            soundBoxView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            soundBoxView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            soundBoxView.heightAnchor.constraint(equalToConstant: 160),
            
            replayAudioButton.centerXAnchor.constraint(equalTo: soundBoxView.centerXAnchor),
            replayAudioButton.centerYAnchor.constraint(equalTo: soundBoxView.centerYAnchor, constant: -12),
            replayAudioButton.widthAnchor.constraint(equalToConstant: 72),
            replayAudioButton.heightAnchor.constraint(equalToConstant: 72),
            
            replayHintLabel.topAnchor.constraint(equalTo: replayAudioButton.bottomAnchor, constant: 12),
            replayHintLabel.centerXAnchor.constraint(equalTo: soundBoxView.centerXAnchor),
            
            optionsStackView.topAnchor.constraint(equalTo: soundBoxView.bottomAnchor, constant: 30),
            optionsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            optionsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            optionsStackView.heightAnchor.constraint(equalToConstant: 240)
        ])
    }
    
    private func createOptionButton(tag: Int) -> UIButton {
        let button = UIButton(type: .system)
        button.tag = tag
        button.titleLabel?.font = .systemFont(ofSize: 38, weight: .bold)
        button.backgroundColor = .systemBackground
        button.setTitleColor(.label, for: .normal)
        button.layer.cornerRadius = 18
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.systemGray5.cgColor
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.05
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowRadius = 5
        button.addTarget(self, action: #selector(didSelectOption(_:)), for: .touchUpInside)
        return button
    }
    
    private func startNewQuizSession() {
        score = 0
        currentIndex = 0
        quizList = Array(allCharacters.shuffled().prefix(totalQuestions))
        loadQuestion()
    }
    
    private func loadQuestion() {
        guard currentIndex < quizList.count else {
            showFinalResults()
            return
        }
        
        isAnswerLocked = false
        let correct = quizList[currentIndex]
        currentCorrectCharacter = correct
        
        // Progress & Headers
        headerLabel.text = "Câu \(currentIndex + 1) / \(quizList.count)"
        scoreBadgeLabel.text = " Điểm: \(score) "
        progressView.setProgress(Float(currentIndex + 1) / Float(quizList.count), animated: true)
        
        // Generate 3 distractors
        let distractors = allCharacters.filter { $0.id != correct.id }.shuffled().prefix(3)
        var options = Array(distractors)
        options.append(correct)
        options.shuffle()
        
        for (index, button) in optionButtons.enumerated() {
            let optionItem = options[index]
            button.setTitle(optionItem.character, for: .normal)
            button.accessibilityIdentifier = optionItem.id
            button.backgroundColor = .systemBackground
            button.layer.borderColor = UIColor.systemGray5.cgColor
            button.setTitleColor(.label, for: .normal)
            button.transform = .identity
            button.isEnabled = true
        }
        
        // Tự động phát âm thanh sau 0.2s
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
            self?.didTapPlaySound()
        }
    }
    
    @objc private func didTapPlaySound() {
        guard let correct = currentCorrectCharacter else { return }
        
        // Hiệu ứng scale nút phát âm
        UIView.animate(withDuration: 0.15, animations: {
            self.replayAudioButton.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)
        }) { _ in
            UIView.animate(withDuration: 0.15) {
                self.replayAudioButton.transform = .identity
            }
        }
        
        AudioService.shared.speak(text: correct.character)
    }
    
    @objc private func didSelectOption(_ sender: UIButton) {
        guard !isAnswerLocked, let correct = currentCorrectCharacter else { return }
        isAnswerLocked = true
        
        let isCorrect = (sender.title(for: .normal) == correct.character)
        
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
            for button in optionButtons where button.title(for: .normal) == correct.character {
                button.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.2)
                button.layer.borderColor = UIColor.systemGreen.cgColor
                button.setTitleColor(.systemGreen, for: .normal)
            }
        }
        
        // Chờ 0.9s rồi sang câu tiếp theo
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) { [weak self] in
            guard let self = self else { return }
            self.currentIndex += 1
            self.loadQuestion()
        }
    }
    
    private func showFinalResults() {
        let percentage = Int((Double(score) / Double(quizList.count)) * 100)
        let message: String
        if percentage >= 90 {
            message = "Xuất sắc! Bạn đã nghe và nhận diện rất chuẩn (\(score)/\(quizList.count))."
        } else if percentage >= 60 {
            message = "Khá tốt! Bạn đạt \(score)/\(quizList.count). Luyện tập thêm một chút nữa nhé!"
        } else {
            message = "Bạn đạt \(score)/\(quizList.count). Hãy dùng Flashcard để ghi nhớ kỹ hơn nhé!"
        }
        
        let alert = UIAlertController(
            title: "Kết quả: \(percentage)%",
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Làm lại bài này", style: .default, handler: { [weak self] _ in
            self?.startNewQuizSession()
        }))
        alert.addAction(UIAlertAction(title: "Quay lại Menu", style: .cancel, handler: { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }))
        present(alert, animated: true)
    }
}
