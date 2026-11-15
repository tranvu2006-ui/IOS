//
//  VocabTestViewController.swift
//  AppHocTiengNhat
//

import UIKit

public class VocabTestViewController: UIViewController {
    
    private let lessonNumber: Int?
    private let customTitle: String?
    private let customWordsPool: [VocabWord]?
    
    private var testList: [VocabWord] = []
    private var currentIndex: Int = 0
    private var score: Int = 0
    private var isAnswerLocked: Bool = false
    private var wrongWords: [VocabWord] = []
    
    // UI Elements
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let progressView = UIProgressView(progressViewStyle: .default)
    private let counterLabel = UILabel()
    private let scoreBadgeLabel = UILabel()
    
    private let wordCard = UIView()
    private let promptLabel = UILabel()
    private let mainWordLabel = UILabel()
    private let subWordLabel = UILabel()
    private let speakButton = UIButton(type: .system)
    
    private let optionsStackView = UIStackView()
    private var optionButtons: [UIButton] = []
    
    private let answerDetailCard = UIView()
    private let answerDetailLabel = UILabel()
    private let nextButton = UIButton(type: .system)
    
    private var currentCorrectOptionIndex: Int = 0
    
    public init(lessonNumber: Int? = nil, lessonTitle: String? = nil, customWords: [VocabWord]? = nil) {
        self.lessonNumber = lessonNumber
        self.customWordsPool = customWords
        if let customWords = customWords {
            self.customTitle = "Kiểm tra: Từ chưa nhớ (\(customWords.count) từ)"
        } else if let title = lessonTitle {
            self.customTitle = "Kiểm tra từ: \(title)"
        } else {
            self.customTitle = "Kiểm tra Từ vựng N5"
        }
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.lessonNumber = nil
        self.customTitle = "Kiểm tra Từ vựng N5"
        self.customWordsPool = nil
        super.init(coder: coder)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        title = customTitle ?? "Kiểm tra Từ vựng N5"
        view.backgroundColor = .systemGroupedBackground
        
        setupUI()
        startTestSession()
    }
    
    private func startTestSession() {
        score = 0
        currentIndex = 0
        wrongWords.removeAll()
        
        let pool: [VocabWord]
        if let custom = customWordsPool, !custom.isEmpty {
            pool = custom
        } else if let lesson = lessonNumber {
            let byLesson = VocabRepository.shared.getWords(forLesson: lesson)
            pool = byLesson.isEmpty ? VocabRepository.shared.vocabList : byLesson
        } else {
            pool = VocabRepository.shared.vocabList
        }
        
        testList = Array(pool.shuffled().prefix(10))
        showQuestion(at: currentIndex)
    }
    
    private func setupUI() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        // Progress view
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.progressTintColor = .systemPurple
        progressView.trackTintColor = .systemGray5
        contentView.addSubview(progressView)
        
        // Counter & Score labels
        counterLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        counterLabel.textColor = .secondaryLabel
        counterLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(counterLabel)
        
        scoreBadgeLabel.font = .systemFont(ofSize: 13, weight: .bold)
        scoreBadgeLabel.textColor = .systemPurple
        scoreBadgeLabel.backgroundColor = UIColor.systemPurple.withAlphaComponent(0.12)
        scoreBadgeLabel.layer.cornerRadius = 8
        scoreBadgeLabel.clipsToBounds = true
        scoreBadgeLabel.textAlignment = .center
        scoreBadgeLabel.text = " Điểm: 0 "
        scoreBadgeLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(scoreBadgeLabel)
        
        // Word Card
        wordCard.backgroundColor = .systemBackground
        wordCard.layer.cornerRadius = 20
        wordCard.layer.borderWidth = 1
        wordCard.layer.borderColor = UIColor.systemGray5.cgColor
        wordCard.layer.shadowColor = UIColor.black.cgColor
        wordCard.layer.shadowOpacity = 0.05
        wordCard.layer.shadowOffset = CGSize(width: 0, height: 4)
        wordCard.layer.shadowRadius = 8
        wordCard.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(wordCard)
        
        promptLabel.text = "CHỌN NGHĨA TIẾNG VIỆT ĐÚNG"
        promptLabel.font = .systemFont(ofSize: 11, weight: .bold)
        promptLabel.textColor = .systemPurple
        promptLabel.translatesAutoresizingMaskIntoConstraints = false
        wordCard.addSubview(promptLabel)
        
        mainWordLabel.font = .systemFont(ofSize: 32, weight: .bold)
        mainWordLabel.textColor = .label
        mainWordLabel.textAlignment = .center
        mainWordLabel.translatesAutoresizingMaskIntoConstraints = false
        wordCard.addSubview(mainWordLabel)
        
        subWordLabel.font = .systemFont(ofSize: 16, weight: .medium)
        subWordLabel.textColor = .secondaryLabel
        subWordLabel.textAlignment = .center
        subWordLabel.translatesAutoresizingMaskIntoConstraints = false
        wordCard.addSubview(subWordLabel)
        
        speakButton.setImage(UIImage(systemName: "speaker.wave.2.fill"), for: .normal)
        speakButton.tintColor = .systemPurple
        speakButton.backgroundColor = UIColor.systemPurple.withAlphaComponent(0.12)
        speakButton.layer.cornerRadius = 18
        speakButton.translatesAutoresizingMaskIntoConstraints = false
        speakButton.addTarget(self, action: #selector(didTapSpeak), for: .touchUpInside)
        wordCard.addSubview(speakButton)
        
        // Options Stack View
        optionsStackView.axis = .vertical
        optionsStackView.spacing = 10
        optionsStackView.distribution = .fillEqually
        optionsStackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(optionsStackView)
        
        for i in 0..<4 {
            let btn = UIButton(type: .system)
            btn.layer.cornerRadius = 14
            btn.layer.borderWidth = 1.5
            btn.layer.borderColor = UIColor.systemGray4.cgColor
            btn.backgroundColor = .systemBackground
            btn.setTitleColor(.label, for: .normal)
            btn.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
            btn.titleLabel?.numberOfLines = 2
            btn.titleLabel?.textAlignment = .center
            btn.tag = i
            btn.translatesAutoresizingMaskIntoConstraints = false
            btn.heightAnchor.constraint(equalToConstant: 52).isActive = true
            btn.addTarget(self, action: #selector(didSelectOption(_:)), for: .touchUpInside)
            optionButtons.append(btn)
            optionsStackView.addArrangedSubview(btn)
        }
        
        // Answer detail card
        answerDetailCard.backgroundColor = UIColor.systemPurple.withAlphaComponent(0.08)
        answerDetailCard.layer.cornerRadius = 14
        answerDetailCard.layer.borderWidth = 1
        answerDetailCard.layer.borderColor = UIColor.systemPurple.withAlphaComponent(0.25).cgColor
        answerDetailCard.isHidden = true
        answerDetailCard.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(answerDetailCard)
        
        answerDetailLabel.font = .systemFont(ofSize: 13, weight: .regular)
        answerDetailLabel.textColor = .label
        answerDetailLabel.numberOfLines = 0
        answerDetailLabel.translatesAutoresizingMaskIntoConstraints = false
        answerDetailCard.addSubview(answerDetailLabel)
        
        // Next button
        var nextConfig = UIButton.Configuration.filled()
        nextConfig.title = "Câu tiếp theo"
        nextConfig.image = UIImage(systemName: "arrow.right")
        nextConfig.imagePlacement = .trailing
        nextConfig.imagePadding = 6
        nextConfig.baseBackgroundColor = .systemPurple
        nextConfig.baseForegroundColor = .white
        nextButton.configuration = nextConfig
        nextButton.layer.cornerRadius = 16
        nextButton.clipsToBounds = true
        nextButton.isHidden = true
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
        contentView.addSubview(nextButton)
        
        NSLayoutConstraint.activate([
            progressView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14),
            progressView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            progressView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            progressView.heightAnchor.constraint(equalToConstant: 6),
            
            counterLabel.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 12),
            counterLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            scoreBadgeLabel.centerYAnchor.constraint(equalTo: counterLabel.centerYAnchor),
            scoreBadgeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            scoreBadgeLabel.heightAnchor.constraint(equalToConstant: 26),
            scoreBadgeLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 80),
            
            wordCard.topAnchor.constraint(equalTo: counterLabel.bottomAnchor, constant: 14),
            wordCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            wordCard.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            promptLabel.topAnchor.constraint(equalTo: wordCard.topAnchor, constant: 14),
            promptLabel.leadingAnchor.constraint(equalTo: wordCard.leadingAnchor, constant: 16),
            
            speakButton.topAnchor.constraint(equalTo: wordCard.topAnchor, constant: 12),
            speakButton.trailingAnchor.constraint(equalTo: wordCard.trailingAnchor, constant: -16),
            speakButton.widthAnchor.constraint(equalToConstant: 36),
            speakButton.heightAnchor.constraint(equalToConstant: 36),
            
            mainWordLabel.topAnchor.constraint(equalTo: promptLabel.bottomAnchor, constant: 12),
            mainWordLabel.leadingAnchor.constraint(equalTo: wordCard.leadingAnchor, constant: 16),
            mainWordLabel.trailingAnchor.constraint(equalTo: wordCard.trailingAnchor, constant: -16),
            
            subWordLabel.topAnchor.constraint(equalTo: mainWordLabel.bottomAnchor, constant: 6),
            subWordLabel.leadingAnchor.constraint(equalTo: wordCard.leadingAnchor, constant: 16),
            subWordLabel.trailingAnchor.constraint(equalTo: wordCard.trailingAnchor, constant: -16),
            subWordLabel.bottomAnchor.constraint(equalTo: wordCard.bottomAnchor, constant: -18),
            
            optionsStackView.topAnchor.constraint(equalTo: wordCard.bottomAnchor, constant: 20),
            optionsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            optionsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            answerDetailCard.topAnchor.constraint(equalTo: optionsStackView.bottomAnchor, constant: 16),
            answerDetailCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            answerDetailCard.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            answerDetailLabel.topAnchor.constraint(equalTo: answerDetailCard.topAnchor, constant: 12),
            answerDetailLabel.leadingAnchor.constraint(equalTo: answerDetailCard.leadingAnchor, constant: 14),
            answerDetailLabel.trailingAnchor.constraint(equalTo: answerDetailCard.trailingAnchor, constant: -14),
            answerDetailLabel.bottomAnchor.constraint(equalTo: answerDetailCard.bottomAnchor, constant: -12),
            
            nextButton.topAnchor.constraint(equalTo: answerDetailCard.bottomAnchor, constant: 20),
            nextButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            nextButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            nextButton.heightAnchor.constraint(equalToConstant: 48),
            nextButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30)
        ])
    }
    
    private func showQuestion(at index: Int) {
        guard index < testList.count else {
            showFinalResult()
            return
        }
        
        isAnswerLocked = false
        answerDetailCard.isHidden = true
        nextButton.isHidden = true
        
        let target = testList[index]
        mainWordLabel.text = target.displayText
        subWordLabel.text = target.kanji != nil ? "\(target.kana)  •  /\(target.romaji)/" : "/\(target.romaji)/"
        
        counterLabel.text = "Câu \(index + 1) / \(testList.count)"
        scoreBadgeLabel.text = " Điểm: \(score) / 100 "
        progressView.setProgress(Float(index + 1) / Float(testList.count), animated: true)
        
        // Prepare 4 choices (1 correct + 3 distractor meanings)
        var optionsPool = VocabRepository.shared.vocabList.filter { $0.id != target.id }.shuffled()
        var choices: [String] = [target.meaningVi]
        for item in optionsPool {
            if !choices.contains(item.meaningVi) {
                choices.append(item.meaningVi)
            }
            if choices.count == 4 { break }
        }
        choices.shuffle()
        currentCorrectOptionIndex = choices.firstIndex(of: target.meaningVi) ?? 0
        
        for (i, btn) in optionButtons.enumerated() {
            if i < choices.count {
                btn.isHidden = false
                btn.setTitle(choices[i], for: .normal)
                btn.backgroundColor = .systemBackground
                btn.layer.borderColor = UIColor.systemGray4.cgColor
                btn.setTitleColor(.label, for: .normal)
                btn.isEnabled = true
            } else {
                btn.isHidden = true
            }
        }
        
        var detail = "📖 Nghĩa đúng: \(target.meaningVi)"
        if let jp = target.exampleJp, let vi = target.exampleVi {
            detail += "\nVí dụ: \(jp)\n(\(vi))"
        }
        answerDetailLabel.text = detail
        
        AudioService.shared.speak(text: target.speechText)
    }
    
    @objc private func didTapSpeak() {
        guard currentIndex < testList.count else { return }
        let target = testList[currentIndex]
        AudioService.shared.speak(text: target.speechText)
    }
    
    @objc private func didSelectOption(_ sender: UIButton) {
        guard !isAnswerLocked, currentIndex < testList.count else { return }
        isAnswerLocked = true
        
        let target = testList[currentIndex]
        let isCorrect = (sender.tag == currentCorrectOptionIndex)
        
        for btn in optionButtons {
            btn.isEnabled = false
        }
        
        if isCorrect {
            sender.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.2)
            sender.layer.borderColor = UIColor.systemGreen.cgColor
            sender.setTitleColor(.systemGreen, for: .normal)
            score += 10
            AudioService.shared.playCorrectFeedback()
        } else {
            sender.backgroundColor = UIColor.systemRed.withAlphaComponent(0.2)
            sender.layer.borderColor = UIColor.systemRed.cgColor
            sender.setTitleColor(.systemRed, for: .normal)
            
            // Highlight the correct option
            if currentCorrectOptionIndex < optionButtons.count {
                let correctBtn = optionButtons[currentCorrectOptionIndex]
                correctBtn.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.2)
                correctBtn.layer.borderColor = UIColor.systemGreen.cgColor
                correctBtn.setTitleColor(.systemGreen, for: .normal)
            }
            
            // AUTO ADD TO "CHƯA NHỚ, CHƯA THUỘC" LIST
            wrongWords.append(target)
            ProgressService.shared.markWordForReview(id: target.id)
            AudioService.shared.playWrongFeedback()
        }
        
        scoreBadgeLabel.text = " Điểm: \(score) / 100 "
        answerDetailCard.isHidden = false
        nextButton.isHidden = false
        nextButton.setTitle(currentIndex == testList.count - 1 ? "Xem kết quả thi 🏆" : "Câu tiếp theo", for: .normal)
    }
    
    @objc private func didTapNext() {
        currentIndex += 1
        showQuestion(at: currentIndex)
    }
    
    private func showFinalResult() {
        ProgressService.shared.recordVocabTestScore(score: score)
        ProgressService.shared.recordQuizResult(correct: score / 10, total: testList.count)
        
        let titleBadge: String
        var message = "Bạn đạt \(score)/100 điểm."
        if score >= 90 {
            titleBadge = "🏆 Xuất sắc!"
            message += " Trí nhớ từ vựng tuyệt vời!"
        } else if score >= 70 {
            titleBadge = "👏 Khá giỏi!"
            message += " Hãy tiếp tục duy trì nhé!"
        } else {
            titleBadge = "💪 Cần luyện thêm!"
            message += " Các từ làm sai đã được tự động thêm vào 'Danh sách từ chưa nhớ' để bạn ôn lại."
        }
        
        if !wrongWords.isEmpty {
            message += "\n\n⚠️ Có \(wrongWords.count) từ làm sai đã lưu vào Sổ tay ôn tập."
        }
        
        let alert = UIAlertController(title: titleBadge, message: message, preferredStyle: .alert)
        
        if !wrongWords.isEmpty {
            alert.addAction(UIAlertAction(title: "Mở Sổ tay từ chưa nhớ", style: .default, handler: { [weak self] _ in
                let vc = NeedReviewWordsViewController()
                self?.navigationController?.pushViewController(vc, animated: true)
            }))
        }
        
        alert.addAction(UIAlertAction(title: "Làm lại bài thi", style: .default, handler: { [weak self] _ in
            self?.startTestSession()
        }))
        alert.addAction(UIAlertAction(title: "Hoàn tất", style: .cancel, handler: { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }))
        present(alert, animated: true)
    }
}
