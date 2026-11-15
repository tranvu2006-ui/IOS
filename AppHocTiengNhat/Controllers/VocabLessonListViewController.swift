//
//  VocabLessonListViewController.swift
//  AppHocTiengNhat
//

import UIKit

public class VocabLessonListViewController: UIViewController {

    private let scrollView = UIScrollView()
    private let contentView = UIView()

    private let headerCard = UIView()
    private let statsLabel = UILabel()
    private let statsProgressView = UIProgressView(progressViewStyle: .default)

    private let filterScrollView = UIScrollView()
    private let filterStackView = UIStackView()
    private var filterButtons: [UIButton] = []
    private var selectedFilterIndex: Int = 0

    private let listStackView = UIStackView()

    private let filterTitles: [String] = [
        "Tất cả (50)",
        "N5 (Bài 1-25)",
        "N4 (Bài 26-50)",
        "Bài 1-10",
        "Bài 11-20",
        "Bài 21-30",
        "Bài 31-40",
        "Bài 41-50",
        "5 Chủ đề"
    ]

    public override func viewDidLoad() {
        super.viewDidLoad()
        title = "Từ vựng Minna (50 Bài)"
        view.backgroundColor = .systemGroupedBackground
        navigationItem.largeTitleDisplayMode = .never

        setupUI()
        reloadCards()
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshHeaderStats()
        reloadCards()
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

        listStackView.axis = .vertical
        listStackView.spacing = 14
        listStackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(listStackView)

        NSLayoutConstraint.activate([
            headerCard.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14),
            headerCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18),
            headerCard.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -18),

            filterScrollView.topAnchor.constraint(equalTo: headerCard.bottomAnchor, constant: 14),
            filterScrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            filterScrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            filterScrollView.heightAnchor.constraint(equalToConstant: 40),

            listStackView.topAnchor.constraint(equalTo: filterScrollView.bottomAnchor, constant: 14),
            listStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18),
            listStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -18),
            listStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -28)
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
        titleLabel.text = "Từ vựng Minna no Nihongo I & II"
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        titleLabel.textColor = .label
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        statsLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        statsLabel.textColor = .systemPurple
        statsLabel.translatesAutoresizingMaskIntoConstraints = false

        statsProgressView.progressTintColor = .systemPurple
        statsProgressView.trackTintColor = .systemGray5
        statsProgressView.translatesAutoresizingMaskIntoConstraints = false

        let allFlashcardBtn = UIButton(type: .system)
        var fcConfig = UIButton.Configuration.filled()
        fcConfig.title = "Flashcard 50 Bài"
        fcConfig.image = UIImage(systemName: "rectangle.stack.fill")
        fcConfig.imagePlacement = .leading
        fcConfig.imagePadding = 6
        fcConfig.baseBackgroundColor = .systemPurple
        fcConfig.baseForegroundColor = .white
        allFlashcardBtn.configuration = fcConfig
        allFlashcardBtn.layer.cornerRadius = 12
        allFlashcardBtn.clipsToBounds = true
        allFlashcardBtn.addAction(UIAction(handler: { [weak self] _ in
            guard let self = self else { return }
            let words = self.wordsForCurrentFilter()
            let title = self.customTitleForCurrentFilter()
            let vc = VocabFlashcardViewController(customTitle: title, words: words)
            self.navigationController?.pushViewController(vc, animated: true)
        }), for: .touchUpInside)

        let allQuizBtn = UIButton(type: .system)
        var qConfig = UIButton.Configuration.tinted()
        qConfig.title = "Luyện nghe Tổng hợp"
        qConfig.image = UIImage(systemName: "headphones")
        qConfig.imagePlacement = .leading
        qConfig.imagePadding = 6
        qConfig.baseBackgroundColor = .systemPurple
        qConfig.baseForegroundColor = .systemPurple
        allQuizBtn.configuration = qConfig
        allQuizBtn.layer.cornerRadius = 12
        allQuizBtn.clipsToBounds = true
        allQuizBtn.addAction(UIAction(handler: { [weak self] _ in
            guard let self = self else { return }
            let words = self.wordsForCurrentFilter()
            let title = self.customTitleForCurrentFilter()
            let vc = VocabQuizViewController(customTitle: title, words: words)
            self.navigationController?.pushViewController(vc, animated: true)
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

        for (index, _) in filterTitles.enumerated() {
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
            let isSelected = (index == selectedFilterIndex)
            var config = isSelected ? UIButton.Configuration.filled() : UIButton.Configuration.tinted()
            config.title = filterTitles[index]
            config.contentInsets = NSDirectionalEdgeInsets(top: 6, leading: 14, bottom: 6, trailing: 14)
            config.baseBackgroundColor = isSelected ? .systemPurple : .secondarySystemGroupedBackground
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
        selectedFilterIndex = sender.tag
        updateFilterButtonStyles()
        reloadCards()
    }

    private func refreshHeaderStats() {
        let totalWords = VocabRepository.shared.vocabList.count
        let masteredCount = ProgressService.shared.getMasteredCount(prefix: "vocab_")
        statsLabel.text = "Đã thuộc: \(masteredCount) / \(totalWords) từ vựng (50 bài + 5 chủ đề)"
        let progress = totalWords > 0 ? Float(masteredCount) / Float(totalWords) : 0
        statsProgressView.setProgress(progress, animated: false)
    }

    private func filteredLessons() -> [VocabLesson] {
        let repo = VocabRepository.shared
        switch selectedFilterIndex {
        case 0:
            return repo.lessons
        case 1:
            return repo.getLessons(level: "N5")
        case 2:
            return repo.getLessons(level: "N4")
        case 3...7:
            let partTag = VocabRepository.partTags[selectedFilterIndex - 3]
            return repo.lessons.filter { $0.partTag == partTag }
        default:
            return []
        }
    }

    private func wordsForCurrentFilter() -> [VocabWord] {
        if selectedFilterIndex == 8 {
            return VocabRepository.shared.topicWords
        }
        return filteredLessons().flatMap { $0.words }
    }

    private func customTitleForCurrentFilter() -> String {
        switch selectedFilterIndex {
        case 0: return "50 Bài Minna no Nihongo"
        case 1: return "Từ vựng N5 (Bài 1-25)"
        case 2: return "Từ vựng N4 (Bài 26-50)"
        case 8: return "5 Chủ đề Giao tiếp"
        default: return filterTitles[selectedFilterIndex]
        }
    }

    private func reloadCards() {
        for arranged in listStackView.arrangedSubviews {
            listStackView.removeArrangedSubview(arranged)
            arranged.removeFromSuperview()
        }

        if selectedFilterIndex == 8 {
            for topic in VocabRepository.shared.topics {
                listStackView.addArrangedSubview(createTopicCard(topic: topic))
            }
        } else {
            for lesson in filteredLessons() {
                listStackView.addArrangedSubview(createLessonCard(lesson: lesson))
            }
        }
    }

    private func createLessonCard(lesson: VocabLesson) -> UIView {
        let isN4 = (lesson.jlptLevel == "N4")
        let accentColor: UIColor = isN4 ? .systemIndigo : .systemPurple
        let words = lesson.words
        let mastered = words.filter { ProgressService.shared.isMastered(id: $0.id) }.count

        let previewLines = words.prefix(4).map { word -> String in
            if let kanji = word.kanji, !kanji.isEmpty {
                return "• \(kanji) (\(word.kana)) — \(word.meaningVi)"
            }
            return "• \(word.kana) — \(word.meaningVi)"
        }
        let previewText = previewLines.joined(separator: "\n") + (words.count > 4 ? "\n• … và \(words.count - 4) từ khác" : "")

        return buildCard(
            badgeText: "  BÀI \(lesson.lessonNumber) • \(lesson.jlptLevel)  ",
            accentColor: accentColor,
            masteredCount: mastered,
            totalCount: words.count,
            title: lesson.title,
            subtitle: lesson.subtitle,
            preview: previewText,
            studyAction: { [weak self] in
                let vc = VocabFlashcardViewController(lesson: lesson)
                self?.navigationController?.pushViewController(vc, animated: true)
            },
            quizAction: { [weak self] in
                let vc = VocabQuizViewController(lesson: lesson)
                self?.navigationController?.pushViewController(vc, animated: true)
            }
        )
    }

    private func createTopicCard(topic: VocabTopic) -> UIView {
        let words = VocabRepository.shared.getWords(for: topic.id)
        let mastered = words.filter { ProgressService.shared.isMastered(id: $0.id) }.count
        let previewText = words.prefix(3).map { "• \($0.displayText) — \($0.meaningVi)" }.joined(separator: "\n")

        return buildCard(
            badgeText: "  CHỦ ĐỀ GIAO TIẾP  ",
            accentColor: .systemPurple,
            masteredCount: mastered,
            totalCount: words.count,
            title: topic.title,
            subtitle: topic.detail,
            preview: previewText,
            studyAction: { [weak self] in
                let vc = VocabFlashcardViewController(topic: topic)
                self?.navigationController?.pushViewController(vc, animated: true)
            },
            quizAction: { [weak self] in
                let vc = VocabQuizViewController(topic: topic)
                self?.navigationController?.pushViewController(vc, animated: true)
            }
        )
    }

    private func buildCard(
        badgeText: String,
        accentColor: UIColor,
        masteredCount: Int,
        totalCount: Int,
        title: String,
        subtitle: String,
        preview: String,
        studyAction: @escaping () -> Void,
        quizAction: @escaping () -> Void
    ) -> UIView {
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

        let badgeLabel = UILabel()
        badgeLabel.text = badgeText
        badgeLabel.font = .systemFont(ofSize: 11, weight: .bold)
        badgeLabel.textColor = accentColor
        badgeLabel.backgroundColor = accentColor.withAlphaComponent(0.14)
        badgeLabel.layer.cornerRadius = 6
        badgeLabel.clipsToBounds = true
        badgeLabel.translatesAutoresizingMaskIntoConstraints = false

        let statusLabel = UILabel()
        if masteredCount == totalCount && totalCount > 0 {
            statusLabel.text = "★ Đã thuộc hết (\(masteredCount)/\(totalCount))"
            statusLabel.textColor = .systemGreen
        } else if masteredCount > 0 {
            statusLabel.text = "★ \(masteredCount)/\(totalCount) từ"
            statusLabel.textColor = .systemOrange
        } else {
            statusLabel.text = "\(totalCount) từ vựng"
            statusLabel.textColor = .secondaryLabel
        }
        statusLabel.font = .systemFont(ofSize: 12, weight: .semibold)
        statusLabel.translatesAutoresizingMaskIntoConstraints = false

        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        titleLabel.textColor = .label
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        let subtitleLabel = UILabel()
        subtitleLabel.text = subtitle
        subtitleLabel.font = .systemFont(ofSize: 12.5, weight: .medium)
        subtitleLabel.textColor = accentColor
        subtitleLabel.numberOfLines = 0
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false

        let previewLabel = UILabel()
        previewLabel.text = preview
        previewLabel.font = .systemFont(ofSize: 12.5, weight: .regular)
        previewLabel.textColor = .secondaryLabel
        previewLabel.numberOfLines = 0
        previewLabel.translatesAutoresizingMaskIntoConstraints = false

        let studyBtn = UIButton(type: .system)
        var sConfig = UIButton.Configuration.filled()
        sConfig.title = "Học từ vựng"
        sConfig.image = UIImage(systemName: "menucard.fill")
        sConfig.imagePlacement = .leading
        sConfig.imagePadding = 6
        sConfig.baseBackgroundColor = accentColor
        sConfig.baseForegroundColor = .white
        studyBtn.configuration = sConfig
        studyBtn.layer.cornerRadius = 11
        studyBtn.clipsToBounds = true
        studyBtn.addAction(UIAction(handler: { _ in studyAction() }), for: .touchUpInside)

        let quizBtn = UIButton(type: .system)
        var qConfig = UIButton.Configuration.tinted()
        qConfig.title = "Luyện nghe"
        qConfig.image = UIImage(systemName: "headphones")
        qConfig.imagePlacement = .leading
        qConfig.imagePadding = 6
        qConfig.baseBackgroundColor = accentColor
        qConfig.baseForegroundColor = accentColor
        quizBtn.configuration = qConfig
        quizBtn.layer.cornerRadius = 11
        quizBtn.clipsToBounds = true
        quizBtn.addAction(UIAction(handler: { _ in quizAction() }), for: .touchUpInside)

        let btnStack = UIStackView(arrangedSubviews: [studyBtn, quizBtn])
        btnStack.axis = .horizontal
        btnStack.distribution = .fillEqually
        btnStack.spacing = 10
        btnStack.translatesAutoresizingMaskIntoConstraints = false

        card.addSubview(badgeLabel)
        card.addSubview(statusLabel)
        card.addSubview(titleLabel)
        card.addSubview(subtitleLabel)
        card.addSubview(previewLabel)
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

            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 3),
            subtitleLabel.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 16),
            subtitleLabel.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -16),

            previewLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 8),
            previewLabel.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 16),
            previewLabel.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -16),

            btnStack.topAnchor.constraint(equalTo: previewLabel.bottomAnchor, constant: 12),
            btnStack.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 16),
            btnStack.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -16),
            btnStack.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -14),
            btnStack.heightAnchor.constraint(equalToConstant: 40)
        ])

        return card
    }
}
