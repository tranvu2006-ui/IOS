//
//  GrammarQuizViewController.swift
//  AppHocTiengNhat
//

import UIKit

public class GrammarQuizViewController: UIViewController {

    private let lesson: GrammarLesson?
    private let levelFilter: String?
    private var selectedTypeFilter: GrammarQuizType? = nil
    private var quizList: [GrammarQuizQuestion] = []
    private var currentIndex: Int = 0
    private var score: Int = 0
    
    private var currentQuestion: GrammarQuizQuestion?
    private var optionButtons: [UIButton] = []
    private var isAnswerLocked: Bool = false

    // UI Elements
    private let scrollView = UIScrollView()
    private let contentView = UIView()

    private let filterSegmentedControl = UISegmentedControl(items: [
        "Tất cả",
        "Điền trợ từ",
        "Nối câu"
    ])
    private let progressView = UIProgressView(progressViewStyle: .default)
    private let headerLabel = UILabel()
    private let scoreBadgeLabel = UILabel()

    private let questionBoxView = UIView()
    private let typeBadgeLabel = UILabel()
    private let lessonBadgeLabel = UILabel()
    private let speakButton = UIButton(type: .system)
    private let promptJpLabel = UILabel()
    private let promptViLabel = UILabel()

    private let optionsStackView = UIStackView()

    private let explanationBoxView = UIView()
    private let resultStatusLabel = UILabel()
    private let explanationTextLabel = UILabel()
    private let nextQuestionButton = UIButton(type: .system)

    public init(lesson: GrammarLesson? = nil, initialFilter: GrammarQuizType? = nil, levelFilter: String? = nil) {
        self.lesson = lesson
        self.selectedTypeFilter = initialFilter
        self.levelFilter = levelFilter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        self.lesson = nil
        self.levelFilter = nil
        super.init(coder: coder)
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        if let lesson = lesson {
            title = "Bài tập Bài \(lesson.lessonNumber) (\(lesson.jlptLevel))"
        } else if let levelFilter = levelFilter {
            title = "Bài tập Ngữ pháp \(levelFilter)"
        } else {
            title = "Bài tập Ngữ pháp N5 & N4"
        }
        view.backgroundColor = .systemGroupedBackground
        navigationItem.largeTitleDisplayMode = .never

        setupUI()
        syncInitialSegment()
        startNewQuizSession()
    }

    private func syncInitialSegment() {
        switch selectedTypeFilter {
        case .none:
            filterSegmentedControl.selectedSegmentIndex = 0
        case .some(.particleFill):
            filterSegmentedControl.selectedSegmentIndex = 1
        case .some(.sentenceMatch):
            filterSegmentedControl.selectedSegmentIndex = 2
        }
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

        // Filter segmented control
        filterSegmentedControl.selectedSegmentIndex = 0
        filterSegmentedControl.selectedSegmentTintColor = .systemTeal
        filterSegmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        filterSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        filterSegmentedControl.addTarget(self, action: #selector(didChangeFilter), for: .valueChanged)
        contentView.addSubview(filterSegmentedControl)

        // Progress view
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.progressTintColor = .systemTeal
        progressView.trackTintColor = .systemGray5
        contentView.addSubview(progressView)

        // Header & Score
        headerLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        headerLabel.textColor = .secondaryLabel
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(headerLabel)

        scoreBadgeLabel.font = .systemFont(ofSize: 14, weight: .bold)
        scoreBadgeLabel.textColor = .systemTeal
        scoreBadgeLabel.backgroundColor = UIColor.systemTeal.withAlphaComponent(0.14)
        scoreBadgeLabel.layer.cornerRadius = 8
        scoreBadgeLabel.clipsToBounds = true
        scoreBadgeLabel.textAlignment = .center
        scoreBadgeLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(scoreBadgeLabel)

        // Question box
        questionBoxView.backgroundColor = .systemBackground
        questionBoxView.layer.cornerRadius = 20
        questionBoxView.layer.borderWidth = 1
        questionBoxView.layer.borderColor = UIColor.systemGray5.cgColor
        questionBoxView.layer.shadowColor = UIColor.black.cgColor
        questionBoxView.layer.shadowOpacity = 0.06
        questionBoxView.layer.shadowOffset = CGSize(width: 0, height: 4)
        questionBoxView.layer.shadowRadius = 8
        questionBoxView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(questionBoxView)

        typeBadgeLabel.font = .systemFont(ofSize: 11, weight: .bold)
        typeBadgeLabel.textColor = .systemTeal
        typeBadgeLabel.backgroundColor = UIColor.systemTeal.withAlphaComponent(0.14)
        typeBadgeLabel.layer.cornerRadius = 6
        typeBadgeLabel.clipsToBounds = true
        typeBadgeLabel.translatesAutoresizingMaskIntoConstraints = false

        lessonBadgeLabel.font = .systemFont(ofSize: 11, weight: .bold)
        lessonBadgeLabel.textColor = .secondaryLabel
        lessonBadgeLabel.backgroundColor = .secondarySystemBackground
        lessonBadgeLabel.layer.cornerRadius = 6
        lessonBadgeLabel.clipsToBounds = true
        lessonBadgeLabel.translatesAutoresizingMaskIntoConstraints = false

        speakButton.setImage(UIImage(systemName: "speaker.wave.2.fill"), for: .normal)
        speakButton.tintColor = .systemTeal
        speakButton.backgroundColor = UIColor.systemTeal.withAlphaComponent(0.12)
        speakButton.layer.cornerRadius = 18
        speakButton.translatesAutoresizingMaskIntoConstraints = false
        speakButton.addTarget(self, action: #selector(didTapSpeakPrompt), for: .touchUpInside)

        promptJpLabel.font = .systemFont(ofSize: 20, weight: .bold)
        promptJpLabel.textColor = .label
        promptJpLabel.numberOfLines = 0
        promptJpLabel.textAlignment = .left
        promptJpLabel.translatesAutoresizingMaskIntoConstraints = false

        promptViLabel.font = .systemFont(ofSize: 14, weight: .medium)
        promptViLabel.textColor = .secondaryLabel
        promptViLabel.numberOfLines = 0
        promptViLabel.translatesAutoresizingMaskIntoConstraints = false

        questionBoxView.addSubview(typeBadgeLabel)
        questionBoxView.addSubview(lessonBadgeLabel)
        questionBoxView.addSubview(speakButton)
        questionBoxView.addSubview(promptJpLabel)
        questionBoxView.addSubview(promptViLabel)

        // Options Stack View
        optionsStackView.axis = .vertical
        optionsStackView.spacing = 10
        optionsStackView.distribution = .fill
        optionsStackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(optionsStackView)

        for i in 0..<4 {
            let button = createOptionButton(tag: i)
            optionButtons.append(button)
            optionsStackView.addArrangedSubview(button)
        }

        // Explanation Box View
        explanationBoxView.backgroundColor = .systemBackground
        explanationBoxView.layer.cornerRadius = 18
        explanationBoxView.layer.borderWidth = 1.5
        explanationBoxView.layer.borderColor = UIColor.systemTeal.withAlphaComponent(0.4).cgColor
        explanationBoxView.isHidden = true
        explanationBoxView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(explanationBoxView)

        resultStatusLabel.font = .systemFont(ofSize: 16, weight: .bold)
        resultStatusLabel.translatesAutoresizingMaskIntoConstraints = false

        explanationTextLabel.font = .systemFont(ofSize: 14, weight: .regular)
        explanationTextLabel.textColor = .label
        explanationTextLabel.numberOfLines = 0
        explanationTextLabel.translatesAutoresizingMaskIntoConstraints = false

        var nextConfig = UIButton.Configuration.filled()
        nextConfig.title = "Câu tiếp theo →"
        nextConfig.baseBackgroundColor = .systemTeal
        nextConfig.baseForegroundColor = .white
        nextConfig.cornerStyle = .medium
        nextQuestionButton.configuration = nextConfig
        nextQuestionButton.translatesAutoresizingMaskIntoConstraints = false
        nextQuestionButton.addTarget(self, action: #selector(didTapNextQuestion), for: .touchUpInside)

        explanationBoxView.addSubview(resultStatusLabel)
        explanationBoxView.addSubview(explanationTextLabel)
        explanationBoxView.addSubview(nextQuestionButton)

        NSLayoutConstraint.activate([
            filterSegmentedControl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            filterSegmentedControl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            filterSegmentedControl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            progressView.topAnchor.constraint(equalTo: filterSegmentedControl.bottomAnchor, constant: 14),
            progressView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            progressView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            progressView.heightAnchor.constraint(equalToConstant: 6),

            headerLabel.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 12),
            headerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),

            scoreBadgeLabel.centerYAnchor.constraint(equalTo: headerLabel.centerYAnchor),
            scoreBadgeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            scoreBadgeLabel.heightAnchor.constraint(equalToConstant: 26),
            scoreBadgeLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 80),

            questionBoxView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 12),
            questionBoxView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            questionBoxView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            typeBadgeLabel.topAnchor.constraint(equalTo: questionBoxView.topAnchor, constant: 14),
            typeBadgeLabel.leadingAnchor.constraint(equalTo: questionBoxView.leadingAnchor, constant: 16),
            typeBadgeLabel.heightAnchor.constraint(equalToConstant: 22),

            lessonBadgeLabel.centerYAnchor.constraint(equalTo: typeBadgeLabel.centerYAnchor),
            lessonBadgeLabel.leadingAnchor.constraint(equalTo: typeBadgeLabel.trailingAnchor, constant: 8),
            lessonBadgeLabel.heightAnchor.constraint(equalToConstant: 22),

            speakButton.centerYAnchor.constraint(equalTo: typeBadgeLabel.centerYAnchor),
            speakButton.trailingAnchor.constraint(equalTo: questionBoxView.trailingAnchor, constant: -14),
            speakButton.widthAnchor.constraint(equalToConstant: 36),
            speakButton.heightAnchor.constraint(equalToConstant: 36),

            promptJpLabel.topAnchor.constraint(equalTo: typeBadgeLabel.bottomAnchor, constant: 14),
            promptJpLabel.leadingAnchor.constraint(equalTo: questionBoxView.leadingAnchor, constant: 16),
            promptJpLabel.trailingAnchor.constraint(equalTo: questionBoxView.trailingAnchor, constant: -16),

            promptViLabel.topAnchor.constraint(equalTo: promptJpLabel.bottomAnchor, constant: 8),
            promptViLabel.leadingAnchor.constraint(equalTo: questionBoxView.leadingAnchor, constant: 16),
            promptViLabel.trailingAnchor.constraint(equalTo: questionBoxView.trailingAnchor, constant: -16),
            promptViLabel.bottomAnchor.constraint(equalTo: questionBoxView.bottomAnchor, constant: -16),

            optionsStackView.topAnchor.constraint(equalTo: questionBoxView.bottomAnchor, constant: 16),
            optionsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            optionsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            explanationBoxView.topAnchor.constraint(equalTo: optionsStackView.bottomAnchor, constant: 16),
            explanationBoxView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            explanationBoxView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            explanationBoxView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -28),

            resultStatusLabel.topAnchor.constraint(equalTo: explanationBoxView.topAnchor, constant: 14),
            resultStatusLabel.leadingAnchor.constraint(equalTo: explanationBoxView.leadingAnchor, constant: 16),
            resultStatusLabel.trailingAnchor.constraint(equalTo: explanationBoxView.trailingAnchor, constant: -16),

            explanationTextLabel.topAnchor.constraint(equalTo: resultStatusLabel.bottomAnchor, constant: 6),
            explanationTextLabel.leadingAnchor.constraint(equalTo: explanationBoxView.leadingAnchor, constant: 16),
            explanationTextLabel.trailingAnchor.constraint(equalTo: explanationBoxView.trailingAnchor, constant: -16),

            nextQuestionButton.topAnchor.constraint(equalTo: explanationTextLabel.bottomAnchor, constant: 14),
            nextQuestionButton.leadingAnchor.constraint(equalTo: explanationBoxView.leadingAnchor, constant: 16),
            nextQuestionButton.trailingAnchor.constraint(equalTo: explanationBoxView.trailingAnchor, constant: -16),
            nextQuestionButton.bottomAnchor.constraint(equalTo: explanationBoxView.bottomAnchor, constant: -14),
            nextQuestionButton.heightAnchor.constraint(equalToConstant: 46)
        ])
    }

    private func createOptionButton(tag: Int) -> UIButton {
        let button = UIButton(type: .system)
        button.tag = tag
        button.backgroundColor = .systemBackground
        button.layer.cornerRadius = 14
        button.layer.borderWidth = 1.5
        button.layer.borderColor = UIColor.systemGray5.cgColor
        button.contentHorizontalAlignment = .leading
        button.titleLabel?.numberOfLines = 0
        button.addTarget(self, action: #selector(didSelectOption(_:)), for: .touchUpInside)
        button.heightAnchor.constraint(greaterThanOrEqualToConstant: 52).isActive = true
        return button
    }

    @objc private func didChangeFilter() {
        switch filterSegmentedControl.selectedSegmentIndex {
        case 1:
            selectedTypeFilter = .particleFill
        case 2:
            selectedTypeFilter = .sentenceMatch
        default:
            selectedTypeFilter = nil
        }
        startNewQuizSession()
    }

    private func startNewQuizSession() {
        score = 0
        currentIndex = 0
        let pool = GrammarRepository.shared.getQuizzes(
            forLesson: lesson?.lessonNumber,
            type: selectedTypeFilter,
            level: levelFilter
        )

        if lesson == nil {
            quizList = Array(pool.shuffled().prefix(15))
        } else {
            quizList = pool.shuffled()
        }
        loadQuestion()
    }

    private func loadQuestion() {
        guard !quizList.isEmpty, currentIndex < quizList.count else {
            if !quizList.isEmpty {
                showFinalResults()
            }
            return
        }

        isAnswerLocked = false
        explanationBoxView.isHidden = true

        let question = quizList[currentIndex]
        currentQuestion = question

        headerLabel.text = "Câu \(currentIndex + 1) / \(quizList.count)"
        scoreBadgeLabel.text = " Điểm: \(score) "
        progressView.setProgress(Float(currentIndex + 1) / Float(quizList.count), animated: true)

        typeBadgeLabel.text = question.quizType == .particleFill
            ? "  ĐIỀN TRỢ TỪ / CHIA THỂ  "
            : "  NỐI CÂU HOÀN CHỈNH  "
        let level = question.lessonNumber <= 25 ? "N5" : "N4"
        lessonBadgeLabel.text = "  Bài \(question.lessonNumber) • \(level)  "

        promptJpLabel.attributedText = formattedPromptText(question.promptJp)
        promptViLabel.text = "Nghĩa: \(question.promptVi)"

        let shuffledOptions = question.options.shuffled()
        let labels = ["A", "B", "C", "D"]

        for (index, button) in optionButtons.enumerated() {
            if index < shuffledOptions.count {
                let option = shuffledOptions[index]
                button.isHidden = false
                var config = UIButton.Configuration.plain()
                config.title = "\(labels[index]).  \(option)"
                config.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16)
                config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
                    var outgoing = incoming
                    outgoing.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
                    outgoing.foregroundColor = UIColor.label
                    return outgoing
                }
                button.configuration = config
                button.accessibilityIdentifier = option
                button.backgroundColor = .systemBackground
                button.layer.borderColor = UIColor.systemGray5.cgColor
                button.isEnabled = true
            } else {
                button.isHidden = true
            }
        }

        scrollView.setContentOffset(.zero, animated: true)
    }

    private func formattedPromptText(_ text: String) -> NSAttributedString {
        let attributed = NSMutableAttributedString(
            string: text,
            attributes: [
                .font: UIFont.systemFont(ofSize: 20, weight: .bold),
                .foregroundColor: UIColor.label
            ]
        )
        let nsText = text as NSString
        let blankRange = nsText.range(of: "[ ___ ]")
        if blankRange.location != NSNotFound {
            attributed.addAttributes([
                .foregroundColor: UIColor.systemTeal,
                .backgroundColor: UIColor.systemTeal.withAlphaComponent(0.14)
            ], range: blankRange)
        }
        return attributed
    }

    @objc private func didTapSpeakPrompt() {
        guard let question = currentQuestion else { return }
        let textToSpeak = isAnswerLocked ? question.fullSentenceJp : question.promptJp.replacingOccurrences(of: "[ ___ ]", with: "...")
        AudioService.shared.speak(text: textToSpeak)
    }

    @objc private func didSelectOption(_ sender: UIButton) {
        guard !isAnswerLocked, let question = currentQuestion else { return }
        isAnswerLocked = true

        let selectedAnswer = sender.accessibilityIdentifier ?? ""
        let isCorrect = (selectedAnswer == question.correctAnswer)

        if isCorrect {
            score += 1
            scoreBadgeLabel.text = " Điểm: \(score) "
            sender.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.18)
            sender.layer.borderColor = UIColor.systemGreen.cgColor
            resultStatusLabel.text = "✓ Chính xác!"
            resultStatusLabel.textColor = .systemGreen
            AudioService.shared.playCorrectFeedback()
        } else {
            sender.backgroundColor = UIColor.systemRed.withAlphaComponent(0.18)
            sender.layer.borderColor = UIColor.systemRed.cgColor
            resultStatusLabel.text = "✕ Chưa chính xác — Đáp án đúng: \(question.correctAnswer)"
            resultStatusLabel.textColor = .systemRed
            AudioService.shared.playWrongFeedback()

            for button in optionButtons where button.accessibilityIdentifier == question.correctAnswer {
                button.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.18)
                button.layer.borderColor = UIColor.systemGreen.cgColor
            }
        }

        explanationTextLabel.text = "Câu đầy đủ: \(question.fullSentenceJp)\n\n💡 Giải thích: \(question.explanation)"
        var nextConfig = nextQuestionButton.configuration
        nextConfig?.title = (currentIndex == quizList.count - 1) ? "Xem kết quả" : "Câu tiếp theo →"
        nextQuestionButton.configuration = nextConfig
        explanationBoxView.isHidden = false

        AudioService.shared.speak(text: question.fullSentenceJp)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            guard let self = self else { return }
            let bottomOffset = max(0, self.scrollView.contentSize.height - self.scrollView.bounds.height + self.scrollView.adjustedContentInset.bottom)
            if bottomOffset > 0 {
                self.scrollView.setContentOffset(CGPoint(x: 0, y: bottomOffset), animated: true)
            }
        }
    }

    @objc private func didTapNextQuestion() {
        currentIndex += 1
        loadQuestion()
    }

    private func showFinalResults() {
        ProgressService.shared.recordQuizResult(correct: score, total: quizList.count)

        let percentage = Int((Double(score) / Double(quizList.count)) * 100)
        let message = percentage >= 80 ?
            "Xuất sắc! Bạn đã nắm vững mẫu ngữ pháp này (\(score)/\(quizList.count))." :
            "Bạn đạt \(score)/\(quizList.count). Hãy ôn lại Flashcard ngữ pháp và làm lại bài để nhớ chắc trợ từ & chia thể nhé!"

        let alert = UIAlertController(
            title: "Hoàn thành: \(percentage)%",
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Làm lại bài", style: .default, handler: { [weak self] _ in
            self?.startNewQuizSession()
        }))
        alert.addAction(UIAlertAction(title: "Quay lại", style: .cancel, handler: { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }))
        present(alert, animated: true)
    }
}
