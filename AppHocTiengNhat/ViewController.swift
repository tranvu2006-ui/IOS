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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Tiếng Nhật N5 & N4"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.titleView = makeBrandTitleView()
        view.backgroundColor = .systemGroupedBackground
        
        setupNavButtons()
        setupViews()
    }

    private func makeBrandTitleView() -> UIView {
        let logoView = UIImageView(image: UIImage(named: "AppLogo"))
        logoView.contentMode = .scaleAspectFit
        logoView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoView.widthAnchor.constraint(equalToConstant: 30),
            logoView.heightAnchor.constraint(equalToConstant: 30)
        ])

        let titleLabel = UILabel()
        titleLabel.text = "Tiếng Nhật N5 & N4"
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        titleLabel.textColor = .label

        let brandView = UIStackView(arrangedSubviews: [logoView, titleLabel])
        brandView.axis = .horizontal
        brandView.alignment = .center
        brandView.spacing = 8
        brandView.isAccessibilityElement = true
        brandView.accessibilityLabel = "Tiếng Nhật N5 & N4"
        logoView.isAccessibilityElement = false
        titleLabel.isAccessibilityElement = false
        return brandView
    }

    private func setupNavButtons() {
        let searchBtn = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handleSearchTap))
        let bellBtn = UIBarButtonItem(image: UIImage(systemName: "bell.badge.fill"), style: .plain, target: self, action: #selector(handleNotificationTap))
        bellBtn.tintColor = .systemOrange
        navigationItem.rightBarButtonItems = [searchBtn, bellBtn]
    }

    @objc private func handleSearchTap() {
        let vc = SearchViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc private func handleNotificationTap() {
        let alert = UIAlertController(
            title: "Nhắc nhở học tập 🔥",
            message: "Hệ thống sẽ gửi thông báo mỗi tối để nhắc bạn luyện tập Flashcard và duy trì chuỗi Streak!",
            preferredStyle: .actionSheet
        )
        alert.addAction(UIAlertAction(title: "⏰ Bật nhắc nhở học 20:00 hàng ngày", style: .default, handler: { [weak self] _ in
            NotificationService.shared.requestAuthorization { granted in
                let notice = UIAlertController(
                    title: granted ? "Đã kích hoạt! 🔔" : "Chưa cấp quyền",
                    message: granted ? "Đã cài đặt chuông nhắc học tiếng Nhật lúc 20:00 mỗi tối." : "Vui lòng cấp quyền thông báo trong Cài đặt của máy.",
                    preferredStyle: .alert
                )
                notice.addAction(UIAlertAction(title: "OK", style: .default))
                self?.present(notice, animated: true)
            }
        }))
        alert.addAction(UIAlertAction(title: "⚡ Gửi thử thông báo (sau 3 giây)", style: .default, handler: { _ in
            NotificationService.shared.requestAuthorization { _ in
                NotificationService.shared.sendTestNotification()
            }
        }))
        alert.addAction(UIAlertAction(title: "Đóng", style: .cancel))
        present(alert, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        
        // 0.1 Quick Search Bar
        let searchBarCard = createSearchQuickBar()
        contentView.addSubview(searchBarCard)
        
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
        
        // 3. Kanji N5 & N4 Card
        let kanjiCard = createKanjiSectionCard(
            title: "Hán tự Kanji N5 & N4 (漢字)",
            subtitle: "68 chữ Hán trọng tâm cấp độ N5 (27 chữ) và N4 (41 chữ) kèm âm Hán Việt, On/Kun, số nét và từ ghép.",
            accentColor: .systemOrange
        )
        contentView.addSubview(kanjiCard)
        
        // 4. Grammar N5 & N4 (50 Lessons Minna no Nihongo) Card
        let grammarCard = createGrammarSectionCard(
            title: "Ngữ pháp N5 & N4 - 50 Bài Minna no Nihongo (文法)",
            subtitle: "Đầy đủ 50 bài N5 (Bài 1-25) & N4 (Bài 26-50): Hệ thống trợ từ, Chia thể động từ (て, ない, 辞書, た, Khả năng, Ý chí, Điều kiện, Bị động, Sai khiến, Kính ngữ) & 150 bài tập trắc nghiệm.",
            accentColor: .systemTeal
        )
        contentView.addSubview(grammarCard)

        // 5. Test Center Card (Kiểm tra Ngữ pháp, Từ vựng & Sổ tay từ chưa nhớ)
        let testCenterCard = createTestCenterSectionCard()
        contentView.addSubview(testCenterCard)
        
        // 6. Vocabulary by Topics Card (50 Bài Minna & Chủ đề)
        let vocabCard = createVocabTopicsSectionCard()
        contentView.addSubview(vocabCard)
        
        NSLayoutConstraint.activate([
            searchBarCard.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14),
            searchBarCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            searchBarCard.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            hiraganaCard.topAnchor.constraint(equalTo: searchBarCard.bottomAnchor, constant: 16),
            hiraganaCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            hiraganaCard.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            katakanaCard.topAnchor.constraint(equalTo: hiraganaCard.bottomAnchor, constant: 20),
            katakanaCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            katakanaCard.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            kanjiCard.topAnchor.constraint(equalTo: katakanaCard.bottomAnchor, constant: 20),
            kanjiCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            kanjiCard.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            grammarCard.topAnchor.constraint(equalTo: kanjiCard.bottomAnchor, constant: 20),
            grammarCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            grammarCard.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            testCenterCard.topAnchor.constraint(equalTo: grammarCard.bottomAnchor, constant: 20),
            testCenterCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            testCenterCard.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            vocabCard.topAnchor.constraint(equalTo: testCenterCard.bottomAnchor, constant: 20),
            vocabCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            vocabCard.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            vocabCard.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30)
        ])
    }

    private func createSearchQuickBar() -> UIView {
        let control = UIControl()
        control.backgroundColor = .secondarySystemGroupedBackground
        control.layer.cornerRadius = 14
        control.layer.borderWidth = 1
        control.layer.borderColor = UIColor.systemGray4.cgColor
        control.translatesAutoresizingMaskIntoConstraints = false
        
        let icon = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        icon.tintColor = .systemGray
        icon.contentMode = .scaleAspectFit
        icon.isUserInteractionEnabled = false
        icon.translatesAutoresizingMaskIntoConstraints = false
        
        let label = UILabel()
        label.text = "🔍 Tra cứu Từ vựng, Kanji, Ngữ pháp 50 Bài..."
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .secondaryLabel
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        control.addSubview(icon)
        control.addSubview(label)
        
        NSLayoutConstraint.activate([
            control.heightAnchor.constraint(equalToConstant: 46),
            icon.leadingAnchor.constraint(equalTo: control.leadingAnchor, constant: 14),
            icon.centerYAnchor.constraint(equalTo: control.centerYAnchor),
            icon.widthAnchor.constraint(equalToConstant: 20),
            icon.heightAnchor.constraint(equalToConstant: 20),
            
            label.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: control.trailingAnchor, constant: -14),
            label.centerYAnchor.constraint(equalTo: control.centerYAnchor)
        ])
        
        control.addAction(UIAction(handler: { [weak self] _ in
            self?.handleSearchTap()
        }), for: .touchUpInside)
        
        return control
    }

    private func createTestCenterSectionCard() -> UIView {
        let card = createBaseCard()
        
        let badge = UILabel()
        badge.text = " LUYỆN THI & SỔ TAY "
        badge.font = .systemFont(ofSize: 11, weight: .bold)
        badge.textColor = .systemRed
        badge.backgroundColor = UIColor.systemRed.withAlphaComponent(0.12)
        badge.layer.cornerRadius = 6
        badge.clipsToBounds = true
        badge.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = "Kiểm tra Tính điểm & Sổ tay Từ chưa nhớ"
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        titleLabel.textColor = .label
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let subtitleLabel = UILabel()
        subtitleLabel.text = "Thi trắc nghiệm tính điểm 100, giải thích ngữ pháp chi tiết và tự động lưu các từ làm sai vào sổ tay ôn tập."
        subtitleLabel.font = .systemFont(ofSize: 13, weight: .regular)
        subtitleLabel.textColor = .secondaryLabel
        subtitleLabel.numberOfLines = 0
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        // 0. Nhìn hình đoán chữ (Hình con chó, con mèo...)
        let pictureQuizRow = createTestOptionRow(
            title: "Nhìn hình đoán chữ (Hình ảnh 🐶, 🐱...)",
            detail: "Nhìn hình con vật, đồ ăn, phương tiện và chọn từ tiếng Nhật tương ứng",
            icon: "photo.on.rectangle.angled",
            color: .systemPink
        ) { [weak self] in
            let vc = PictureQuizViewController()
            self?.navigationController?.pushViewController(vc, animated: true)
        }

        // 1. Thi thử JLPT N5 & N4
        let mockTestRow = createTestOptionRow(
            title: "Thi thử JLPT N5 & N4 Mô phỏng",
            detail: "Đề thi 25 câu (Chữ Hán, Ngữ pháp, Nghe hiểu) tính giờ 25 phút & chấm điểm chuẩn thang 180",
            icon: "clock.badge.checkmark.fill",
            color: .systemIndigo
        ) { [weak self] in
            let vc = JLPTMockTestViewController()
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        
        // 2. Kiểm tra ngữ pháp
        let grammarTestRow = createTestOptionRow(
            title: "Kiểm tra Ngữ pháp Tính điểm",
            detail: "Trắc nghiệm trợ từ, dạng chia và mẫu câu N5 & N4",
            icon: "doc.badge.plus",
            color: .systemTeal
        ) { [weak self] in
            let vc = GrammarQuizViewController()
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        
        // 3. Kiểm tra từ vựng
        let vocabTestRow = createTestOptionRow(
            title: "Kiểm tra Từ vựng Tính điểm",
            detail: "Trắc nghiệm Hán tự, Kana và dịch nghĩa tính giờ",
            icon: "checkmark.seal.fill",
            color: .systemPurple
        ) { [weak self] in
            let vc = VocabTestViewController()
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        
        // 4. Sổ tay từ chưa nhớ
        let reviewWordsRow = createTestOptionRow(
            title: "Sổ tay Từ chưa nhớ & Đã thuộc",
            detail: "Xem danh sách từ làm sai, luyện Flashcard và kiểm tra lại",
            icon: "exclamationmark.triangle.fill",
            color: .systemOrange
        ) { [weak self] in
            let vc = NeedReviewWordsViewController()
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        
        stack.addArrangedSubview(pictureQuizRow)
        stack.addArrangedSubview(mockTestRow)
        stack.addArrangedSubview(grammarTestRow)
        stack.addArrangedSubview(vocabTestRow)
        stack.addArrangedSubview(reviewWordsRow)
        
        card.addSubview(badge)
        card.addSubview(titleLabel)
        card.addSubview(subtitleLabel)
        card.addSubview(stack)
        
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
            
            stack.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 14),
            stack.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 18),
            stack.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -18),
            stack.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -18)
        ])
        
        return card
    }

    private func createTestOptionRow(title: String, detail: String, icon: String, color: UIColor, onTap: @escaping () -> Void) -> UIView {
        let view = UIControl()
        view.backgroundColor = .secondarySystemGroupedBackground
        view.layer.cornerRadius = 14
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray5.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let iconView = UIImageView(image: UIImage(systemName: icon) ?? UIImage(systemName: "book.fill"))
        iconView.isUserInteractionEnabled = false
        iconView.tintColor = color
        iconView.contentMode = .scaleAspectFit
        iconView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.isUserInteractionEnabled = false
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 15, weight: .bold)
        titleLabel.textColor = .label
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let detailLabel = UILabel()
        detailLabel.isUserInteractionEnabled = false
        detailLabel.text = detail
        detailLabel.font = .systemFont(ofSize: 12, weight: .regular)
        detailLabel.textColor = .secondaryLabel
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let arrowView = UIImageView(image: UIImage(systemName: "chevron.right"))
        arrowView.isUserInteractionEnabled = false
        arrowView.tintColor = .systemGray3
        arrowView.contentMode = .scaleAspectFit
        arrowView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(iconView)
        view.addSubview(titleLabel)
        view.addSubview(detailLabel)
        view.addSubview(arrowView)
        
        NSLayoutConstraint.activate([
            view.heightAnchor.constraint(equalToConstant: 62),
            
            iconView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14),
            iconView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 24),
            iconView.heightAnchor.constraint(equalToConstant: 24),
            
            arrowView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -14),
            arrowView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            arrowView.widthAnchor.constraint(equalToConstant: 12),
            arrowView.heightAnchor.constraint(equalToConstant: 16),
            
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: arrowView.leadingAnchor, constant: -8),
            
            detailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),
            detailLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 12),
            detailLabel.trailingAnchor.constraint(equalTo: arrowView.leadingAnchor, constant: -8)
        ])
        
        view.addAction(UIAction(handler: { _ in
            onTap()
        }), for: .touchUpInside)
        
        return view
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
        
        let chartBtn = UIButton(type: .system)
        var cConfig = UIButton.Configuration.tinted()
        cConfig.title = "Bảng chữ"
        cConfig.image = UIImage(systemName: "tablecells.fill")
        cConfig.imagePlacement = .leading
        cConfig.imagePadding = 6
        cConfig.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont.systemFont(ofSize: 13, weight: .bold)
            return outgoing
        }
        cConfig.baseBackgroundColor = accentColor
        cConfig.baseForegroundColor = accentColor
        chartBtn.configuration = cConfig
        chartBtn.layer.cornerRadius = 12
        chartBtn.clipsToBounds = true
        chartBtn.addAction(UIAction(handler: { [weak self] _ in
            let vc = KanaChartViewController(initialType: kanaType)
            self?.navigationController?.pushViewController(vc, animated: true)
        }), for: .touchUpInside)

        let flashcardBtn = UIButton(type: .system)
        var fcConfig = UIButton.Configuration.filled()
        fcConfig.title = "Thẻ từ"
        fcConfig.image = UIImage(systemName: "menucard.fill")
        fcConfig.imagePlacement = .leading
        fcConfig.imagePadding = 6
        fcConfig.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont.systemFont(ofSize: 13, weight: .bold)
            return outgoing
        }
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
        qConfig.title = "Nghe âm"
        qConfig.image = UIImage(systemName: "headphones")
        qConfig.imagePlacement = .leading
        qConfig.imagePadding = 6
        qConfig.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont.systemFont(ofSize: 13, weight: .bold)
            return outgoing
        }
        qConfig.baseBackgroundColor = accentColor
        qConfig.baseForegroundColor = accentColor
        quizBtn.configuration = qConfig
        quizBtn.layer.cornerRadius = 12
        quizBtn.clipsToBounds = true
        quizBtn.addAction(UIAction(handler: { [weak self] _ in
            let vc = AudioQuizViewController(kanaType: kanaType)
            self?.navigationController?.pushViewController(vc, animated: true)
        }), for: .touchUpInside)
        
        let btnStack = UIStackView(arrangedSubviews: [chartBtn, flashcardBtn, quizBtn])
        btnStack.axis = .horizontal
        btnStack.distribution = .fillEqually
        btnStack.spacing = 8
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
        badge.text = " JLPT N5 & N4 "
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
        fcConfig.title = "Flashcard Hán tự"
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
        qConfig.title = "Luyện trắc nghiệm"
        qConfig.image = UIImage(systemName: "pencil.and.list.clipboard")
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

    private func createGrammarSectionCard(title: String, subtitle: String, accentColor: UIColor) -> UIView {
        return createTwoButtonSectionCard(
            badgeText: " GIÁO TRÌNH MINNA NO NIHONGO (50 BÀI N5 & N4) ",
            title: title,
            subtitle: subtitle,
            accentColor: accentColor,
            primaryTitle: "50 Bài Ngữ pháp",
            primaryIcon: "list.bullet.rectangle.portrait.fill",
            secondaryTitle: "Luyện trắc nghiệm",
            secondaryIcon: "checkmark.circle.badge.questionmark.fill",
            primaryAction: { [weak self] in
                let vc = GrammarLessonListViewController()
                self?.navigationController?.pushViewController(vc, animated: true)
            },
            secondaryAction: { [weak self] in
                let vc = GrammarQuizViewController()
                self?.navigationController?.pushViewController(vc, animated: true)
            }
        )
    }

    private func createTwoButtonSectionCard(
        badgeText: String,
        title: String,
        subtitle: String,
        accentColor: UIColor,
        primaryTitle: String,
        primaryIcon: String,
        secondaryTitle: String,
        secondaryIcon: String,
        primaryAction: @escaping () -> Void,
        secondaryAction: @escaping () -> Void
    ) -> UIView {
        let card = createBaseCard()
        
        let badge = UILabel()
        badge.text = badgeText
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
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let subtitleLabel = UILabel()
        subtitleLabel.text = subtitle
        subtitleLabel.font = .systemFont(ofSize: 13, weight: .regular)
        subtitleLabel.textColor = .secondaryLabel
        subtitleLabel.numberOfLines = 0
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let primaryBtn = UIButton(type: .system)
        var fcConfig = UIButton.Configuration.filled()
        fcConfig.title = primaryTitle
        fcConfig.image = UIImage(systemName: primaryIcon)
        fcConfig.imagePlacement = .leading
        fcConfig.imagePadding = 6
        fcConfig.baseBackgroundColor = accentColor
        fcConfig.baseForegroundColor = .white
        primaryBtn.configuration = fcConfig
        primaryBtn.layer.cornerRadius = 12
        primaryBtn.clipsToBounds = true
        primaryBtn.addAction(UIAction(handler: { _ in
            primaryAction()
        }), for: .touchUpInside)
        
        let secondaryBtn = UIButton(type: .system)
        var qConfig = UIButton.Configuration.tinted()
        qConfig.title = secondaryTitle
        qConfig.image = UIImage(systemName: secondaryIcon)
        qConfig.imagePlacement = .leading
        qConfig.imagePadding = 6
        qConfig.baseBackgroundColor = accentColor
        qConfig.baseForegroundColor = accentColor
        secondaryBtn.configuration = qConfig
        secondaryBtn.layer.cornerRadius = 12
        secondaryBtn.clipsToBounds = true
        secondaryBtn.addAction(UIAction(handler: { _ in
            secondaryAction()
        }), for: .touchUpInside)
        
        let btnStack = UIStackView(arrangedSubviews: [primaryBtn, secondaryBtn])
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
        badge.text = " TỪ VỰNG 50 BÀI (N5 & N4) & CHỦ ĐỀ "
        badge.font = .systemFont(ofSize: 11, weight: .bold)
        badge.textColor = .systemPurple
        badge.backgroundColor = UIColor.systemPurple.withAlphaComponent(0.12)
        badge.layer.cornerRadius = 6
        badge.clipsToBounds = true
        badge.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = "Từ vựng 50 Bài Minna & Chủ đề (語彙)"
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        titleLabel.textColor = .label
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let subtitleLabel = UILabel()
        subtitleLabel.text = "Trọn bộ 50 bài từ vựng Minna no Nihongo I & II kèm nhóm động từ【I / II / III】, trợ từ đi kèm và 5 chủ đề giao tiếp thực tế."
        subtitleLabel.font = .systemFont(ofSize: 13, weight: .regular)
        subtitleLabel.textColor = .secondaryLabel
        subtitleLabel.numberOfLines = 0
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false

        let lessonsBtn = UIButton(type: .system)
        var fcConfig = UIButton.Configuration.filled()
        fcConfig.title = "50 Bài từ vựng"
        fcConfig.image = UIImage(systemName: "books.vertical.fill")
        fcConfig.imagePlacement = .leading
        fcConfig.imagePadding = 6
        fcConfig.baseBackgroundColor = .systemPurple
        fcConfig.baseForegroundColor = .white
        lessonsBtn.configuration = fcConfig
        lessonsBtn.layer.cornerRadius = 12
        lessonsBtn.clipsToBounds = true
        lessonsBtn.addAction(UIAction(handler: { [weak self] _ in
            let vc = VocabLessonListViewController()
            self?.navigationController?.pushViewController(vc, animated: true)
        }), for: .touchUpInside)

        let quizBtn = UIButton(type: .system)
        var qConfig = UIButton.Configuration.tinted()
        qConfig.title = "Luyện nghe 50 Bài"
        qConfig.image = UIImage(systemName: "headphones")
        qConfig.imagePlacement = .leading
        qConfig.imagePadding = 6
        qConfig.baseBackgroundColor = .systemPurple
        qConfig.baseForegroundColor = .systemPurple
        quizBtn.configuration = qConfig
        quizBtn.layer.cornerRadius = 12
        quizBtn.clipsToBounds = true
        quizBtn.addAction(UIAction(handler: { [weak self] _ in
            let vc = VocabQuizViewController(customTitle: "50 Bài Minna", words: VocabRepository.shared.getAllLessonWords())
            self?.navigationController?.pushViewController(vc, animated: true)
        }), for: .touchUpInside)

        let actionStack = UIStackView(arrangedSubviews: [lessonsBtn, quizBtn])
        actionStack.axis = .horizontal
        actionStack.distribution = .fillEqually
        actionStack.spacing = 12
        actionStack.translatesAutoresizingMaskIntoConstraints = false
        
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
        card.addSubview(actionStack)
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

            actionStack.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 14),
            actionStack.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 18),
            actionStack.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -18),
            actionStack.heightAnchor.constraint(equalToConstant: 44),
            
            topicsStack.topAnchor.constraint(equalTo: actionStack.bottomAnchor, constant: 14),
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
