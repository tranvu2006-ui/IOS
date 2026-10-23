//
//  VocabQuizViewController.swift
//  AppHocTiengNhat
//

import UIKit

public class VocabQuizViewController: UIViewController {
    
    private let topic: VocabTopic
    private var allWordsInTopic: [VocabWord] = []
    private var quizList: [VocabWord] = []
    private var currentIndex: Int = 0
    private var score: Int = 0
    
    private var currentCorrectWord: VocabWord?
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
    
    public init(topic: VocabTopic) {
        self.topic = topic
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.topic = VocabRepository.shared.topics[0]
        super.init(coder: coder)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        title = "Nghe: \(topic.title)"
        view.backgroundColor = .systemGroupedBackground
        
        allWordsInTopic = VocabRepository.shared.getWords(for: topic.id)
        setupUI()
        startNewQuizSession()
    }
    
    private func setupUI() {
        // Progress view
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.progressTintColor = .systemPurple
        progressView.trackTintColor = .systemGray5
        view.addSubview(progressView)
        
        // Header
        headerLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        headerLabel.textColor = .secondaryLabel
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerLabel)
        
        // Score badge
        scoreBadgeLabel.font = .systemFont(ofSize: 14, weight: .bold)
        scoreBadgeLabel.textColor = .systemPurple
        scoreBadgeLabel.backgroundColor = UIColor.systemPurple.withAlphaComponent(0.12)
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
        replayConfig.baseBackgroundColor = .systemPurple
        replayConfig.baseForegroundColor = .white
        replayConfig.cornerStyle = .capsule
        replayAudioButton.configuration = replayConfig
        replayAudioButton.translatesAutoresizingMaskIntoConstraints = false
        replayAudioButton.addTarget(self, action: #selector(didTapPlaySound), for: .touchUpInside)
        soundBoxView.addSubview(replayAudioButton)
        
        replayHintLabel.text = "Nghe phát âm và chọn nghĩa chính xác"
        replayHintLabel.font = .systemFont(ofSize: 13, weight: .medium)
        replayHintLabel.textColor = .secondaryLabel
        replayHintLabel.textAlignment = .center
        replayHintLabel.translatesAutoresizingMaskIntoConstraints = false
        soundBoxView.addSubview(replayHintLabel)
        
        // Options Stack View
        optionsStackView.axis = .vertical
        optionsStackView.spacing = 12
        optionsStackView.distribution = .fillEqually
        optionsStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(optionsStackView)
        
        for i in 0..<4 {
            let button = createOptionButton(tag: i)
            optionButtons.append(button)
            optionsStackView.addArrangedSubview(button)
        }
        
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
            
            soundBoxView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 16),
            soundBoxView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            soundBoxView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            soundBoxView.heightAnchor.constraint(equalToConstant: 150),
            
            replayAudioButton.centerXAnchor.constraint(equalTo: soundBoxView.centerXAnchor),
            replayAudioButton.centerYAnchor.constraint(equalTo: soundBoxView.centerYAnchor, constant: -12),
            replayAudioButton.widthAnchor.constraint(equalToConstant: 68),
            replayAudioButton.heightAnchor.constraint(equalToConstant: 68),
            
            replayHintLabel.topAnchor.constraint(equalTo: replayAudioButton.bottomAnchor, constant: 10),
            replayHintLabel.centerXAnchor.constraint(equalTo: soundBoxView.centerXAnchor),
            
            optionsStackView.topAnchor.constraint(equalTo: soundBoxView.bottomAnchor, constant: 20),
            optionsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            optionsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            optionsStackView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    private func createOptionButton(tag: Int) -> UIButton {
        let button = UIButton(type: .system)
        button.tag = tag
        button.backgroundColor = .systemBackground
        button.layer.cornerRadius = 16
        button.layer.borderWidth = 1.5
        button.layer.borderColor = UIColor.systemGray5.cgColor
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.05
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowRadius = 4
        button.contentHorizontalAlignment = .center
        button.addTarget(self, action: #selector(didSelectOption(_:)), for: .touchUpInside)
        button.heightAnchor.constraint(equalToConstant: 62).isActive = true
        return button
    }
    
    private func startNewQuizSession() {
        score = 0
        currentIndex = 0
        quizList = allWordsInTopic.shuffled()
        loadQuestion()
    }
    
    private func loadQuestion() {
        guard currentIndex < quizList.count else {
            showFinalResults()
            return
        }
        
        isAnswerLocked = false
        let correct = quizList[currentIndex]
        currentCorrectWord = correct
        
        headerLabel.text = "Câu \(currentIndex + 1) / \(quizList.count)"
        scoreBadgeLabel.text = " Điểm: \(score) "
        progressView.setProgress(Float(currentIndex + 1) / Float(quizList.count), animated: true)
        
        // 3 distractors
        let allWordsPool = VocabRepository.shared.vocabList
        let distractors = allWordsPool.filter { $0.id != correct.id }.shuffled().prefix(3)
        var options = Array(distractors)
        options.append(correct)
        options.shuffle()
        
        for (index, button) in optionButtons.enumerated() {
            let item = options[index]
            
            var config = UIButton.Configuration.plain()
            config.title = item.displayText
            config.subtitle = item.meaningVi
            config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
                var outgoing = incoming
                outgoing.font = UIFont.systemFont(ofSize: 18, weight: .bold)
                outgoing.foregroundColor = UIColor.label
                return outgoing
            }
            config.subtitleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
                var outgoing = incoming
                outgoing.font = UIFont.systemFont(ofSize: 13, weight: .regular)
                outgoing.foregroundColor = UIColor.secondaryLabel
                return outgoing
            }
            button.configuration = config
            button.accessibilityIdentifier = item.id
            button.backgroundColor = .systemBackground
            button.layer.borderColor = UIColor.systemGray5.cgColor
            button.isEnabled = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
            self?.didTapPlaySound()
        }
    }
    
    @objc private func didTapPlaySound() {
        guard let correct = currentCorrectWord else { return }
        
        UIView.animate(withDuration: 0.15, animations: {
            self.replayAudioButton.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)
        }) { _ in
            UIView.animate(withDuration: 0.15) {
                self.replayAudioButton.transform = .identity
            }
        }
        
        AudioService.shared.speak(text: correct.speechText)
    }
    
    @objc private func didSelectOption(_ sender: UIButton) {
        guard !isAnswerLocked, let correct = currentCorrectWord else { return }
        isAnswerLocked = true
        
        let isCorrect = (sender.accessibilityIdentifier == correct.id)
        
        if isCorrect {
            score += 1
            scoreBadgeLabel.text = " Điểm: \(score) "
            sender.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.2)
            sender.layer.borderColor = UIColor.systemGreen.cgColor
            AudioService.shared.playCorrectFeedback()
        } else {
            sender.backgroundColor = UIColor.systemRed.withAlphaComponent(0.2)
            sender.layer.borderColor = UIColor.systemRed.cgColor
            AudioService.shared.playWrongFeedback()
            
            for button in optionButtons where button.accessibilityIdentifier == correct.id {
                button.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.2)
                button.layer.borderColor = UIColor.systemGreen.cgColor
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            guard let self = self else { return }
            self.currentIndex += 1
            self.loadQuestion()
        }
    }
    
    private func showFinalResults() {
        ProgressService.shared.recordQuizResult(correct: score, total: quizList.count)
        
        let percentage = Int((Double(score) / Double(quizList.count)) * 100)
        let message = percentage >= 80 ?
            "Rất xuất sắc! Bạn đã ghi nhớ chuẩn nghĩa từ vựng (\(score)/\(quizList.count))." :
            "Bạn đạt \(score)/\(quizList.count). Hãy lật Flashcard chủ đề này để củng cố thêm nhé!"
        
        let alert = UIAlertController(
            title: "Kết quả: \(percentage)%",
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Làm lại bài", style: .default, handler: { [weak self] _ in
            self?.startNewQuizSession()
        }))
        alert.addAction(UIAlertAction(title: "Quay lại Menu", style: .cancel, handler: { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }))
        present(alert, animated: true)
    }
}
