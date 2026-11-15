//
//  NeedReviewWordsViewController.swift
//  AppHocTiengNhat
//

import UIKit

public class NeedReviewWordsViewController: UIViewController, UISearchResultsUpdating {
    
    public enum NotebookTab: Int {
        case needReview = 0
        case mastered = 1
    }
    
    private var currentTab: NotebookTab = .needReview
    
    private var words: [VocabWord] = []
    private var filteredWords: [VocabWord] = []
    
    private let segmentedControl = UISegmentedControl(items: ["⚠️ Cần ôn tập", "⭐ Đã thuộc"])
    private let searchController = UISearchController(searchResultsController: nil)
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    private let emptyStateView = UIView()
    private let emptyIcon = UIImageView()
    private let emptyTitleLbl = UILabel()
    private let emptyDescLbl = UILabel()
    
    private let headerActionContainer = UIView()
    private let statsBadge = UILabel()
    private let flashcardActionBtn = UIButton(type: .system)
    private let testActionBtn = UIButton(type: .system)
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sổ tay từ vựng"
        view.backgroundColor = .systemGroupedBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        setupSegmentedControl()
        setupSearchController()
        setupUI()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadWords()
    }
    
    private func setupSegmentedControl() {
        segmentedControl.selectedSegmentIndex = currentTab.rawValue
        segmentedControl.selectedSegmentTintColor = .systemPurple
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 13, weight: .bold)], for: .selected)
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.label, .font: UIFont.systemFont(ofSize: 13, weight: .medium)], for: .normal)
        segmentedControl.addTarget(self, action: #selector(didChangeTab), for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
    }
    
    @objc private func didChangeTab() {
        currentTab = NotebookTab(rawValue: segmentedControl.selectedSegmentIndex) ?? .needReview
        searchController.searchBar.text = ""
        reloadWords()
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Tìm kiếm từ trong danh sách..."
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
    
    private func setupUI() {
        // Top Header Actions Container
        headerActionContainer.backgroundColor = .secondarySystemGroupedBackground
        headerActionContainer.layer.cornerRadius = 16
        headerActionContainer.layer.borderWidth = 1
        headerActionContainer.layer.borderColor = UIColor.systemGray5.cgColor
        headerActionContainer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerActionContainer)
        
        statsBadge.font = .systemFont(ofSize: 13, weight: .bold)
        statsBadge.layer.cornerRadius = 8
        statsBadge.clipsToBounds = true
        statsBadge.textAlignment = .center
        statsBadge.translatesAutoresizingMaskIntoConstraints = false
        headerActionContainer.addSubview(statsBadge)
        
        var fcConfig = UIButton.Configuration.filled()
        fcConfig.title = "Luyện Flashcard"
        fcConfig.image = UIImage(systemName: "menucard.fill")
        fcConfig.imagePlacement = .leading
        fcConfig.imagePadding = 6
        fcConfig.baseBackgroundColor = .systemPurple
        fcConfig.baseForegroundColor = .white
        flashcardActionBtn.configuration = fcConfig
        flashcardActionBtn.layer.cornerRadius = 12
        flashcardActionBtn.clipsToBounds = true
        flashcardActionBtn.translatesAutoresizingMaskIntoConstraints = false
        flashcardActionBtn.addTarget(self, action: #selector(didTapStudyFlashcard), for: .touchUpInside)
        headerActionContainer.addSubview(flashcardActionBtn)
        
        var testConfig = UIButton.Configuration.filled()
        testConfig.title = "Kiểm tra lại"
        testConfig.image = UIImage(systemName: "checkmark.seal.fill")
        testConfig.imagePlacement = .leading
        testConfig.imagePadding = 6
        testConfig.baseBackgroundColor = .systemTeal
        testConfig.baseForegroundColor = .white
        testActionBtn.configuration = testConfig
        testActionBtn.layer.cornerRadius = 12
        testActionBtn.clipsToBounds = true
        testActionBtn.translatesAutoresizingMaskIntoConstraints = false
        testActionBtn.addTarget(self, action: #selector(didTapTestReviewWords), for: .touchUpInside)
        headerActionContainer.addSubview(testActionBtn)
        
        // Table View
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NeedReviewWordCell.self, forCellReuseIdentifier: NeedReviewWordCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 90
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        // Empty state view
        setupEmptyStateView()
        
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 6),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            segmentedControl.heightAnchor.constraint(equalToConstant: 34),
            
            headerActionContainer.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 10),
            headerActionContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            headerActionContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            statsBadge.topAnchor.constraint(equalTo: headerActionContainer.topAnchor, constant: 12),
            statsBadge.leadingAnchor.constraint(equalTo: headerActionContainer.leadingAnchor, constant: 14),
            statsBadge.heightAnchor.constraint(equalToConstant: 26),
            statsBadge.widthAnchor.constraint(greaterThanOrEqualToConstant: 120),
            
            flashcardActionBtn.topAnchor.constraint(equalTo: statsBadge.bottomAnchor, constant: 12),
            flashcardActionBtn.leadingAnchor.constraint(equalTo: headerActionContainer.leadingAnchor, constant: 14),
            flashcardActionBtn.bottomAnchor.constraint(equalTo: headerActionContainer.bottomAnchor, constant: -12),
            flashcardActionBtn.heightAnchor.constraint(equalToConstant: 38),
            
            testActionBtn.topAnchor.constraint(equalTo: statsBadge.bottomAnchor, constant: 12),
            testActionBtn.leadingAnchor.constraint(equalTo: flashcardActionBtn.trailingAnchor, constant: 10),
            testActionBtn.trailingAnchor.constraint(equalTo: headerActionContainer.trailingAnchor, constant: -14),
            testActionBtn.bottomAnchor.constraint(equalTo: headerActionContainer.bottomAnchor, constant: -12),
            testActionBtn.widthAnchor.constraint(equalTo: flashcardActionBtn.widthAnchor),
            testActionBtn.heightAnchor.constraint(equalToConstant: 38),
            
            tableView.topAnchor.constraint(equalTo: headerActionContainer.bottomAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupEmptyStateView() {
        emptyStateView.translatesAutoresizingMaskIntoConstraints = false
        emptyStateView.isHidden = true
        view.addSubview(emptyStateView)
        
        emptyIcon.contentMode = .scaleAspectFit
        emptyIcon.translatesAutoresizingMaskIntoConstraints = false
        
        emptyTitleLbl.font = .systemFont(ofSize: 17, weight: .bold)
        emptyTitleLbl.textColor = .label
        emptyTitleLbl.textAlignment = .center
        emptyTitleLbl.translatesAutoresizingMaskIntoConstraints = false
        
        emptyDescLbl.font = .systemFont(ofSize: 14, weight: .regular)
        emptyDescLbl.textColor = .secondaryLabel
        emptyDescLbl.textAlignment = .center
        emptyDescLbl.numberOfLines = 0
        emptyDescLbl.translatesAutoresizingMaskIntoConstraints = false
        
        emptyStateView.addSubview(emptyIcon)
        emptyStateView.addSubview(emptyTitleLbl)
        emptyStateView.addSubview(emptyDescLbl)
        
        NSLayoutConstraint.activate([
            emptyStateView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyStateView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 20),
            emptyStateView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            emptyStateView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            emptyIcon.topAnchor.constraint(equalTo: emptyStateView.topAnchor),
            emptyIcon.centerXAnchor.constraint(equalTo: emptyStateView.centerXAnchor),
            emptyIcon.widthAnchor.constraint(equalToConstant: 64),
            emptyIcon.heightAnchor.constraint(equalToConstant: 64),
            
            emptyTitleLbl.topAnchor.constraint(equalTo: emptyIcon.bottomAnchor, constant: 16),
            emptyTitleLbl.leadingAnchor.constraint(equalTo: emptyStateView.leadingAnchor),
            emptyTitleLbl.trailingAnchor.constraint(equalTo: emptyStateView.trailingAnchor),
            
            emptyDescLbl.topAnchor.constraint(equalTo: emptyTitleLbl.bottomAnchor, constant: 8),
            emptyDescLbl.leadingAnchor.constraint(equalTo: emptyStateView.leadingAnchor),
            emptyDescLbl.trailingAnchor.constraint(equalTo: emptyStateView.trailingAnchor),
            emptyDescLbl.bottomAnchor.constraint(equalTo: emptyStateView.bottomAnchor)
        ])
    }
    
    private func reloadWords() {
        let needReviewCount = ProgressService.shared.getNeedReviewCount()
        let masteredCount = ProgressService.shared.getMasteredWords().count
        
        segmentedControl.setTitle("⚠️ Cần ôn (\(needReviewCount))", forSegmentAt: 0)
        segmentedControl.setTitle("⭐ Đã thuộc (\(masteredCount))", forSegmentAt: 1)
        
        if currentTab == .needReview {
            words = ProgressService.shared.getNeedReviewWords()
            statsBadge.text = " ⚠️ Cần ôn tập: \(words.count) từ "
            statsBadge.textColor = .systemOrange
            statsBadge.backgroundColor = UIColor.systemOrange.withAlphaComponent(0.12)
            
            var fcConfig = flashcardActionBtn.configuration ?? UIButton.Configuration.filled()
            fcConfig.title = "Luyện Flashcard"
            flashcardActionBtn.configuration = fcConfig
            
            emptyIcon.image = UIImage(systemName: "checkmark.circle.fill")
            emptyIcon.tintColor = .systemGreen
            emptyTitleLbl.text = "Tuyệt vời! Không có từ nào cần ôn tập 🎉"
            emptyDescLbl.text = "Khi bạn làm bài kiểm tra hoặc quiz bị sai, từ vựng sẽ tự động được lưu vào đây để bạn dễ dàng ôn lại."
        } else {
            words = ProgressService.shared.getMasteredWords()
            statsBadge.text = " ⭐ Đã thuộc: \(words.count) từ "
            statsBadge.textColor = .systemGreen
            statsBadge.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.12)
            
            var fcConfig = flashcardActionBtn.configuration ?? UIButton.Configuration.filled()
            fcConfig.title = "Ôn lại Flashcard"
            flashcardActionBtn.configuration = fcConfig
            
            emptyIcon.image = UIImage(systemName: "star.circle.fill")
            emptyIcon.tintColor = .systemYellow
            emptyTitleLbl.text = "Chưa có từ nào được đánh dấu đã thuộc ⭐"
            emptyDescLbl.text = "Khi học từ vựng trên Flashcard, hãy chạm vào biểu tượng Ngôi sao ⭐ để đánh dấu những từ bạn đã ghi nhớ vững vàng nhé!"
        }
        
        filterWords()
        
        let count = words.count
        headerActionContainer.isHidden = (count == 0)
        tableView.isHidden = (count == 0)
        emptyStateView.isHidden = (count > 0)
    }
    
    public func updateSearchResults(for searchController: UISearchController) {
        filterWords()
    }
    
    private func filterWords() {
        let text = searchController.searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() ?? ""
        if text.isEmpty {
            filteredWords = words
        } else {
            filteredWords = words.filter {
                ($0.kanji?.lowercased().contains(text) ?? false) ||
                $0.kana.lowercased().contains(text) ||
                $0.romaji.lowercased().contains(text) ||
                $0.meaningVi.lowercased().contains(text)
            }
        }
        tableView.reloadData()
    }
    
    @objc private func didTapStudyFlashcard() {
        guard !words.isEmpty else { return }
        if currentTab == .needReview {
            let lessonTitle = "Sổ tay từ chưa nhớ (\(words.count) từ)"
            let vc = VocabFlashcardViewController(customTitle: lessonTitle, words: words)
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let lessonTitle = "Danh sách từ đã thuộc (\(words.count) từ)"
            let vc = VocabFlashcardViewController(customTitle: lessonTitle, words: words)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc private func didTapTestReviewWords() {
        guard !words.isEmpty else { return }
        let vc = VocabTestViewController(customWords: words)
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension NeedReviewWordsViewController: UITableViewDataSource, UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredWords.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NeedReviewWordCell.identifier, for: indexPath) as? NeedReviewWordCell else {
            return UITableViewCell()
        }
        
        let word = filteredWords[indexPath.row]
        let isMasteredMode = (currentTab == .mastered)
        
        cell.configure(word: word, isMasteredMode: isMasteredMode) { [weak self] in
            guard let self = self else { return }
            if isMasteredMode {
                // User wants to unmark mastered -> move back to need review
                ProgressService.shared.unmarkMastered(id: word.id)
                ProgressService.shared.markWordForReview(id: word.id)
                AudioService.shared.playCorrectFeedback()
            } else {
                // User marks as mastered -> removed from review list and added to mastered
                _ = ProgressService.shared.toggleMastered(id: word.id)
                AudioService.shared.playCorrectFeedback()
            }
            self.reloadWords()
        }
        return cell
    }
}

// MARK: - Custom Cell
final class NeedReviewWordCell: UITableViewCell {
    static let identifier = "NeedReviewWordCell"
    
    private let jpWordLabel = UILabel()
    private let readingLabel = UILabel()
    private let meaningLabel = UILabel()
    private let speakBtn = UIButton(type: .system)
    private let actionBtn = UIButton(type: .system)
    
    private var onActionTap: (() -> Void)?
    private var currentWord: VocabWord?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        jpWordLabel.font = .systemFont(ofSize: 18, weight: .bold)
        jpWordLabel.textColor = .label
        jpWordLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(jpWordLabel)
        
        readingLabel.font = .systemFont(ofSize: 12, weight: .regular)
        readingLabel.textColor = .secondaryLabel
        readingLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(readingLabel)
        
        meaningLabel.font = .systemFont(ofSize: 14, weight: .medium)
        meaningLabel.textColor = .systemPurple
        meaningLabel.numberOfLines = 0
        meaningLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(meaningLabel)
        
        speakBtn.setImage(UIImage(systemName: "speaker.wave.2.fill"), for: .normal)
        speakBtn.tintColor = .systemPurple
        speakBtn.backgroundColor = UIColor.systemPurple.withAlphaComponent(0.12)
        speakBtn.layer.cornerRadius = 16
        speakBtn.translatesAutoresizingMaskIntoConstraints = false
        speakBtn.addTarget(self, action: #selector(speakTapped), for: .touchUpInside)
        contentView.addSubview(speakBtn)
        
        actionBtn.titleLabel?.font = .systemFont(ofSize: 12, weight: .semibold)
        actionBtn.translatesAutoresizingMaskIntoConstraints = false
        actionBtn.addTarget(self, action: #selector(actionTapped), for: .touchUpInside)
        contentView.addSubview(actionBtn)
        
        NSLayoutConstraint.activate([
            jpWordLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            jpWordLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            jpWordLabel.trailingAnchor.constraint(equalTo: speakBtn.leadingAnchor, constant: -8),
            
            readingLabel.topAnchor.constraint(equalTo: jpWordLabel.bottomAnchor, constant: 2),
            readingLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            readingLabel.trailingAnchor.constraint(equalTo: speakBtn.leadingAnchor, constant: -8),
            
            meaningLabel.topAnchor.constraint(equalTo: readingLabel.bottomAnchor, constant: 4),
            meaningLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            meaningLabel.trailingAnchor.constraint(equalTo: actionBtn.leadingAnchor, constant: -8),
            meaningLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            
            speakBtn.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            speakBtn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            speakBtn.widthAnchor.constraint(equalToConstant: 32),
            speakBtn.heightAnchor.constraint(equalToConstant: 32),
            
            actionBtn.centerYAnchor.constraint(equalTo: meaningLabel.centerYAnchor),
            actionBtn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            actionBtn.heightAnchor.constraint(equalToConstant: 30),
            actionBtn.widthAnchor.constraint(equalToConstant: 96)
        ])
    }
    
    public func configure(word: VocabWord, isMasteredMode: Bool, onActionTap: @escaping () -> Void) {
        self.currentWord = word
        self.onActionTap = onActionTap
        
        jpWordLabel.text = word.displayText
        readingLabel.text = word.kanji != nil ? "\(word.kana) • /\(word.romaji)/" : "/\(word.romaji)/"
        meaningLabel.text = word.meaningVi
        
        if isMasteredMode {
            var mConfig = UIButton.Configuration.filled()
            mConfig.title = "Học lại"
            mConfig.image = UIImage(systemName: "arrow.uturn.backward")
            mConfig.imagePlacement = .leading
            mConfig.imagePadding = 4
            mConfig.baseBackgroundColor = UIColor.systemOrange.withAlphaComponent(0.15)
            mConfig.baseForegroundColor = .systemOrange
            mConfig.cornerStyle = .capsule
            actionBtn.configuration = mConfig
        } else {
            var mConfig = UIButton.Configuration.filled()
            mConfig.title = "Đã thuộc"
            mConfig.image = UIImage(systemName: "checkmark")
            mConfig.imagePlacement = .leading
            mConfig.imagePadding = 4
            mConfig.baseBackgroundColor = UIColor.systemGreen.withAlphaComponent(0.15)
            mConfig.baseForegroundColor = .systemGreen
            mConfig.cornerStyle = .capsule
            actionBtn.configuration = mConfig
        }
    }
    
    @objc private func speakTapped() {
        guard let w = currentWord else { return }
        AudioService.shared.speak(text: w.speechText)
    }
    
    @objc private func actionTapped() {
        onActionTap?()
    }
}
