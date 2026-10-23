//
//  ViewController.swift
//  AppHocTiengNhat
//
//  Created by User on 23.10.2026.
//

import UIKit

class ViewController: UIViewController {

    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let statsHeader = StatsHeaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Tiếng Nhật N5"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemGroupedBackground
        
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        statsHeader.refresh()
    }

    private func setupViews() {
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
        
        // 0. Stats Header
        statsHeader.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(statsHeader)
        
        // 1. Hiragana Section Card
        let hiraganaCard = createKanaSectionCard(
            title: "Bảng chữ Hiragana (ひらがな)",
            subtitle: "46 ký tự chữ mềm cơ bản dùng cho ngữ pháp và từ thuần Nhật.",
            accentColor: .systemBlue,
            kanaType: .hiragana
        )
        contentView.addSubview(hiraganaCard)
        
        // 2. Katakana Section Card
        let katakanaCard = createKanaSectionCard(
            title: "Bảng chữ Katakana (カタカナ)",
            subtitle: "46 ký tự chữ cứng dùng cho từ mượn tiếng nước ngoài.",
            accentColor: .systemIndigo,
            kanaType: .katakana
        )
        contentView.addSubview(katakanaCard)
        
        // 3. Kanji N5 Card
        let kanjiCard = createKanjiSectionCard(
            title: "Hán tự Kanji N5 (漢字)",
            subtitle: "Học chữ Hán qua âm Hán Việt, âm On/Kun và luyện nghe từ vựng.",
            accentColor: .systemOrange
        )
        contentView.addSubview(kanjiCard)
        
        // 4. Vocabulary by Topics Card
        let vocabCard = createVocabTopicsSectionCard()
        contentView.addSubview(vocabCard)
        
        NSLayoutConstraint.activate([
            statsHeader.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            statsHeader.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            statsHeader.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            hiraganaCard.topAnchor.constraint(equalTo: statsHeader.bottomAnchor, constant: 20),
            hiraganaCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            hiraganaCard.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            katakanaCard.topAnchor.constraint(equalTo: hiraganaCard.bottomAnchor, constant: 20),
            katakanaCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            katakanaCard.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            kanjiCard.topAnchor.constraint(equalTo: katakanaCard.bottomAnchor, constant: 20),
            kanjiCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            kanjiCard.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            vocabCard.topAnchor.constraint(equalTo: kanjiCard.bottomAnchor, constant: 20),
            vocabCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            vocabCard.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            vocabCard.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30)
        ])
    }
    
    private func createKanaSectionCard(title: String, subtitle: String, accentColor: UIColor, kanaType: KanaType) -> UIView {
        let card = createBaseCard()
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        titleLabel.textColor = .label
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let subtitleLabel = UILabel()
        subtitleLabel.text = subtitle
        subtitleLabel.font = .systemFont(ofSize: 13, weight: .regular)
        subtitleLabel.textColor = .secondaryLabel
        subtitleLabel.numberOfLines = 0
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let flashcardBtn = UIButton(type: .system)
        var fcConfig = UIButton.Configuration.filled()
        fcConfig.title = "Flashcard"
        fcConfig.image = UIImage(systemName: "menucard")
        fcConfig.imagePlacement = .leading
        fcConfig.imagePadding = 6
        fcConfig.baseBackgroundColor = accentColor
        fcConfig.baseForegroundColor = .white
        flashcardBtn.configuration = fcConfig
        flashcardBtn.layer.cornerRadius = 12
        flashcardBtn.clipsToBounds = true
        flashcardBtn.addAction(UIAction(handler: { [weak self] _ in
            let vc = FlashcardViewController(kanaType: kanaType)
            self?.navigationController?.pushViewController(vc, animated: true)
        }), for: .touchUpInside)
        
        let quizBtn = UIButton(type: .system)
        var qConfig = UIButton.Configuration.tinted()
        qConfig.title = "Luyện nghe"
        qConfig.image = UIImage(systemName: "headphones")
        qConfig.imagePlacement = .leading
        qConfig.imagePadding = 6
        qConfig.baseBackgroundColor = accentColor
        qConfig.baseForegroundColor = accentColor
        quizBtn.configuration = qConfig
        quizBtn.layer.cornerRadius = 12
        quizBtn.clipsToBounds = true
        quizBtn.addAction(UIAction(handler: { [weak self] _ in
            let vc = AudioQuizViewController(kanaType: kanaType)
            self?.navigationController?.pushViewController(vc, animated: true)
        }), for: .touchUpInside)
        
        let btnStack = UIStackView(arrangedSubviews: [flashcardBtn, quizBtn])
        btnStack.axis = .horizontal
        btnStack.distribution = .fillEqually
        btnStack.spacing = 12
        btnStack.translatesAutoresizingMaskIntoConstraints = false
        
        card.addSubview(titleLabel)
        card.addSubview(subtitleLabel)
        card.addSubview(btnStack)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: card.topAnchor, constant: 18),
            titleLabel.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 18),
            titleLabel.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -18),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
            subtitleLabel.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 18),
            subtitleLabel.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -18),
            
            btnStack.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 16),
            btnStack.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 18),
            btnStack.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -18),
            btnStack.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -18),
            btnStack.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        return card
    }
    
    private func createKanjiSectionCard(title: String, subtitle: String, accentColor: UIColor) -> UIView {
        let card = createBaseCard()
        
        let badge = UILabel()
        badge.text = " JLPT N5 • HÁN TỰ "
        badge.font = .systemFont(ofSize: 11, weight: .bold)
        badge.textColor = accentColor
        badge.backgroundColor = accentColor.withAlphaComponent(0.12)
        badge.layer.cornerRadius = 6
        badge.clipsToBounds = true
        badge.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        titleLabel.textColor = .label
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let subtitleLabel = UILabel()
        subtitleLabel.text = subtitle
        subtitleLabel.font = .systemFont(ofSize: 13, weight: .regular)
        subtitleLabel.textColor = .secondaryLabel
        subtitleLabel.numberOfLines = 0
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let flashcardBtn = UIButton(type: .system)
        var fcConfig = UIButton.Configuration.filled()
        fcConfig.title = "Flashcard"
        fcConfig.image = UIImage(systemName: "character.book.closed.fill")
        fcConfig.imagePlacement = .leading
        fcConfig.imagePadding = 6
        fcConfig.baseBackgroundColor = accentColor
        fcConfig.baseForegroundColor = .white
        flashcardBtn.configuration = fcConfig
        flashcardBtn.layer.cornerRadius = 12
        flashcardBtn.clipsToBounds = true
        flashcardBtn.addAction(UIAction(handler: { [weak self] _ in
            let vc = KanjiFlashcardViewController()
            self?.navigationController?.pushViewController(vc, animated: true)
        }), for: .touchUpInside)
        
        let quizBtn = UIButton(type: .system)
        var qConfig = UIButton.Configuration.tinted()
        qConfig.title = "Luyện nghe"
        qConfig.image = UIImage(systemName: "headphones")
        qConfig.imagePlacement = .leading
        qConfig.imagePadding = 6
        qConfig.baseBackgroundColor = accentColor
        qConfig.baseForegroundColor = accentColor
        quizBtn.configuration = qConfig
        quizBtn.layer.cornerRadius = 12
        quizBtn.clipsToBounds = true
        quizBtn.addAction(UIAction(handler: { [weak self] _ in
            let vc = KanjiQuizViewController()
            self?.navigationController?.pushViewController(vc, animated: true)
        }), for: .touchUpInside)
        
        let btnStack = UIStackView(arrangedSubviews: [flashcardBtn, quizBtn])
        btnStack.axis = .horizontal
        btnStack.distribution = .fillEqually
        btnStack.spacing = 12
        btnStack.translatesAutoresizingMaskIntoConstraints = false
        
        card.addSubview(badge)
        card.addSubview(titleLabel)
        card.addSubview(subtitleLabel)
        card.addSubview(btnStack)
        
        NSLayoutConstraint.activate([
            badge.topAnchor.constraint(equalTo: card.topAnchor, constant: 16),
            badge.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 18),
            badge.heightAnchor.constraint(equalToConstant: 22),
            
            titleLabel.topAnchor.constraint(equalTo: badge.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 18),
            titleLabel.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -18),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
            subtitleLabel.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 18),
            subtitleLabel.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -18),
            
            btnStack.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 16),
            btnStack.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 18),
            btnStack.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -18),
            btnStack.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -18),
            btnStack.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        return card
    }
    
    private func createVocabTopicsSectionCard() -> UIView {
        let card = createBaseCard()
        
        let badge = UILabel()
        badge.text = " TỪ VỰNG CHỦ ĐỀ N5 "
        badge.font = .systemFont(ofSize: 11, weight: .bold)
        badge.textColor = .systemPurple
        badge.backgroundColor = UIColor.systemPurple.withAlphaComponent(0.12)
        badge.layer.cornerRadius = 6
        badge.clipsToBounds = true
        badge.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = "Từ vựng Giao tiếp theo Chủ đề"
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        titleLabel.textColor = .label
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let subtitleLabel = UILabel()
        subtitleLabel.text = "Học từ vựng qua ngữ cảnh thực tế với câu ví dụ và luyện nghe chọn nghĩa."
        subtitleLabel.font = .systemFont(ofSize: 13, weight: .regular)
        subtitleLabel.textColor = .secondaryLabel
        subtitleLabel.numberOfLines = 0
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let topicsStack = UIStackView()
        topicsStack.axis = .vertical
        topicsStack.spacing = 10
        topicsStack.translatesAutoresizingMaskIntoConstraints = false
        
        for topic in VocabRepository.shared.topics {
            let row = createTopicRow(topic: topic)
            topicsStack.addArrangedSubview(row)
        }
        
        card.addSubview(badge)
        card.addSubview(titleLabel)
        card.addSubview(subtitleLabel)
        card.addSubview(topicsStack)
        
        NSLayoutConstraint.activate([
            badge.topAnchor.constraint(equalTo: card.topAnchor, constant: 16),
            badge.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 18),
            badge.heightAnchor.constraint(equalToConstant: 22),
            
            titleLabel.topAnchor.constraint(equalTo: badge.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 18),
            titleLabel.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -18),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
            subtitleLabel.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 18),
            subtitleLabel.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -18),
            
            topicsStack.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 16),
            topicsStack.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 18),
            topicsStack.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -18),
            topicsStack.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -18)
        ])
        
        return card
    }
    
    private func createTopicRow(topic: VocabTopic) -> UIView {
        let view = UIView()
        view.backgroundColor = .secondarySystemGroupedBackground
        view.layer.cornerRadius = 14
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray5.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let iconView = UIImageView(image: UIImage(systemName: topic.iconName))
        iconView.tintColor = .systemPurple
        iconView.contentMode = .scaleAspectFit
        iconView.translatesAutoresizingMaskIntoConstraints = false
        
        let nameLabel = UILabel()
        nameLabel.text = topic.title
        nameLabel.font = .systemFont(ofSize: 15, weight: .bold)
        nameLabel.textColor = .label
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let detailLabel = UILabel()
        detailLabel.text = topic.detail
        detailLabel.font = .systemFont(ofSize: 12, weight: .regular)
        detailLabel.textColor = .secondaryLabel
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let flashcardBtn = UIButton(type: .system)
        flashcardBtn.setImage(UIImage(systemName: "menucard.fill"), for: .normal)
        flashcardBtn.tintColor = .systemPurple
        flashcardBtn.backgroundColor = UIColor.systemPurple.withAlphaComponent(0.12)
        flashcardBtn.layer.cornerRadius = 18
        flashcardBtn.translatesAutoresizingMaskIntoConstraints = false
        flashcardBtn.addAction(UIAction(handler: { [weak self] _ in
            let vc = VocabFlashcardViewController(topic: topic)
            self?.navigationController?.pushViewController(vc, animated: true)
        }), for: .touchUpInside)
        
        let quizBtn = UIButton(type: .system)
        quizBtn.setImage(UIImage(systemName: "headphones"), for: .normal)
        quizBtn.tintColor = .systemPurple
        quizBtn.backgroundColor = UIColor.systemPurple.withAlphaComponent(0.12)
        quizBtn.layer.cornerRadius = 18
        quizBtn.translatesAutoresizingMaskIntoConstraints = false
        quizBtn.addAction(UIAction(handler: { [weak self] _ in
            let vc = VocabQuizViewController(topic: topic)
            self?.navigationController?.pushViewController(vc, animated: true)
        }), for: .touchUpInside)
        
        view.addSubview(iconView)
        view.addSubview(nameLabel)
        view.addSubview(detailLabel)
        view.addSubview(flashcardBtn)
        view.addSubview(quizBtn)
        
        NSLayoutConstraint.activate([
            view.heightAnchor.constraint(equalToConstant: 64),
            
            iconView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14),
            iconView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 24),
            iconView.heightAnchor.constraint(equalToConstant: 24),
            
            nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 12),
            nameLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 12),
            nameLabel.trailingAnchor.constraint(equalTo: flashcardBtn.leadingAnchor, constant: -8),
            
            detailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2),
            detailLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 12),
            detailLabel.trailingAnchor.constraint(equalTo: flashcardBtn.leadingAnchor, constant: -8),
            
            flashcardBtn.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            flashcardBtn.trailingAnchor.constraint(equalTo: quizBtn.leadingAnchor, constant: -10),
            flashcardBtn.widthAnchor.constraint(equalToConstant: 36),
            flashcardBtn.heightAnchor.constraint(equalToConstant: 36),
            
            quizBtn.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            quizBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -14),
            quizBtn.widthAnchor.constraint(equalToConstant: 36),
            quizBtn.heightAnchor.constraint(equalToConstant: 36)
        ])
        
        return view
    }
    
    private func createBaseCard() -> UIView {
        let card = UIView()
        card.backgroundColor = .systemBackground
        card.layer.cornerRadius = 20
        card.layer.borderWidth = 1
        card.layer.borderColor = UIColor.systemGray5.cgColor
        card.layer.shadowColor = UIColor.black.cgColor
        card.layer.shadowOpacity = 0.06
        card.layer.shadowOffset = CGSize(width: 0, height: 4)
        card.layer.shadowRadius = 8
        card.translatesAutoresizingMaskIntoConstraints = false
        return card
    }
}
