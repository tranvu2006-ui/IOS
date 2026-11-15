//
//  GrammarLessonListViewController.swift
//  AppHocTiengNhat
//

import UIKit

public class GrammarLessonListViewController: UIViewController {

    private let scrollView = UIScrollView()
    private let contentView = UIView()

    private let headerCard = UIView()
    private let statsLabel = UILabel()
    private let statsProgressView = UIProgressView(progressViewStyle: .default)

    private let filterScrollView = UIScrollView()
    private let filterStackView = UIStackView()
    private var filterButtons: [UIButton] = []
    private var selectedGroupIndex: Int = 0

    private let lessonsStackView = UIStackView()

    private let filterTitles: [String] = [
        "Tất cả (50)",
        "N5 (Bài 1-25)",
        "N4 (Bài 26-50)",
        "Bài 1-8",
        "Bài 9-13",
        "Bài 14-19",
        "Bài 20-25",
        "Bài 26-32",
        "Bài 33-38",
        "Bài 39-44",
        "Bài 45-50"
    ]

    public override func viewDidLoad() {
        super.viewDidLoad()
        title = "Ngữ pháp N5 & N4 (50 Bài)"
        view.backgroundColor = .systemGroupedBackground
        navigationItem.largeTitleDisplayMode = .never

        setupUI()
        reloadLessonCards()
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshHeaderStats()
        reloadLessonCards()
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

        setupHeaderCard()
        setupFilterBar()

        lessonsStackView.axis = .vertical
        lessonsStackView.spacing = 14
        lessonsStackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(lessonsStackView)

        NSLayoutConstraint.activate([
            headerCard.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14),
            headerCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18),
            headerCard.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -18),

            filterScrollView.topAnchor.constraint(equalTo: headerCard.bottomAnchor, constant: 14),
            filterScrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            filterScrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            filterScrollView.heightAnchor.constraint(equalToConstant: 40),

            lessonsStackView.topAnchor.constraint(equalTo: filterScrollView.bottomAnchor, constant: 14),
            lessonsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18),
            lessonsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -18),
            lessonsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -28)
        ])
    }

    private func setupHeaderCard() {
        headerCard.backgroundColor = .systemBackground
        headerCard.layer.cornerRadius = 20
        headerCard.layer.borderWidth = 1
        headerCard.layer.borderColor = UIColor.systemGray5.cgColor
        headerCard.layer.shadowColor = UIColor.black.cgColor
        headerCard.layer.shadowOpacity = 0.06
        headerCard.layer.shadowOffset = CGSize(width: 0, height: 4)
        headerCard.layer.shadowRadius = 8
        headerCard.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(headerCard)

        let titleLabel = UILabel()
        titleLabel.text = "Giáo trình Minna no Nihongo I & II"
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        titleLabel.textColor = .label
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        statsLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        statsLabel.textColor = .systemTeal
        statsLabel.translatesAutoresizingMaskIntoConstraints = false

        statsProgressView.progressTintColor = .systemTeal
        statsProgressView.trackTintColor = .systemGray5
        statsProgressView.translatesAutoresizingMaskIntoConstraints = false

        let allFlashcardBtn = UIButton(type: .system)
        var fcConfig = UIButton.Configuration.filled()
        fcConfig.title = "Flashcard 50 Bài"
        fcConfig.image = UIImage(systemName: "rectangle.stack.fill")
        fcConfig.imagePlacement = .leading
        fcConfig.imagePadding = 6
        fcConfig.baseBackgroundColor = .systemTeal
        fcConfig.baseForegroundColor = .white
        allFlashcardBtn.configuration = fcConfig
        allFlashcardBtn.layer.cornerRadius = 12
        allFlashcardBtn.clipsToBounds = true
        allFlashcardBtn.addAction(UIAction(handler: { [weak self] _ in
            let levelFilter = self?.currentLevelFilter()
            let vc = GrammarFlashcardViewController(lesson: nil, levelFilter: levelFilter)
            self?.navigationController?.pushViewController(vc, animated: true)
        }), for: .touchUpInside)

        let allQuizBtn = UIButton(type: .system)
        var qConfig = UIButton.Configuration.tinted()
        qConfig.title = "Trắc nghiệm Tổng hợp"
        qConfig.image = UIImage(systemName: "checklist")
        qConfig.imagePlacement = .leading
        qConfig.imagePadding = 6
        qConfig.baseBackgroundColor = .systemTeal
        qConfig.baseForegroundColor = .systemTeal
        allQuizBtn.configuration = qConfig
        allQuizBtn.layer.cornerRadius = 12
        allQuizBtn.clipsToBounds = true
        allQuizBtn.addAction(UIAction(handler: { [weak self] _ in
            let levelFilter = self?.currentLevelFilter()
            let vc = GrammarQuizViewController(lesson: nil, levelFilter: levelFilter)
            self?.navigationController?.pushViewController(vc, animated: true)
        }), for: .touchUpInside)

        let btnStack = UIStackView(arrangedSubviews: [allFlashcardBtn, allQuizBtn])
        btnStack.axis = .horizontal
        btnStack.distribution = .fillEqually
        btnStack.spacing = 10
        btnStack.translatesAutoresizingMaskIntoConstraints = false

        headerCard.addSubview(titleLabel)
        headerCard.addSubview(statsLabel)
        headerCard.addSubview(statsProgressView)
        headerCard.addSubview(btnStack)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: headerCard.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: headerCard.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: headerCard.trailingAnchor, constant: -16),

            statsLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
            statsLabel.leadingAnchor.constraint(equalTo: headerCard.leadingAnchor, constant: 16),
            statsLabel.trailingAnchor.constraint(equalTo: headerCard.trailingAnchor, constant: -16),

            statsProgressView.topAnchor.constraint(equalTo: statsLabel.bottomAnchor, constant: 8),
            statsProgressView.leadingAnchor.constraint(equalTo: headerCard.leadingAnchor, constant: 16),
            statsProgressView.trailingAnchor.constraint(equalTo: headerCard.trailingAnchor, constant: -16),
            statsProgressView.heightAnchor.constraint(equalToConstant: 6),

            btnStack.topAnchor.constraint(equalTo: statsProgressView.bottomAnchor, constant: 14),
            btnStack.leadingAnchor.constraint(equalTo: headerCard.leadingAnchor, constant: 16),
            btnStack.trailingAnchor.constraint(equalTo: headerCard.trailingAnchor, constant: -16),
            btnStack.bottomAnchor.constraint(equalTo: headerCard.bottomAnchor, constant: -16),
            btnStack.heightAnchor.constraint(equalToConstant: 42)
        ])

        refreshHeaderStats()
    }

    private func setupFilterBar() {
        filterScrollView.showsHorizontalScrollIndicator = false
        filterScrollView.contentInset = UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 18)
        filterScrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(filterScrollView)

        filterStackView.axis = .horizontal
        filterStackView.spacing = 8
        filterStackView.translatesAutoresizingMaskIntoConstraints = false
        filterScrollView.addSubview(filterStackView)

        NSLayoutConstraint.activate([
            filterStackView.topAnchor.constraint(equalTo: filterScrollView.topAnchor),
            filterStackView.leadingAnchor.constraint(equalTo: filterScrollView.leadingAnchor),
            filterStackView.trailingAnchor.constraint(equalTo: filterScrollView.trailingAnchor),
            filterStackView.bottomAnchor.constraint(equalTo: filterScrollView.bottomAnchor),
            filterStackView.heightAnchor.constraint(equalTo: filterScrollView.heightAnchor)
        ])

        for (index, title) in filterTitles.enumerated() {
            let button = UIButton(type: .system)
            button.tag = index
            button.layer.cornerRadius = 16
            button.clipsToBounds = true
            button.addTarget(self, action: #selector(didTapFilter(_:)), for: .touchUpInside)
            filterButtons.append(button)
            filterStackView.addArrangedSubview(button)
        }
        updateFilterButtonStyles()
    }

    private func updateFilterButtonStyles() {
        for (index, button) in filterButtons.enumerated() {
            let isSelected = (index == selectedGroupIndex)
            var config = isSelected ? UIButton.Configuration.filled() : UIButton.Configuration.tinted()
            config.title = filterTitles[index]
            config.contentInsets = NSDirectionalEdgeInsets(top: 6, leading: 14, bottom: 6, trailing: 14)
            config.baseBackgroundColor = isSelected ? .systemTeal : .secondarySystemGroupedBackground
            config.baseForegroundColor = isSelected ? .white : .label
            config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
                var outgoing = incoming
                outgoing.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
                return outgoing
            }
            button.configuration = config
        }
    }

    @objc private func didTapFilter(_ sender: UIButton) {
        selectedGroupIndex = sender.tag
        updateFilterButtonStyles()
        reloadLessonCards()
    }

    private func refreshHeaderStats() {
        let totalPoints = GrammarRepository.shared.getAllPoints().count
        let masteredCount = ProgressService.shared.getMasteredCount(prefix: "grammar_")
        statsLabel.text = "Đã thuộc: \(masteredCount) / \(totalPoints) mẫu ngữ pháp (50 bài)"
        let progress = totalPoints > 0 ? Float(masteredCount) / Float(totalPoints) : 0
        statsProgressView.setProgress(progress, animated: false)
    }

    private func currentLevelFilter() -> String? {
        if selectedGroupIndex == 1 { return "N5" }
        if selectedGroupIndex == 2 { return "N4" }
        return nil
    }

    private func filteredLessons() -> [GrammarLesson] {
        let repo = GrammarRepository.shared
        switch selectedGroupIndex {
        case 0:
            return repo.lessons
        case 1:
            return repo.getLessons(level: "N5")
        case 2:
            return repo.getLessons(level: "N4")
        default:
            let targetTag = GrammarRepository.groupTags[selectedGroupIndex - 3]
            return repo.lessons.filter { $0.groupTag == targetTag }
        }
    }

    private func reloadLessonCards() {
        for arranged in lessonsStackView.arrangedSubviews {
            lessonsStackView.removeArrangedSubview(arranged)
            arranged.removeFromSuperview()
        }

        for lesson in filteredLessons() {
            let card = createLessonCard(lesson: lesson)
            lessonsStackView.addArrangedSubview(card)
        }
    }

    private func createLessonCard(lesson: GrammarLesson) -> UIView {
        let card = UIView()
        card.backgroundColor = .systemBackground
        card.layer.cornerRadius = 18
        card.layer.borderWidth = 1
        card.layer.borderColor = UIColor.systemGray5.cgColor
        card.layer.shadowColor = UIColor.black.cgColor
        card.layer.shadowOpacity = 0.04
        card.layer.shadowOffset = CGSize(width: 0, height: 2)
        card.layer.shadowRadius = 6
        card.translatesAutoresizingMaskIntoConstraints = false

        let isN4 = (lesson.jlptLevel == "N4")
        let accentColor: UIColor = isN4 ? .systemBlue : .systemTeal

        let badgeLabel = UILabel()
        badgeLabel.text = "  BÀI \(lesson.lessonNumber) • \(lesson.jlptLevel)  "
        badgeLabel.font = .systemFont(ofSize: 11, weight: .bold)
        badgeLabel.textColor = accentColor
        badgeLabel.backgroundColor = accentColor.withAlphaComponent(0.14)
        badgeLabel.layer.cornerRadius = 6
        badgeLabel.clipsToBounds = true
        badgeLabel.translatesAutoresizingMaskIntoConstraints = false

        let masteredInLesson = lesson.points.filter { ProgressService.shared.isMastered(id: $0.id) }.count
        let statusLabel = UILabel()
        if masteredInLesson == lesson.points.count && !lesson.points.isEmpty {
            statusLabel.text = "★ Đã thuộc hết (\(masteredInLesson)/\(lesson.points.count))"
            statusLabel.textColor = .systemGreen
        } else if masteredInLesson > 0 {
            statusLabel.text = "★ \(masteredInLesson)/\(lesson.points.count) mẫu"
            statusLabel.textColor = .systemOrange
        } else {
            statusLabel.text = "\(lesson.points.count) mẫu • \(lesson.quizzes.count) bài tập"
            statusLabel.textColor = .secondaryLabel
        }
        statusLabel.font = .systemFont(ofSize: 12, weight: .semibold)
        statusLabel.translatesAutoresizingMaskIntoConstraints = false

        let titleLabel = UILabel()
        titleLabel.text = lesson.title
        titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        titleLabel.textColor = .label
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        let summaryLabel = UILabel()
        summaryLabel.text = lesson.summary
        summaryLabel.font = .systemFont(ofSize: 13, weight: .regular)
        summaryLabel.textColor = .secondaryLabel
        summaryLabel.numberOfLines = 0
        summaryLabel.translatesAutoresizingMaskIntoConstraints = false

        let pointsPreviewLabel = UILabel()
        pointsPreviewLabel.text = lesson.points.map { "• \($0.title)" }.joined(separator: "\n")
        pointsPreviewLabel.font = .systemFont(ofSize: 12.5, weight: .medium)
        pointsPreviewLabel.textColor = .label
        pointsPreviewLabel.numberOfLines = 0
        pointsPreviewLabel.translatesAutoresizingMaskIntoConstraints = false

        let studyBtn = UIButton(type: .system)
        var sConfig = UIButton.Configuration.filled()
        sConfig.title = "Học bài"
        sConfig.image = UIImage(systemName: "book.fill")
        sConfig.imagePlacement = .leading
        sConfig.imagePadding = 6
        sConfig.baseBackgroundColor = accentColor
        sConfig.baseForegroundColor = .white
        studyBtn.configuration = sConfig
        studyBtn.layer.cornerRadius = 11
        studyBtn.clipsToBounds = true
        studyBtn.addAction(UIAction(handler: { [weak self] _ in
            let vc = GrammarFlashcardViewController(lesson: lesson)
            self?.navigationController?.pushViewController(vc, animated: true)
        }), for: .touchUpInside)

        let quizBtn = UIButton(type: .system)
        var qConfig = UIButton.Configuration.tinted()
        qConfig.title = "Bài tập"
        qConfig.image = UIImage(systemName: "pencil.and.outline")
        qConfig.imagePlacement = .leading
        qConfig.imagePadding = 6
        qConfig.baseBackgroundColor = accentColor
        qConfig.baseForegroundColor = accentColor
        quizBtn.configuration = qConfig
        quizBtn.layer.cornerRadius = 11
        quizBtn.clipsToBounds = true
        quizBtn.addAction(UIAction(handler: { [weak self] _ in
            let vc = GrammarQuizViewController(lesson: lesson)
            self?.navigationController?.pushViewController(vc, animated: true)
        }), for: .touchUpInside)

        let btnStack = UIStackView(arrangedSubviews: [studyBtn, quizBtn])
        btnStack.axis = .horizontal
        btnStack.distribution = .fillEqually
        btnStack.spacing = 10
        btnStack.translatesAutoresizingMaskIntoConstraints = false

        card.addSubview(badgeLabel)
        card.addSubview(statusLabel)
        card.addSubview(titleLabel)
        card.addSubview(summaryLabel)
        card.addSubview(pointsPreviewLabel)
        card.addSubview(btnStack)

        NSLayoutConstraint.activate([
            badgeLabel.topAnchor.constraint(equalTo: card.topAnchor, constant: 14),
            badgeLabel.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 16),
            badgeLabel.heightAnchor.constraint(equalToConstant: 22),

            statusLabel.centerYAnchor.constraint(equalTo: badgeLabel.centerYAnchor),
            statusLabel.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -16),

            titleLabel.topAnchor.constraint(equalTo: badgeLabel.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -16),

            summaryLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            summaryLabel.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 16),
            summaryLabel.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -16),

            pointsPreviewLabel.topAnchor.constraint(equalTo: summaryLabel.bottomAnchor, constant: 8),
            pointsPreviewLabel.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 16),
            pointsPreviewLabel.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -16),

            btnStack.topAnchor.constraint(equalTo: pointsPreviewLabel.bottomAnchor, constant: 12),
            btnStack.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 16),
            btnStack.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -16),
            btnStack.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -14),
            btnStack.heightAnchor.constraint(equalToConstant: 40)
        ])

        return card
    }
}
