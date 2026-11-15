//
//  JLPTMockTestViewController.swift
//  AppHocTiengNhat
//

import UIKit

public class JLPTMockTestViewController: UIViewController {
    
    private var currentLevel: JLPTLevel = .n5
    private var questions: [JLPTQuestion] = []
    private var currentIndex: Int = 0
    private var userAnswers: [Int?] = []
    
    // Countdown Timer (25 phút = 1500 giây)
    private var timer: Timer?
    private var remainingSeconds: Int = 25 * 60
    private let totalTimeSeconds: Int = 25 * 60
    
    // UI Elements
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let levelSegmentedControl = UISegmentedControl(items: ["JLPT N5 (25 phút)", "JLPT N4 (25 phút)"])
    
    // Top Bar (Timer & Progress)
    private let timerContainer = UIView()
    private let timerIcon = UIImageView(image: UIImage(systemName: "stopwatch.fill"))
    private let timerLabel = UILabel()
    private let submitButton = UIButton(type: .system)
    
    private let progressView = UIProgressView(progressViewStyle: .default)
    private let questionCounterLabel = UILabel()
    private let sectionBadgeLabel = UILabel()
    
    // Question Card
    private let questionCard = UIView()
    private let promptLabel = UILabel()
    private let contentLabel = UILabel()
    private let listenAudioButton = UIButton(type: .system)
    
    // Options
    private let optionsStackView = UIStackView()
    private var optionButtons: [UIButton] = []
    
    // Bottom Navigation
    private let prevButton = UIButton(type: .system)
    private let nextButton = UIButton(type: .system)
    
    public init(level: JLPTLevel = .n5) {
        self.currentLevel = level
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.currentLevel = .n5
        super.init(coder: coder)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        title = "Thi thử JLPT Mô phỏng"
        view.backgroundColor = .systemGroupedBackground
        navigationItem.largeTitleDisplayMode = .never
        
        setupUI()
        startTest(for: currentLevel)
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopTimer()
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
        
        // Level Segmented Control
        levelSegmentedControl.selectedSegmentIndex = currentLevel == .n5 ? 0 : 1
        levelSegmentedControl.selectedSegmentTintColor = .systemIndigo
        levelSegmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 13, weight: .bold)], for: .selected)
        levelSegmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.label, .font: UIFont.systemFont(ofSize: 13, weight: .medium)], for: .normal)
        levelSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        levelSegmentedControl.addTarget(self, action: #selector(didChangeLevel), for: .valueChanged)
        contentView.addSubview(levelSegmentedControl)
        
        // Timer Container
        timerContainer.backgroundColor = .secondarySystemGroupedBackground
        timerContainer.layer.cornerRadius = 14
        timerContainer.layer.borderWidth = 1
        timerContainer.layer.borderColor = UIColor.systemGray5.cgColor
        timerContainer.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(timerContainer)
        
        timerIcon.tintColor = .systemRed
        timerIcon.translatesAutoresizingMaskIntoConstraints = false
        timerContainer.addSubview(timerIcon)
        
        timerLabel.text = "25:00"
        timerLabel.font = .monospacedDigitSystemFont(ofSize: 16, weight: .bold)
        timerLabel.textColor = .systemRed
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        timerContainer.addSubview(timerLabel)
        
        var submitConfig = UIButton.Configuration.filled()
        submitConfig.title = "Nộp bài"
        submitConfig.baseBackgroundColor = .systemIndigo
        submitConfig.baseForegroundColor = .white
        submitConfig.cornerStyle = .capsule
        submitButton.configuration = submitConfig
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.addTarget(self, action: #selector(confirmSubmit), for: .touchUpInside)
        timerContainer.addSubview(submitButton)
        
        // Progress view
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.progressTintColor = .systemIndigo
        progressView.trackTintColor = .systemGray5
        contentView.addSubview(progressView)
        
        // Counter & Badge
        questionCounterLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        questionCounterLabel.textColor = .secondaryLabel
        questionCounterLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(questionCounterLabel)
        
        sectionBadgeLabel.font = .systemFont(ofSize: 11, weight: .bold)
        sectionBadgeLabel.layer.cornerRadius = 6
        sectionBadgeLabel.clipsToBounds = true
        sectionBadgeLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(sectionBadgeLabel)
        
        // Question Card
        questionCard.backgroundColor = .systemBackground
        questionCard.layer.cornerRadius = 18
        questionCard.layer.borderWidth = 1.5
        questionCard.layer.borderColor = UIColor.systemGray5.cgColor
        questionCard.layer.shadowColor = UIColor.black.cgColor
        questionCard.layer.shadowOpacity = 0.06
        questionCard.layer.shadowOffset = CGSize(width: 0, height: 4)
        questionCard.layer.shadowRadius = 8
        questionCard.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(questionCard)
        
        promptLabel.font = .systemFont(ofSize: 13, weight: .medium)
        promptLabel.textColor = .secondaryLabel
        promptLabel.numberOfLines = 0
        promptLabel.translatesAutoresizingMaskIntoConstraints = false
        questionCard.addSubview(promptLabel)
        
        contentLabel.font = .systemFont(ofSize: 20, weight: .bold)
        contentLabel.textColor = .label
        contentLabel.numberOfLines = 0
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        questionCard.addSubview(contentLabel)
        
        var audioConfig = UIButton.Configuration.tinted()
        audioConfig.image = UIImage(systemName: "speaker.wave.3.fill")
        audioConfig.title = "Nghe âm thanh"
        audioConfig.imagePadding = 6
        audioConfig.baseBackgroundColor = .systemIndigo
        audioConfig.baseForegroundColor = .systemIndigo
        listenAudioButton.configuration = audioConfig
        listenAudioButton.layer.cornerRadius = 18
        listenAudioButton.clipsToBounds = true
        listenAudioButton.translatesAutoresizingMaskIntoConstraints = false
        listenAudioButton.addTarget(self, action: #selector(didTapPlayAudio), for: .touchUpInside)
        questionCard.addSubview(listenAudioButton)
        
        // Options Stack View
        optionsStackView.axis = .vertical
        optionsStackView.spacing = 10
        optionsStackView.distribution = .fillEqually
        optionsStackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(optionsStackView)
        
        for i in 0..<4 {
            let btn = UIButton(type: .system)
            btn.tag = i
            btn.layer.cornerRadius = 14
            btn.layer.borderWidth = 1.5
            btn.layer.borderColor = UIColor.systemGray4.cgColor
            btn.backgroundColor = .systemBackground
            btn.contentHorizontalAlignment = .leading
            btn.translatesAutoresizingMaskIntoConstraints = false
            btn.addTarget(self, action: #selector(didSelectOption(_:)), for: .touchUpInside)
            optionButtons.append(btn)
            optionsStackView.addArrangedSubview(btn)
        }
        
        // Navigation buttons
        var pConfig = UIButton.Configuration.filled()
        pConfig.title = "Câu trước"
        pConfig.image = UIImage(systemName: "chevron.left")
        pConfig.imagePadding = 6
        pConfig.baseBackgroundColor = .secondarySystemGroupedBackground
        pConfig.baseForegroundColor = .label
        prevButton.configuration = pConfig
        prevButton.layer.cornerRadius = 14
        prevButton.translatesAutoresizingMaskIntoConstraints = false
        prevButton.addTarget(self, action: #selector(didTapPrevious), for: .touchUpInside)
        
        var nConfig = UIButton.Configuration.filled()
        nConfig.title = "Câu tiếp"
        nConfig.image = UIImage(systemName: "chevron.right")
        nConfig.imagePlacement = .trailing
        nConfig.imagePadding = 6
        nConfig.baseBackgroundColor = .systemIndigo
        nConfig.baseForegroundColor = .white
        nextButton.configuration = nConfig
        nextButton.layer.cornerRadius = 14
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
        
        let navStack = UIStackView(arrangedSubviews: [prevButton, nextButton])
        navStack.axis = .horizontal
        navStack.distribution = .fillEqually
        navStack.spacing = 16
        navStack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(navStack)
        
        NSLayoutConstraint.activate([
            levelSegmentedControl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            levelSegmentedControl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            levelSegmentedControl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            levelSegmentedControl.heightAnchor.constraint(equalToConstant: 34),
            
            timerContainer.topAnchor.constraint(equalTo: levelSegmentedControl.bottomAnchor, constant: 12),
            timerContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            timerContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            timerContainer.heightAnchor.constraint(equalToConstant: 48),
            
            timerIcon.leadingAnchor.constraint(equalTo: timerContainer.leadingAnchor, constant: 14),
            timerIcon.centerYAnchor.constraint(equalTo: timerContainer.centerYAnchor),
            timerIcon.widthAnchor.constraint(equalToConstant: 20),
            timerIcon.heightAnchor.constraint(equalToConstant: 20),
            
            timerLabel.leadingAnchor.constraint(equalTo: timerIcon.trailingAnchor, constant: 8),
            timerLabel.centerYAnchor.constraint(equalTo: timerContainer.centerYAnchor),
            
            submitButton.trailingAnchor.constraint(equalTo: timerContainer.trailingAnchor, constant: -10),
            submitButton.centerYAnchor.constraint(equalTo: timerContainer.centerYAnchor),
            submitButton.heightAnchor.constraint(equalToConstant: 32),
            submitButton.widthAnchor.constraint(equalToConstant: 86),
            
            progressView.topAnchor.constraint(equalTo: timerContainer.bottomAnchor, constant: 12),
            progressView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            progressView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            progressView.heightAnchor.constraint(equalToConstant: 6),
            
            questionCounterLabel.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 10),
            questionCounterLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            sectionBadgeLabel.centerYAnchor.constraint(equalTo: questionCounterLabel.centerYAnchor),
            sectionBadgeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            sectionBadgeLabel.heightAnchor.constraint(equalToConstant: 24),
            
            questionCard.topAnchor.constraint(equalTo: questionCounterLabel.bottomAnchor, constant: 12),
            questionCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            questionCard.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            promptLabel.topAnchor.constraint(equalTo: questionCard.topAnchor, constant: 14),
            promptLabel.leadingAnchor.constraint(equalTo: questionCard.leadingAnchor, constant: 16),
            promptLabel.trailingAnchor.constraint(equalTo: questionCard.trailingAnchor, constant: -16),
            
            contentLabel.topAnchor.constraint(equalTo: promptLabel.bottomAnchor, constant: 10),
            contentLabel.leadingAnchor.constraint(equalTo: questionCard.leadingAnchor, constant: 16),
            contentLabel.trailingAnchor.constraint(equalTo: questionCard.trailingAnchor, constant: -16),
            
            listenAudioButton.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 12),
            listenAudioButton.leadingAnchor.constraint(equalTo: questionCard.leadingAnchor, constant: 16),
            listenAudioButton.heightAnchor.constraint(equalToConstant: 36),
            listenAudioButton.bottomAnchor.constraint(equalTo: questionCard.bottomAnchor, constant: -14),
            
            optionsStackView.topAnchor.constraint(equalTo: questionCard.bottomAnchor, constant: 16),
            optionsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            optionsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            navStack.topAnchor.constraint(equalTo: optionsStackView.bottomAnchor, constant: 20),
            navStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            navStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            navStack.heightAnchor.constraint(equalToConstant: 48),
            navStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
        ])
    }
    
    private func startTest(for level: JLPTLevel) {
        currentLevel = level
        questions = JLPTMockTestRepository.shared.generateMockTest(level: level)
        userAnswers = Array(repeating: nil, count: questions.count)
        currentIndex = 0
        remainingSeconds = totalTimeSeconds
        
        startTimer()
        renderQuestion(at: currentIndex)
    }
    
    @objc private func didChangeLevel() {
        let selectedLvl: JLPTLevel = levelSegmentedControl.selectedSegmentIndex == 0 ? .n5 : .n4
        if selectedLvl != currentLevel {
            let alert = UIAlertController(
                title: "Đổi cấp độ đề thi?",
                message: "Bạn có chắc chắn muốn chuyển sang đề thi \(selectedLvl.rawValue)? Toàn bộ tiến trình làm bài hiện tại sẽ được làm mới.",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive, handler: { [weak self] _ in
                self?.startTest(for: selectedLvl)
            }))
            alert.addAction(UIAlertAction(title: "Hủy", style: .cancel, handler: { [weak self] _ in
                self?.levelSegmentedControl.selectedSegmentIndex = self?.currentLevel == .n5 ? 0 : 1
            }))
            present(alert, animated: true)
        }
    }
    
    private func startTimer() {
        stopTimer()
        updateTimerLabel()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.timerTick()
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func timerTick() {
        if remainingSeconds > 0 {
            remainingSeconds -= 1
            updateTimerLabel()
            if remainingSeconds <= 180 {
                // Dưới 3 phút đổi màu cảnh báo
                timerLabel.textColor = .systemRed
                timerIcon.tintColor = .systemRed
            }
        } else {
            stopTimer()
            autoSubmitOnTimeout()
        }
    }
    
    private func updateTimerLabel() {
        let m = remainingSeconds / 60
        let s = remainingSeconds % 60
        timerLabel.text = String(format: "%02d:%02d", m, s)
    }
    
    private func renderQuestion(at index: Int) {
        guard index < questions.count else { return }
        
        let q = questions[index]
        questionCounterLabel.text = "Câu \(index + 1) / \(questions.count)"
        progressView.setProgress(Float(index + 1) / Float(questions.count), animated: true)
        
        // Section Badge
        sectionBadgeLabel.text = "  \(q.section.titleJp) • \(q.section.titleVi)  "
        switch q.section {
        case .vocabKanji:
            sectionBadgeLabel.textColor = .systemPurple
            sectionBadgeLabel.backgroundColor = UIColor.systemPurple.withAlphaComponent(0.12)
        case .grammar:
            sectionBadgeLabel.textColor = .systemTeal
            sectionBadgeLabel.backgroundColor = UIColor.systemTeal.withAlphaComponent(0.12)
        case .listening:
            sectionBadgeLabel.textColor = .systemOrange
            sectionBadgeLabel.backgroundColor = UIColor.systemOrange.withAlphaComponent(0.12)
        }
        
        promptLabel.text = q.prompt
        contentLabel.text = q.contentJp
        
        // Audio button visibility
        listenAudioButton.isHidden = (q.audioText == nil)
        
        // Render 4 options
        let selectedChoice = userAnswers[index]
        let labels = ["A", "B", "C", "D"]
        for (i, btn) in optionButtons.enumerated() {
            if i < q.options.count {
                btn.isHidden = false
                let text = q.options[i]
                var config = UIButton.Configuration.plain()
                config.title = "  \(labels[i]).  \(text)"
                config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
                    var outgoing = incoming
                    outgoing.font = UIFont.systemFont(ofSize: 15, weight: .medium)
                    outgoing.foregroundColor = (i == selectedChoice) ? UIColor.systemIndigo : UIColor.label
                    return outgoing
                }
                btn.configuration = config
                
                if i == selectedChoice {
                    btn.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.12)
                    btn.layer.borderColor = UIColor.systemIndigo.cgColor
                } else {
                    btn.backgroundColor = .systemBackground
                    btn.layer.borderColor = UIColor.systemGray4.cgColor
                }
            } else {
                btn.isHidden = true
            }
        }
        
        prevButton.isEnabled = index > 0
        nextButton.setTitle(index == questions.count - 1 ? "Hoàn thành" : "Câu tiếp", for: .normal)
        
        // Tự động phát âm nếu là câu hỏi phần nghe hiểu
        if q.section == .listening, let audio = q.audioText {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                AudioService.shared.speak(text: audio)
            }
        }
    }
    
    @objc private func didSelectOption(_ sender: UIButton) {
        userAnswers[currentIndex] = sender.tag
        renderQuestion(at: currentIndex)
        AudioService.shared.playCorrectFeedback()
    }
    
    @objc private func didTapPrevious() {
        if currentIndex > 0 {
            currentIndex -= 1
            renderQuestion(at: currentIndex)
        }
    }
    
    @objc private func didTapNext() {
        if currentIndex < questions.count - 1 {
            currentIndex += 1
            renderQuestion(at: currentIndex)
        } else {
            confirmSubmit()
        }
    }
    
    @objc private func didTapPlayAudio() {
        guard currentIndex < questions.count, let audio = questions[currentIndex].audioText else { return }
        AudioService.shared.speak(text: audio)
    }
    
    @objc private func confirmSubmit() {
        let answeredCount = userAnswers.compactMap { $0 }.count
        let unAnswered = questions.count - answeredCount
        
        let message = unAnswered > 0 ?
            "Bạn còn \(unAnswered) câu chưa trả lời. Bạn có chắc chắn muốn nộp bài và chấm điểm ngay?" :
            "Bạn đã hoàn thành toàn bộ \(questions.count) câu hỏi! Bạn có muốn nộp bài để xem điểm chuẩn JLPT?"
        
        let alert = UIAlertController(title: "Nộp bài thi thử JLPT?", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Nộp bài ngay", style: .default, handler: { [weak self] _ in
            self?.finishAndGradeTest()
        }))
        alert.addAction(UIAlertAction(title: "Làm tiếp", style: .cancel))
        present(alert, animated: true)
    }
    
    private func autoSubmitOnTimeout() {
        let alert = UIAlertController(
            title: "Hết giờ làm bài! ⏰",
            message: "Thời gian làm bài thi 25 phút đã kết thúc. Hệ thống tự động thu bài và tính điểm cho bạn.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Xem kết quả thi", style: .default, handler: { [weak self] _ in
            self?.finishAndGradeTest()
        }))
        present(alert, animated: true)
    }
    
    private func finishAndGradeTest() {
        stopTimer()
        let timeSpent = totalTimeSeconds - remainingSeconds
        
        // Tính điểm từng phần theo chuẩn JLPT
        // Phần 1: Vocab/Kanji: 10 câu x 6đ = 60đ
        // Phần 2: Grammar: 10 câu x 6đ = 60đ
        // Phần 3: Listening: 5 câu x 12đ = 60đ
        // Tổng cộng = 180đ
        
        var vocabCorrect = 0, vocabTotal = 0
        var grammarCorrect = 0, grammarTotal = 0
        var listenCorrect = 0, listenTotal = 0
        
        var wrongList: [(question: JLPTQuestion, userChoiceIndex: Int?)] = []
        
        for (i, q) in questions.enumerated() {
            let userChoice = userAnswers[i]
            let isCorrect = (userChoice == q.correctIndex)
            
            switch q.section {
            case .vocabKanji:
                vocabTotal += 1
                if isCorrect { vocabCorrect += 1 }
            case .grammar:
                grammarTotal += 1
                if isCorrect { grammarCorrect += 1 }
            case .listening:
                listenTotal += 1
                if isCorrect { listenCorrect += 1 }
            }
            
            if !isCorrect {
                wrongList.append((question: q, userChoiceIndex: userChoice))
                // Tự động lưu các từ vựng làm sai vào Sổ tay từ chưa nhớ
                if let wId = q.relatedWordId {
                    ProgressService.shared.markWordForReview(id: wId)
                }
            }
        }
        
        let vocabScore = vocabTotal > 0 ? Int((Double(vocabCorrect) / Double(vocabTotal)) * 60) : 0
        let grammarScore = grammarTotal > 0 ? Int((Double(grammarCorrect) / Double(grammarTotal)) * 60) : 0
        let listenScore = listenTotal > 0 ? Int((Double(listenCorrect) / Double(listenTotal)) * 60) : 0
        
        let totalScore = vocabScore + grammarScore + listenScore
        
        let vocabPassed = vocabScore >= 19
        let grammarPassed = grammarScore >= 19
        let listenPassed = listenScore >= 19
        
        let minTotalPassing = currentLevel.passingTotalScore
        let isPassed = (totalScore >= minTotalPassing) && vocabPassed && grammarPassed && listenPassed
        
        let sectionScores = [
            JLPTSectionScore(section: .vocabKanji, correctCount: vocabCorrect, totalCount: vocabTotal, scoreOnScale60: vocabScore, isPassing: vocabPassed),
            JLPTSectionScore(section: .grammar, correctCount: grammarCorrect, totalCount: grammarTotal, scoreOnScale60: grammarScore, isPassing: grammarPassed),
            JLPTSectionScore(section: .listening, correctCount: listenCorrect, totalCount: listenTotal, scoreOnScale60: listenScore, isPassing: listenPassed)
        ]
        
        let result = JLPTTestResult(
            level: currentLevel,
            totalScore: totalScore,
            isPassed: isPassed,
            sectionScores: sectionScores,
            timeSpentSeconds: timeSpent,
            wrongQuestions: wrongList
        )
        
        // Lưu điểm vào ProgressService
        ProgressService.shared.recordGrammarTestScore(score: totalScore)
        ProgressService.shared.recordQuizResult(correct: vocabCorrect + grammarCorrect + listenCorrect, total: questions.count)
        
        showResultAlert(result: result)
    }
    
    private func showResultAlert(result: JLPTTestResult) {
        let badge = result.isPassed ? "🎉 ĐỖ (合格 - PASSED)" : "⚠️ CHƯA ĐẠT (不合格 - FAILED)"
        let minPass = result.level.passingTotalScore
        
        var message = "Tổng điểm: \(result.totalScore) / 180 (Điểm chuẩn đỗ: \(minPass))\n\n"
        message += "• Chữ Hán - Từ vựng: \(result.sectionScores[0].scoreOnScale60)/60 điểm (\(result.sectionScores[0].correctCount)/\(result.sectionScores[0].totalCount) câu)\n"
        message += "• Ngữ pháp: \(result.sectionScores[1].scoreOnScale60)/60 điểm (\(result.sectionScores[1].correctCount)/\(result.sectionScores[1].totalCount) câu)\n"
        message += "• Nghe hiểu: \(result.sectionScores[2].scoreOnScale60)/60 điểm (\(result.sectionScores[2].correctCount)/\(result.sectionScores[2].totalCount) câu)\n\n"
        
        if result.isPassed {
            message += "🏆 Chúc mừng bạn đã vượt qua kỳ thi mô phỏng \(result.level.rawValue) thành công!"
        } else {
            message += "💪 Cố lên nhé! Các câu làm sai đã được tự động ghi nhận vào sổ tay ôn tập."
        }
        
        let alert = UIAlertController(title: "\(result.level.rawValue) - \(badge)", message: message, preferredStyle: .alert)
        
        if !result.wrongQuestions.isEmpty {
            alert.addAction(UIAlertAction(title: "Xem lại câu sai (\(result.wrongQuestions.count) câu)", style: .default, handler: { [weak self] _ in
                self?.showWrongQuestionsAnalysis(wrongQuestions: result.wrongQuestions)
            }))
        }
        
        alert.addAction(UIAlertAction(title: "Thi lại đề mới", style: .default, handler: { [weak self] _ in
            guard let self = self else { return }
            self.startTest(for: self.currentLevel)
        }))
        alert.addAction(UIAlertAction(title: "Hoàn tất", style: .cancel, handler: { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }))
        present(alert, animated: true)
    }
    
    private func showWrongQuestionsAnalysis(wrongQuestions: [(question: JLPTQuestion, userChoiceIndex: Int?)]) {
        let vc = JLPTWrongReviewViewController(wrongQuestions: wrongQuestions)
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Màn hình phân tích chi tiết câu sai
public class JLPTWrongReviewViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let wrongQuestions: [(question: JLPTQuestion, userChoiceIndex: Int?)]
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    public init(wrongQuestions: [(question: JLPTQuestion, userChoiceIndex: Int?)]) {
        self.wrongQuestions = wrongQuestions
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.wrongQuestions = []
        super.init(coder: coder)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        title = "Phân tích câu làm sai (\(wrongQuestions.count))"
        view.backgroundColor = .systemGroupedBackground
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "WrongCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return wrongQuestions.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let item = wrongQuestions[section]
        return "Câu \(section + 1) • [\(item.question.section.titleVi)]"
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "WrongCell")
        let item = wrongQuestions[indexPath.section]
        let q = item.question
        
        var userText = "Chưa chọn đáp án"
        if let idx = item.userChoiceIndex, idx < q.options.count {
            userText = q.options[idx]
        }
        let correctText = q.options[q.correctIndex]
        
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        cell.textLabel?.text = "\(q.contentJp)\n\n❌ Bạn chọn: \(userText)\n✅ Đáp án đúng: \(correctText)"
        
        cell.detailTextLabel?.numberOfLines = 0
        cell.detailTextLabel?.font = .systemFont(ofSize: 13, weight: .regular)
        cell.detailTextLabel?.textColor = .secondaryLabel
        cell.detailTextLabel?.text = "\n💡 Giải thích chi tiết:\n\(q.explanation)"
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = wrongQuestions[indexPath.section]
        if let audio = item.question.audioText {
            AudioService.shared.speak(text: audio)
        }
    }
}
