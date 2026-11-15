//
//  GrammarFlashcardViewController.swift
//  AppHocTiengNhat
//

import UIKit

public class GrammarFlashcardViewController: UIViewController {

    private let lesson: GrammarLesson?
    private let levelFilter: String?
    private var points: [GrammarPoint] = []
    private var currentIndex: Int = 0

    private let progressView = UIProgressView(progressViewStyle: .default)
    private let counterLabel = UILabel()
    private let lessonSubtitleLabel = UILabel()
    private let flashcard = GrammarFlashcardView()

    private let prevButton = UIButton(type: .system)
    private let nextButton = UIButton(type: .system)
    private let speakButton = UIButton(type: .system)

    public init(lesson: GrammarLesson? = nil, levelFilter: String? = nil) {
        self.lesson = lesson
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
            title = "Bài \(lesson.lessonNumber) (\(lesson.jlptLevel)): Ngữ pháp"
            points = lesson.points
        } else if let levelFilter = levelFilter {
            title = "Flashcard Ngữ pháp \(levelFilter)"
            points = GrammarRepository.shared.getAllPoints(level: levelFilter)
        } else {
            title = "Flashcard 50 Bài N5 & N4"
            points = GrammarRepository.shared.getAllPoints()
        }

        view.backgroundColor = .systemGroupedBackground
        navigationItem.largeTitleDisplayMode = .never

        setupUI()
        setupGestures()
        updateCard()
    }

    private func setupUI() {
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.progressTintColor = .systemTeal
        progressView.trackTintColor = .systemGray5
        view.addSubview(progressView)

        counterLabel.translatesAutoresizingMaskIntoConstraints = false
        counterLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        counterLabel.textColor = .secondaryLabel
        counterLabel.textAlignment = .center
        view.addSubview(counterLabel)

        lessonSubtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        lessonSubtitleLabel.font = .systemFont(ofSize: 13, weight: .medium)
        lessonSubtitleLabel.textColor = .systemTeal
        lessonSubtitleLabel.textAlignment = .center
        lessonSubtitleLabel.numberOfLines = 1
        view.addSubview(lessonSubtitleLabel)

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
        nextConfig.baseBackgroundColor = .systemTeal
        nextConfig.baseForegroundColor = .white
        nextButton.configuration = nextConfig
        nextButton.layer.cornerRadius = 14
        nextButton.layer.shadowColor = UIColor.systemTeal.cgColor
        nextButton.layer.shadowOpacity = 0.2
        nextButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        nextButton.layer.shadowRadius = 6
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)

        var speakConfig = UIButton.Configuration.tinted()
        speakConfig.image = UIImage(systemName: "speaker.wave.3.fill")
        speakConfig.baseBackgroundColor = .systemTeal
        speakConfig.baseForegroundColor = .systemTeal
        speakButton.configuration = speakConfig
        speakButton.layer.cornerRadius = 25
        speakButton.clipsToBounds = true
        speakButton.translatesAutoresizingMaskIntoConstraints = false
        speakButton.addTarget(self, action: #selector(didTapSpeak), for: .touchUpInside)

        let buttonStack = UIStackView(arrangedSubviews: [prevButton, speakButton, nextButton])
        buttonStack.axis = .horizontal
        buttonStack.distribution = .fillProportionally
        buttonStack.alignment = .center
        buttonStack.spacing = 14
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonStack)

        NSLayoutConstraint.activate([
            progressView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            progressView.heightAnchor.constraint(equalToConstant: 6),

            counterLabel.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 10),
            counterLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            lessonSubtitleLabel.topAnchor.constraint(equalTo: counterLabel.bottomAnchor, constant: 4),
            lessonSubtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            lessonSubtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            flashcard.topAnchor.constraint(equalTo: lessonSubtitleLabel.bottomAnchor, constant: 14),
            flashcard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            flashcard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            flashcard.bottomAnchor.constraint(equalTo: buttonStack.topAnchor, constant: -20),

            speakButton.widthAnchor.constraint(equalToConstant: 50),
            speakButton.heightAnchor.constraint(equalToConstant: 50),
            prevButton.heightAnchor.constraint(equalToConstant: 50),
            nextButton.heightAnchor.constraint(equalToConstant: 50),

            buttonStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
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
        guard !points.isEmpty, currentIndex < points.count else { return }

        let point = points[currentIndex]
        flashcard.configure(with: point)

        counterLabel.text = "\(currentIndex + 1) / \(points.count)"
        if let lesson = lesson {
            lessonSubtitleLabel.text = lesson.title
        } else {
            let lessonTitle = GrammarRepository.shared.lessons.first(where: { $0.lessonNumber == point.lessonNumber })?.title ?? ""
            lessonSubtitleLabel.text = "Bài \(point.lessonNumber): \(lessonTitle)"
        }

        let progress = Float(currentIndex + 1) / Float(points.count)
        progressView.setProgress(progress, animated: true)

        prevButton.isEnabled = currentIndex > 0
        var nextConfig = nextButton.configuration
        nextConfig?.title = currentIndex == points.count - 1 ? "Hoàn thành" : "Tiếp theo"
        nextButton.configuration = nextConfig
    }

    @objc private func didTapPrevious() {
        guard currentIndex > 0 else { return }
        currentIndex -= 1
        animateCardTransition(forward: false)
    }

    @objc private func didTapNext() {
        if currentIndex < points.count - 1 {
            currentIndex += 1
            animateCardTransition(forward: true)
        } else {
            showCompletionAlert()
        }
    }

    @objc private func didTapSpeak() {
        guard !points.isEmpty, currentIndex < points.count else { return }
        let point = points[currentIndex]
        AudioService.shared.speak(text: point.exampleJp)
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
        let lessonDesc: String
        let quizActionTitle: String
        if let lesson = lesson {
            lessonDesc = "Bài \(lesson.lessonNumber) (\(lesson.jlptLevel)): \(lesson.title)"
            quizActionTitle = "Làm bài tập Bài \(lesson.lessonNumber)"
        } else if let levelFilter = levelFilter {
            lessonDesc = "các bài Minna no Nihongo \(levelFilter)"
            quizActionTitle = "Làm bài tập Tổng hợp \(levelFilter)"
        } else {
            lessonDesc = "toàn bộ 50 bài Minna no Nihongo (N5 & N4)"
            quizActionTitle = "Làm bài tập Tổng hợp N5 & N4"
        }

        let alert = UIAlertController(
            title: "Hoàn thành phần lý thuyết! 🎉",
            message: "Bạn đã xem xong các mẫu ngữ pháp của \(lessonDesc). Hãy làm bài tập trắc nghiệm để ghi nhớ sâu hơn nhé!",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Học lại", style: .default, handler: { [weak self] _ in
            self?.currentIndex = 0
            self?.updateCard()
        }))
        alert.addAction(UIAlertAction(title: quizActionTitle, style: .default, handler: { [weak self] _ in
            guard let self = self else { return }
            let quizVC = GrammarQuizViewController(lesson: self.lesson, levelFilter: self.levelFilter)
            self.navigationController?.pushViewController(quizVC, animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Đóng", style: .cancel))
        present(alert, animated: true)
    }
}
