//
//  SearchViewController.swift
//  AppHocTiengNhat
//

import UIKit

public struct SearchResultItem {
    public let mainText: String
    public let subText: String
    public let meaning: String
    public let tag: String
    public let audioText: String
}

// MARK: - Keyboard Delegate Protocol
public protocol DualLanguageKeyboardDelegate: AnyObject {
    func keyboardDidInsertText(_ text: String)
    func keyboardDidReplaceLastText(with text: String)
    func keyboardDidDeleteBackward()
    func keyboardDidClearAll()
    func keyboardDidTapSearch()
    func keyboardDidToggleDakuon()
    var currentInputText: String { get }
}

// MARK: - Custom In-App Dual Language Keyboard (Japanese 12-Key & Vietnamese)
public class DualLanguageKeyboardView: UIView, UIInputViewAudioFeedback {
    
    public weak var delegate: DualLanguageKeyboardDelegate?
    public var enableInputClicksWhenVisible: Bool { return true }
    
    public enum KeyboardMode {
        case japanese12Key
        case vietnamese
    }
    
    private var currentMode: KeyboardMode = .japanese12Key
    private var isRomajiIn12Key: Bool = false
    private var isShiftedVN: Bool = false
    
    // Top Bar
    private let topBar = UIView()
    private let modeButton = UIButton(type: .system)
    private let statusLabel = UILabel()
    private let dismissButton = UIButton(type: .system)
    
    // Candidate Strip for Japanese 12-Key
    private let candidateScrollView = UIScrollView()
    private let candidateStackView = UIStackView()
    
    // Container for dynamic keyboard layout
    private let contentContainer = UIView()
    private var currentLayoutView: UIView?
    
    // Multi-tap tracking for Japanese 12-key
    private var lastKeyIndex: Int?
    private var lastCycleStep: Int = 0
    private var lastKeyTime: TimeInterval = 0
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupBase()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupBase()
    }
    
    private func setupBase() {
        backgroundColor = UIColor.systemGroupedBackground
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        setupTopBar()
        setupCandidateStrip()
        
        contentContainer.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentContainer)
        
        NSLayoutConstraint.activate([
            topBar.topAnchor.constraint(equalTo: topAnchor),
            topBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            topBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            topBar.heightAnchor.constraint(equalToConstant: 40),
            
            candidateScrollView.topAnchor.constraint(equalTo: topBar.bottomAnchor),
            candidateScrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            candidateScrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            candidateScrollView.heightAnchor.constraint(equalToConstant: 34),
            
            contentContainer.topAnchor.constraint(equalTo: candidateScrollView.bottomAnchor, constant: 4),
            contentContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            contentContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            contentContainer.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -4)
        ])
        
        renderCurrentMode()
    }
    
    private func setupTopBar() {
        topBar.backgroundColor = UIColor.secondarySystemGroupedBackground
        topBar.translatesAutoresizingMaskIntoConstraints = false
        addSubview(topBar)
        
        var modeConfig = UIButton.Configuration.filled()
        modeConfig.title = "🌐 Đổi sang Tiếng Việt"
        modeConfig.image = UIImage(systemName: "globe")
        modeConfig.imagePlacement = .leading
        modeConfig.imagePadding = 4
        modeConfig.baseBackgroundColor = .systemPurple
        modeConfig.baseForegroundColor = .white
        modeConfig.cornerStyle = .capsule
        modeButton.configuration = modeConfig
        modeButton.titleLabel?.font = .systemFont(ofSize: 12, weight: .bold)
        modeButton.translatesAutoresizingMaskIntoConstraints = false
        modeButton.addTarget(self, action: #selector(didTapToggleLanguage), for: .touchUpInside)
        topBar.addSubview(modeButton)
        
        statusLabel.font = .systemFont(ofSize: 12, weight: .semibold)
        statusLabel.textColor = .secondaryLabel
        statusLabel.textAlignment = .center
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        topBar.addSubview(statusLabel)
        
        var dismissConfig = UIButton.Configuration.plain()
        dismissConfig.image = UIImage(systemName: "keyboard.chevron.compact.down")
        dismissConfig.baseForegroundColor = .systemPurple
        dismissButton.configuration = dismissConfig
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        dismissButton.addTarget(self, action: #selector(didTapDismiss), for: .touchUpInside)
        topBar.addSubview(dismissButton)
        
        NSLayoutConstraint.activate([
            modeButton.leadingAnchor.constraint(equalTo: topBar.leadingAnchor, constant: 8),
            modeButton.centerYAnchor.constraint(equalTo: topBar.centerYAnchor),
            modeButton.heightAnchor.constraint(equalToConstant: 28),
            
            statusLabel.leadingAnchor.constraint(equalTo: modeButton.trailingAnchor, constant: 6),
            statusLabel.trailingAnchor.constraint(equalTo: dismissButton.leadingAnchor, constant: -6),
            statusLabel.centerYAnchor.constraint(equalTo: topBar.centerYAnchor),
            
            dismissButton.trailingAnchor.constraint(equalTo: topBar.trailingAnchor, constant: -8),
            dismissButton.centerYAnchor.constraint(equalTo: topBar.centerYAnchor),
            dismissButton.widthAnchor.constraint(equalToConstant: 34),
            dismissButton.heightAnchor.constraint(equalToConstant: 34)
        ])
    }
    
    private func setupCandidateStrip() {
        candidateScrollView.backgroundColor = UIColor.tertiarySystemGroupedBackground
        candidateScrollView.showsHorizontalScrollIndicator = false
        candidateScrollView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(candidateScrollView)
        
        candidateStackView.axis = .horizontal
        candidateStackView.spacing = 8
        candidateStackView.alignment = .center
        candidateStackView.translatesAutoresizingMaskIntoConstraints = false
        candidateScrollView.addSubview(candidateStackView)
        
        NSLayoutConstraint.activate([
            candidateStackView.leadingAnchor.constraint(equalTo: candidateScrollView.leadingAnchor, constant: 8),
            candidateStackView.trailingAnchor.constraint(equalTo: candidateScrollView.trailingAnchor, constant: -8),
            candidateStackView.topAnchor.constraint(equalTo: candidateScrollView.topAnchor),
            candidateStackView.bottomAnchor.constraint(equalTo: candidateScrollView.bottomAnchor),
            candidateStackView.heightAnchor.constraint(equalTo: candidateScrollView.heightAnchor)
        ])
    }
    
    @objc private func didTapToggleLanguage() {
        if currentMode == .japanese12Key {
            currentMode = .vietnamese
        } else {
            currentMode = .japanese12Key
        }
        renderCurrentMode()
    }
    
    @objc private func didTapDismiss() {
        delegate?.keyboardDidTapSearch()
    }
    
    private func renderCurrentMode() {
        currentLayoutView?.removeFromSuperview()
        
        if currentMode == .japanese12Key {
            modeButton.setTitle("🌐 Chuyển sang Tiếng Việt (Telex)", for: .normal)
            statusLabel.text = isRomajiIn12Key ? "🇯🇵 Romaji (12 phím)" : "🇯🇵 Kana (12 phím)"
            candidateScrollView.isHidden = false
            currentLayoutView = makeJapanese12KeyLayout()
            showDefaultCandidates()
        } else {
            modeButton.setTitle("🌐 Chuyển sang Tiếng Nhật (12 phím)", for: .normal)
            statusLabel.text = "🇻🇳 Tiếng Việt có dấu (Telex)"
            candidateScrollView.isHidden = false
            currentLayoutView = makeVietnameseLayout()
            showVietnameseShortcuts()
        }
        
        if let layout = currentLayoutView {
            layout.translatesAutoresizingMaskIntoConstraints = false
            contentContainer.addSubview(layout)
            NSLayoutConstraint.activate([
                layout.topAnchor.constraint(equalTo: contentContainer.topAnchor),
                layout.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor),
                layout.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor),
                layout.bottomAnchor.constraint(equalTo: contentContainer.bottomAnchor)
            ])
        }
    }
    
    // MARK: - Japanese 12-Key (Tenkey) Layout (Exact match with user image!)
    private func makeJapanese12KeyLayout() -> UIView {
        let rootStack = UIStackView()
        rootStack.axis = .vertical
        rootStack.distribution = .fillEqually
        rootStack.spacing = 6
        
        // 5 Columns:
        // Col 0 (left):   [ ⟳ ]        [ < ]      [ あa1 ]   [ 🌐 VN ]
        // Col 1:          [ あ @/: ]   [ た GHI ] [ ま PQR ] [ ゛゜小 ]
        // Col 2:          [ か ABC ]   [ な JKL ] [ や STUV] [ わ 0'" ]
        // Col 3:          [ さ DEF ]   [ は MN ]  [ ら WXYZ] [ 、。?! ]
        // Col 4 (right):  [ ⌫ Xóa ]    [ > ]      [ ␣ Cách ] [ 🔍 Tìm ]
        
        // Row 1
        let r1 = makeRowStack([
            makeFuncButton(title: "⟳", action: { [weak self] in self?.delegate?.keyboardDidClearAll() }),
            makeTenkeyButton(main: "あ", sub: "@ / :", keyIndex: 1),
            makeTenkeyButton(main: "か", sub: "A B C", keyIndex: 2),
            makeTenkeyButton(main: "さ", sub: "D E F", keyIndex: 3),
            makeFuncButton(title: "⌫", action: { [weak self] in self?.delegate?.keyboardDidDeleteBackward() })
        ])
        
        // Row 2
        let r2 = makeRowStack([
            makeFuncButton(title: "◀", action: { [weak self] in self?.cycleCurrentKey(stepForward: false) }),
            makeTenkeyButton(main: "た", sub: "G H I", keyIndex: 4),
            makeTenkeyButton(main: "な", sub: "J K L", keyIndex: 5),
            makeTenkeyButton(main: "は", sub: "M N", keyIndex: 6),
            makeFuncButton(title: "▶", action: { [weak self] in self?.cycleCurrentKey(stepForward: true) })
        ])
        
        // Row 3
        let r3 = makeRowStack([
            makeFuncButton(title: isRomajiIn12Key ? "あ" : "a1", action: { [weak self] in
                guard let self = self else { return }
                self.isRomajiIn12Key.toggle()
                self.renderCurrentMode()
            }),
            makeTenkeyButton(main: "ま", sub: "P Q R", keyIndex: 7),
            makeTenkeyButton(main: "や", sub: "S T U", keyIndex: 8),
            makeTenkeyButton(main: "ら", sub: "W X Y", keyIndex: 9),
            makeFuncButton(title: "␣", action: { [weak self] in self?.commitChar(" ") })
        ])
        
        // Row 4
        let r4 = makeRowStack([
            makeFuncButton(title: "🌐 VN", action: { [weak self] in self?.didTapToggleLanguage() }),
            makeTenkeyButton(main: "゛゜小", sub: "Biến âm", keyIndex: 10),
            makeTenkeyButton(main: "わ", sub: "0 ' \"", keyIndex: 11),
            makeTenkeyButton(main: "、。?!", sub: "Dấu câu", keyIndex: 12),
            makeSearchButton()
        ])
        
        rootStack.addArrangedSubview(r1)
        rootStack.addArrangedSubview(r2)
        rootStack.addArrangedSubview(r3)
        rootStack.addArrangedSubview(r4)
        return rootStack
    }
    
    // MARK: - Vietnamese Layout
    private func makeVietnameseLayout() -> UIView {
        let rootStack = UIStackView()
        rootStack.axis = .vertical
        rootStack.distribution = .fillEqually
        rootStack.spacing = 5
        
        // Row 1: Vowels with marks
        let vowels = ["ă", "â", "đ", "ê", "ô", "ơ", "ư", "á", "à", "ả", "ã", "ạ"]
        let r0 = makeRowStack(vowels.map { char in
            makeCharButton(title: isShiftedVN ? char.uppercased() : char)
        })
        
        // Row 2: QWERTY Row 1
        let q1 = ["q", "w", "e", "r", "t", "y", "u", "i", "o", "p"]
        let r1 = makeRowStack(q1.map { char in
            makeCharButton(title: isShiftedVN ? char.uppercased() : char)
        })
        
        // Row 3: QWERTY Row 2
        let q2 = ["a", "s", "d", "f", "g", "h", "j", "k", "l"]
        let r2 = makeRowStack(q2.map { char in
            makeCharButton(title: isShiftedVN ? char.uppercased() : char)
        })
        
        // Row 4: QWERTY Row 3
        var r3Buttons: [UIButton] = []
        let shiftBtn = makeFuncButton(title: isShiftedVN ? "⬆" : "⇧", action: { [weak self] in
            guard let self = self else { return }
            self.isShiftedVN.toggle()
            self.renderCurrentMode()
        })
        r3Buttons.append(shiftBtn)
        let q3 = ["z", "x", "c", "v", "b", "n", "m"]
        for char in q3 {
            r3Buttons.append(makeCharButton(title: isShiftedVN ? char.uppercased() : char))
        }
        let delBtn = makeFuncButton(title: "⌫", action: { [weak self] in self?.delegate?.keyboardDidDeleteBackward() })
        r3Buttons.append(delBtn)
        let r3 = makeRowStack(r3Buttons)
        
        // Row 5: Function row
        let r4 = makeRowStack([
            makeFuncButton(title: "🌐 JP", action: { [weak self] in self?.didTapToggleLanguage() }),
            makeCharButton(title: "␣ Dấu cách", customAction: { [weak self] in self?.delegate?.keyboardDidInsertText(" ") }),
            makeSearchButton()
        ])
        
        rootStack.addArrangedSubview(r0)
        rootStack.addArrangedSubview(r1)
        rootStack.addArrangedSubview(r2)
        rootStack.addArrangedSubview(r3)
        rootStack.addArrangedSubview(r4)
        return rootStack
    }
    
    // MARK: - Button Builders
    private func makeRowStack(_ views: [UIView]) -> UIStackView {
        let stack = UIStackView(arrangedSubviews: views)
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 6
        return stack
    }
    
    private func makeTenkeyButton(main: String, sub: String, keyIndex: Int) -> UIButton {
        let btn = UIButton(type: .system)
        btn.backgroundColor = UIColor.secondarySystemGroupedBackground
        btn.layer.cornerRadius = 8
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOpacity = 0.08
        btn.layer.shadowOffset = CGSize(width: 0, height: 1.5)
        btn.layer.shadowRadius = 2
        btn.layer.borderWidth = 0.5
        btn.layer.borderColor = UIColor.systemGray4.cgColor
        
        let container = UIStackView()
        container.axis = .vertical
        container.alignment = .center
        container.spacing = 1
        container.isUserInteractionEnabled = false
        container.translatesAutoresizingMaskIntoConstraints = false
        
        let mainLabel = UILabel()
        mainLabel.text = main
        mainLabel.font = .systemFont(ofSize: 20, weight: .bold)
        mainLabel.textColor = .label
        
        let subLabel = UILabel()
        subLabel.text = sub
        subLabel.font = .systemFont(ofSize: 9, weight: .regular)
        subLabel.textColor = .secondaryLabel
        
        container.addArrangedSubview(mainLabel)
        container.addArrangedSubview(subLabel)
        btn.addSubview(container)
        
        NSLayoutConstraint.activate([
            container.centerXAnchor.constraint(equalTo: btn.centerXAnchor),
            container.centerYAnchor.constraint(equalTo: btn.centerYAnchor)
        ])
        
        btn.addAction(UIAction(handler: { [weak self] _ in
            self?.handleTenkeyPress(keyIndex: keyIndex)
        }), for: .touchUpInside)
        return btn
    }
    
    private func makeFuncButton(title: String, action: @escaping () -> Void) -> UIButton {
        let btn = UIButton(type: .system)
        btn.setTitle(title, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        btn.backgroundColor = UIColor.tertiarySystemGroupedBackground
        btn.tintColor = title.contains("⌫") ? .systemRed : .label
        btn.layer.cornerRadius = 8
        btn.layer.borderWidth = 0.5
        btn.layer.borderColor = UIColor.systemGray4.cgColor
        btn.addAction(UIAction(handler: { _ in
            UIDevice.current.playInputClick()
            action()
        }), for: .touchUpInside)
        return btn
    }
    
    private func makeCharButton(title: String, customAction: (() -> Void)? = nil) -> UIButton {
        let btn = UIButton(type: .system)
        btn.setTitle(title, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: title.count > 2 ? 13 : 16, weight: .semibold)
        btn.backgroundColor = UIColor.secondarySystemGroupedBackground
        btn.tintColor = .label
        btn.layer.cornerRadius = 8
        btn.layer.borderWidth = 0.5
        btn.layer.borderColor = UIColor.systemGray4.cgColor
        btn.addAction(UIAction(handler: { [weak self] _ in
            UIDevice.current.playInputClick()
            if let custom = customAction {
                custom()
            } else {
                self?.commitChar(title)
            }
        }), for: .touchUpInside)
        return btn
    }
    
    private func makeSearchButton() -> UIButton {
        let btn = UIButton(type: .system)
        btn.setTitle("🔍 Tìm", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        btn.backgroundColor = .systemPurple
        btn.tintColor = .white
        btn.layer.cornerRadius = 8
        btn.layer.shadowColor = UIColor.systemPurple.cgColor
        btn.layer.shadowOpacity = 0.25
        btn.layer.shadowOffset = CGSize(width: 0, height: 2)
        btn.layer.shadowRadius = 3
        btn.addAction(UIAction(handler: { [weak self] _ in
            UIDevice.current.playInputClick()
            self?.delegate?.keyboardDidTapSearch()
        }), for: .touchUpInside)
        return btn
    }
    
    // MARK: - Japanese 12-Key Logic (Multi-tap & Dakuon)
    private func getCandidates(for keyIndex: Int) -> [String] {
        if isRomajiIn12Key {
            switch keyIndex {
            case 1: return ["@", "/", ":", ";", "."]
            case 2: return ["a", "b", "c"]
            case 3: return ["d", "e", "f"]
            case 4: return ["g", "h", "i"]
            case 5: return ["j", "k", "l"]
            case 6: return ["m", "n", "o"]
            case 7: return ["p", "q", "r", "s"]
            case 8: return ["t", "u", "v"]
            case 9: return ["w", "x", "y", "z"]
            case 11: return ["0", "'", "\""]
            case 12: return [",", ".", "?", "!", "..."]
            default: return []
            }
        } else {
            switch keyIndex {
            case 1: return ["あ", "い", "う", "え", "お"]
            case 2: return ["か", "き", "く", "け", "こ"]
            case 3: return ["さ", "し", "す", "せ", "そ"]
            case 4: return ["た", "ち", "つ", "て", "と"]
            case 5: return ["な", "に", "ぬ", "ね", "の"]
            case 6: return ["は", "ひ", "ふ", "へ", "ほ"]
            case 7: return ["ま", "み", "む", "め", "も"]
            case 8: return ["や", "（", "ゆ", "）", "よ"]
            case 9: return ["ら", "り", "る", "れ", "ろ"]
            case 10: return [] // Dakuon toggle
            case 11: return ["わ", "を", "ん", "ー"]
            case 12: return ["、", "。", "？", "！", "…"]
            default: return []
            }
        }
    }
    
    private func handleTenkeyPress(keyIndex: Int) {
        UIDevice.current.playInputClick()
        
        if keyIndex == 10 {
            // Dakuon / Small kana toggle
            delegate?.keyboardDidToggleDakuon()
            lastKeyIndex = nil
            return
        }
        
        let candidates = getCandidates(for: keyIndex)
        guard !candidates.isEmpty else { return }
        
        let now = Date().timeIntervalSince1970
        let isSameKeyRecent = (lastKeyIndex == keyIndex) && (now - lastKeyTime < 1.4)
        
        if isSameKeyRecent {
            // Cycle to next character
            lastCycleStep = (lastCycleStep + 1) % candidates.count
            let char = candidates[lastCycleStep]
            delegate?.keyboardDidReplaceLastText(with: char)
        } else {
            // New character
            lastKeyIndex = keyIndex
            lastCycleStep = 0
            let char = candidates[0]
            delegate?.keyboardDidInsertText(char)
        }
        
        lastKeyTime = now
        updateCandidateStrip(candidates: candidates, selectedIndex: lastCycleStep)
    }
    
    private func cycleCurrentKey(stepForward: Bool) {
        guard let keyIndex = lastKeyIndex else { return }
        let candidates = getCandidates(for: keyIndex)
        guard !candidates.isEmpty else { return }
        
        if stepForward {
            lastCycleStep = (lastCycleStep + 1) % candidates.count
        } else {
            lastCycleStep = (lastCycleStep - 1 + candidates.count) % candidates.count
        }
        let char = candidates[lastCycleStep]
        delegate?.keyboardDidReplaceLastText(with: char)
        updateCandidateStrip(candidates: candidates, selectedIndex: lastCycleStep)
    }
    
    private func updateCandidateStrip(candidates: [String], selectedIndex: Int) {
        candidateStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        for (i, c) in candidates.enumerated() {
            let pill = UIButton(type: .system)
            pill.setTitle(c, for: .normal)
            pill.titleLabel?.font = .systemFont(ofSize: 14, weight: i == selectedIndex ? .bold : .medium)
            pill.backgroundColor = (i == selectedIndex) ? UIColor.systemPurple : UIColor.secondarySystemGroupedBackground
            pill.tintColor = (i == selectedIndex) ? .white : .label
            pill.layer.cornerRadius = 6
            pill.addAction(UIAction(handler: { [weak self] _ in
                self?.delegate?.keyboardDidReplaceLastText(with: c)
                self?.lastCycleStep = i
                self?.updateCandidateStrip(candidates: candidates, selectedIndex: i)
            }), for: .touchUpInside)
            candidateStackView.addArrangedSubview(pill)
        }
    }
    
    private func showDefaultCandidates() {
        let defaults = ["あ", "か", "さ", "た", "な", "は", "ま", "や", "ら", "わ", "が", "ざ", "だ", "ば", "ぱ", "っ"]
        candidateStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        for c in defaults {
            let pill = UIButton(type: .system)
            pill.setTitle(c, for: .normal)
            pill.titleLabel?.font = .systemFont(ofSize: 13, weight: .semibold)
            pill.backgroundColor = UIColor.secondarySystemGroupedBackground
            pill.tintColor = .label
            pill.layer.cornerRadius = 6
            pill.addAction(UIAction(handler: { [weak self] _ in
                self?.commitChar(c)
            }), for: .touchUpInside)
            candidateStackView.addArrangedSubview(pill)
        }
    }
    
    private func showVietnameseShortcuts() {
        let words = ["ăn", "uống", "đi", "đến", "về", "ngủ", "dậy", "học", "mua", "xem", "nghe", "nói", "gặp", "sách", "nhà", "ga", "xe"]
        candidateStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        for w in words {
            let pill = UIButton(type: .system)
            pill.setTitle(w, for: .normal)
            pill.titleLabel?.font = .systemFont(ofSize: 13, weight: .medium)
            pill.backgroundColor = UIColor.secondarySystemGroupedBackground
            pill.tintColor = .systemPurple
            pill.layer.cornerRadius = 6
            pill.addAction(UIAction(handler: { [weak self] _ in
                self?.delegate?.keyboardDidInsertText(w)
            }), for: .touchUpInside)
            candidateStackView.addArrangedSubview(pill)
        }
    }
    
    private func commitChar(_ char: String) {
        lastKeyIndex = nil
        delegate?.keyboardDidInsertText(char)
    }
}

// MARK: - Search View Controller
public class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, DualLanguageKeyboardDelegate {
    
    private let searchBar = UISearchBar()
    private var customKeyboard: DualLanguageKeyboardView!
    
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    private let emptyLabel = UILabel()
    
    private var allItems: [SearchResultItem] = []
    private var filteredItems: [SearchResultItem] = []
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        title = "Tra cứu Từ vựng & Hán tự"
        view.backgroundColor = .systemGroupedBackground
        
        setupData()
        setupViews()
    }
    
    private func setupData() {
        var items: [SearchResultItem] = []
        
        // 1. Từ vựng N5 (toàn bộ 25 bài)
        for word in VocabRepository.shared.vocabList {
            let kanjiStr = word.kanji ?? ""
            let main = kanjiStr.isEmpty ? word.kana : kanjiStr
            let sub = kanjiStr.isEmpty ? word.romaji : "\(word.kana) (\(word.romaji))"
            let lesson = word.lessonNumber ?? 0
            let tag = lesson > 0 ? "Bài \(lesson)" : "Từ vựng"
            items.append(SearchResultItem(mainText: main, subText: sub, meaning: word.meaningVi, tag: tag, audioText: main))
        }
        
        // 2. Kanji N5 & N4
        for kanji in KanjiRepository.shared.allKanji {
            let sub = "Âm On: \(kanji.onyomi) | Âm Kun: \(kanji.kunyomi)"
            let tag = "Kanji \(kanji.jlptLevel) [\(kanji.hanViet)]"
            items.append(SearchResultItem(mainText: kanji.kanji, subText: sub, meaning: kanji.meaningVi, tag: tag, audioText: kanji.kanji))
        }
        
        // 3. Chữ cái Kana
        for kana in KanaRepository.shared.hiraganaList {
            items.append(SearchResultItem(mainText: kana.character, subText: "\(kana.romaji) • \(kana.exampleWord)", meaning: kana.exampleMeaning, tag: "Hiragana [Hàng \(kana.rowGroup)]", audioText: kana.character))
        }
        for kana in KanaRepository.shared.katakanaList {
            items.append(SearchResultItem(mainText: kana.character, subText: "\(kana.romaji) • \(kana.exampleWord)", meaning: kana.exampleMeaning, tag: "Katakana [Hàng \(kana.rowGroup)]", audioText: kana.character))
        }
        
        // 4. Ngữ pháp 50 bài Minna no Nihongo (N5 & N4)
        for lesson in GrammarRepository.shared.lessons {
            for point in lesson.points {
                let tag = "Ngữ pháp B\(lesson.lessonNumber) (\(lesson.jlptLevel))"
                let sub = "\(point.structure) - \(point.explanation)"
                items.append(SearchResultItem(mainText: point.title, subText: sub, meaning: point.explanation, tag: tag, audioText: point.title))
            }
        }
        
        self.allItems = items
        self.filteredItems = items
    }
    
    private func setupViews() {
        searchBar.placeholder = "Chạm để mở bàn phím Nhật 12-phím / Tiếng Việt..."
        searchBar.delegate = self
        searchBar.searchBarStyle = .minimal
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchBar)
        
        // Khởi tạo bàn phím ảo tùy chỉnh (Japanese 12-Key & Vietnamese)
        let screenWidth = UIScreen.main.bounds.width
        customKeyboard = DualLanguageKeyboardView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 290))
        customKeyboard.delegate = self
        searchBar.searchTextField.inputView = customKeyboard
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SearchCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        emptyLabel.text = "Không tìm thấy kết quả phù hợp"
        emptyLabel.textColor = .secondaryLabel
        emptyLabel.textAlignment = .center
        emptyLabel.font = .systemFont(ofSize: 15)
        emptyLabel.isHidden = true
        emptyLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emptyLabel)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 4),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            emptyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    // MARK: - DualLanguageKeyboardDelegate
    public var currentInputText: String {
        return searchBar.text ?? ""
    }
    
    public func keyboardDidInsertText(_ text: String) {
        var current = searchBar.text ?? ""
        current += text
        // Tự động chuyển đổi Telex sang tiếng Việt có dấu
        let telexConverted = convertTelex(current)
        searchBar.text = telexConverted
        filterResults(searchText: telexConverted)
    }
    
    public func keyboardDidReplaceLastText(with text: String) {
        var current = searchBar.text ?? ""
        if !current.isEmpty {
            current.removeLast()
        }
        current += text
        searchBar.text = current
        filterResults(searchText: current)
    }
    
    public func keyboardDidDeleteBackward() {
        var current = searchBar.text ?? ""
        if !current.isEmpty {
            current.removeLast()
            searchBar.text = current
            filterResults(searchText: current)
        }
    }
    
    public func keyboardDidClearAll() {
        searchBar.text = ""
        filterResults(searchText: "")
    }
    
    public func keyboardDidTapSearch() {
        searchBar.resignFirstResponder()
    }
    
    public func keyboardDidToggleDakuon() {
        var current = searchBar.text ?? ""
        guard let lastChar = current.last else { return }
        let transformed = toggleDakuonChar(lastChar)
        current.removeLast()
        current.append(transformed)
        searchBar.text = current
        filterResults(searchText: current)
    }
    
    private func toggleDakuonChar(_ char: Character) -> Character {
        let map: [Character: Character] = [
            // Dakuon
            "か": "が", "が": "か",
            "き": "ぎ", "ぎ": "き",
            "く": "ぐ", "ぐ": "く",
            "け": "げ", "げ": "け",
            "こ": "ご", "ご": "こ",
            "さ": "ざ", "ざ": "さ",
            "し": "じ", "じ": "し",
            "す": "ず", "ず": "す",
            "せ": "ぜ", "ぜ": "せ",
            "そ": "ぞ", "ぞ": "そ",
            "た": "だ", "だ": "た",
            "ち": "ぢ", "ぢ": "ち",
            "つ": "づ", "づ": "っ", "っ": "つ",
            "て": "で", "で": "て",
            "と": "ど", "ど": "と",
            // Handakuon: は -> ば -> ぱ -> は
            "は": "ば", "ば": "ぱ", "ぱ": "は",
            "ひ": "び", "び": "ぴ", "ぴ": "ひ",
            "ふ": "ぶ", "ぶ": "ぷ", "ぷ": "ふ",
            "へ": "べ", "べ": "ぺ", "ぺ": "へ",
            "ほ": "ぼ", "ぼ": "ぽ", "ぽ": "ほ",
            // Small kana
            "あ": "ぁ", "ぁ": "あ",
            "い": "ぃ", "ぃ": "い",
            "う": "ぅ", "ぅ": "う",
            "え": "ぇ", "ぇ": "え",
            "お": "ぉ", "ぉ": "お",
            "や": "ゃ", "ゃ": "や",
            "ゆ": "ゅ", "ゅ": "ゆ",
            "よ": "ょ", "ょ": "よ",
            "わ": "ゎ", "ゎ": "わ"
        ]
        return map[char] ?? char
    }
    
    // MARK: - Search Logic & Auto-Telex
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let telexConverted = convertTelex(searchText)
        if telexConverted != searchText {
            searchBar.text = telexConverted
        }
        filterResults(searchText: telexConverted)
    }
    
    private func convertTelex(_ text: String) -> String {
        var result = text
        let replacements: [(String, String)] = [
            // Cụm từ và vần ghép Telex phổ biến
            ("uowng", "ương"), ("Uowng", "Ương"),
            ("uong", "uông"), ("uow", "ươ"), ("Uow", "Ươ"),
            ("tieeng", "tiếng"), ("vieet", "việt"), ("vieetj", "việt"),
            ("awn", "ăn"), ("anw", "ăn"), ("awm", "ăm"), ("amw", "ăm"),
            ("awc", "ắc"), ("acw", "ắc"), ("awt", "ắt"), ("atw", "ắt"),
            ("awp", "ắp"), ("apw", "ắp"),
            
            // Nguyên âm mũ & móc Telex cơ bản
            ("aw", "ă"), ("aa", "â"), ("dd", "đ"), ("ee", "ê"), ("oo", "ô"), ("ow", "ơ"), ("uw", "ư"),
            ("AW", "Ă"), ("AA", "Â"), ("DD", "Đ"), ("EE", "Ê"), ("OO", "Ô"), ("OW", "Ơ"), ("UW", "Ư"),
            
            // Dấu thanh trên nguyên âm có mũ / móc (ă, â, ê, ô, ơ, ư)
            ("ăs", "ắ"), ("ăf", "ằ"), ("ăr", "ẳ"), ("ăx", "ẵ"), ("ăj", "ặ"),
            ("âs", "ấ"), ("âf", "ầ"), ("âr", "ẩ"), ("âx", "ẫ"), ("âj", "ậ"),
            ("ês", "ế"), ("êf", "ề"), ("êr", "ể"), ("êx", "ễ"), ("êj", "ệ"),
            ("ôs", "ố"), ("ôf", "ồ"), ("ôr", "ổ"), ("ôx", "ỗ"), ("ôj", "ộ"),
            ("ơs", "ớ"), ("ơf", "ờ"), ("ơr", "ở"), ("ơx", "ỡ"), ("ơj", "ợ"),
            ("ưs", "ứ"), ("ưf", "ừ"), ("ưr", "ử"), ("ưx", "ữ"), ("ưj", "ự"),
            
            // Dấu thanh trên nguyên âm đơn (a, e, i, o, u, y)
            ("as", "á"), ("af", "à"), ("ar", "ả"), ("ax", "ã"), ("aj", "ạ"),
            ("es", "é"), ("ef", "è"), ("er", "ẻ"), ("ex", "ẽ"), ("ej", "ẹ"),
            ("is", "í"), ("if", "ì"), ("ir", "ỉ"), ("ix", "ĩ"), ("ij", "ị"),
            ("os", "ó"), ("of", "ò"), ("or", "ỏ"), ("ox", "õ"), ("oj", "ọ"),
            ("us", "ú"), ("uf", "ù"), ("ur", "ủ"), ("ux", "ũ"), ("uj", "ụ"),
            ("ys", "ý"), ("yf", "ỳ"), ("yr", "ỷ"), ("yx", "ỹ"), ("yj", "ỵ"),
            
            // Hỗ trợ gõ dấu thanh sau phụ âm cuối (như hocj -> học, ngur -> ngủ, di -> đi)
            ("ans", "án"), ("anf", "àn"), ("anr", "ản"), ("anx", "ãn"), ("anj", "ạn"),
            ("ăns", "ắn"), ("ănf", "ằn"), ("ănr", "ẳn"), ("ănx", "ẵn"), ("ănj", "ặn"),
            ("uongs", "uống"), ("uongf", "uồng"), ("uongr", "uổng"), ("uongj", "uộng"),
            ("hocj", "học"), ("hocs", "hóc"),
            ("ngur", "ngủ"), ("nguf", "ngù"), ("ngus", "ngú"),
            ("dij", "đị"), ("dif", "đì"), ("dis", "đí")
        ]
        for (pattern, replacement) in replacements {
            result = result.replacingOccurrences(of: pattern, with: replacement)
        }
        return result
    }
    
    private func filterResults(searchText: String) {
        let text = searchText.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        if text.isEmpty {
            filteredItems = allItems
        } else {
            let textNormalized = text.folding(options: .diacriticInsensitive, locale: .current)
            let hasDiacritics = text != textNormalized
            let isSingleWord = !text.contains(" ")
            
            var scoredItems: [(item: SearchResultItem, score: Int)] = []
            
            for item in allItems {
                let mainLower = item.mainText.lowercased()
                let subLower = item.subText.lowercased()
                let meaningLower = item.meaning.lowercased()
                let tagLower = item.tag.lowercased()
                
                let subNorm = subLower.folding(options: .diacriticInsensitive, locale: .current)
                let meaningNorm = meaningLower.folding(options: .diacriticInsensitive, locale: .current)
                
                var score = 0
                
                // 1. Khớp Kanji / Hiragana / Katakana (mainText)
                if mainLower == text {
                    score += 10000 // Khớp chính xác (ví dụ gõ '会います' hoặc '水')
                } else if mainLower.hasPrefix(text) {
                    score += 6000
                } else if mainLower.contains(text) {
                    score += 3000
                }
                
                // 2. Khớp Furigana / SubText (ví dụ gõ 'あいます' thì subText bắt đầu bằng 'あいます')
                if subLower.hasPrefix(text) {
                    score += 8000
                } else if subLower.contains(text) {
                    score += 2500
                }
                
                // 3. Khớp Romaji trong subText (ví dụ 'aimasu', 'nomimasu', 'mizu')
                let subTokens = subNorm.components(separatedBy: CharacterSet.alphanumerics.inverted).filter { !$0.isEmpty }
                if subTokens.contains(textNormalized) {
                    score += 5000
                } else if subTokens.contains(where: { $0.hasPrefix(textNormalized) }) {
                    score += 2500
                }
                
                // 4. Khớp nghĩa tiếng Việt (meaning)
                let meaningWords = meaningLower.components(separatedBy: CharacterSet.alphanumerics.inverted).filter { !$0.isEmpty }
                let meaningWordsNorm = meaningWords.map { $0.folding(options: .diacriticInsensitive, locale: .current) }
                
                // A. Khớp chính xác toàn bộ nghĩa
                if meaningLower == text {
                    score += 10000
                } else if !hasDiacritics && meaningNorm == textNormalized {
                    score += 8000
                }
                
                // B. Khớp từng từ đơn tiếng Việt (Ví dụ gõ 'uống' thì khớp từ 'uống' trong 'Uống' hoặc 'Nước uống')
                if isSingleWord {
                    if meaningWords.contains(text) {
                        score += 9000 // Khớp đúng từ có dấu!
                    } else if meaningWords.contains(where: { $0.hasPrefix(text) }) {
                        score += 4000 // Bắt đầu bằng tiền tố có dấu (ví dụ 'uố' -> 'uống')
                    } else if !hasDiacritics {
                        if meaningWordsNorm.contains(textNormalized) {
                            score += 7000 // Khớp đúng từ không dấu (ví dụ gõ 'uong' ra 'uống')
                        } else if meaningWordsNorm.contains(where: { $0.hasPrefix(textNormalized) }) {
                            score += 3000 // Bắt đầu bằng tiền tố không dấu
                        }
                    }
                } else {
                    // Cụm nhiều từ (ví dụ 'nước uống', 'trường học')
                    if meaningLower.contains(text) {
                        score += 7000
                    } else if !hasDiacritics && meaningNorm.contains(textNormalized) {
                        score += 5000
                    }
                }
                
                // 5. Khớp tag / bài học (ví dụ 'Bài 6', 'Kanji')
                if tagLower.contains(text) || tagLower.folding(options: .diacriticInsensitive, locale: .current).contains(textNormalized) {
                    score += 100
                }
                
                if score > 0 {
                    scoredItems.append((item: item, score: score))
                }
            }
            
            // Sắp xếp giảm dần theo độ liên quan cao nhất
            scoredItems.sort { $0.score > $1.score }
            filteredItems = scoredItems.map { $0.item }
        }
        emptyLabel.isHidden = !filteredItems.isEmpty
        tableView.reloadData()
    }
    
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    // MARK: - TableView DataSource
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredItems.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "SearchCell")
        let item = filteredItems[indexPath.row]
        
        cell.textLabel?.text = "\(item.mainText)   •   \(item.meaning)"
        cell.textLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        
        cell.detailTextLabel?.text = "\(item.subText)  (\(item.tag))"
        cell.detailTextLabel?.textColor = .secondaryLabel
        cell.accessoryType = .disclosureIndicator
        
        // Loa nhỏ bên phải phát âm tức thì
        let speakBtn = UIButton(type: .system)
        speakBtn.setImage(UIImage(systemName: "speaker.wave.2.fill"), for: .normal)
        speakBtn.tintColor = .systemPurple
        speakBtn.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        speakBtn.addAction(UIAction(handler: { _ in
            AudioService.shared.speak(text: item.audioText)
        }), for: .touchUpInside)
        cell.accessoryView = speakBtn
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = filteredItems[indexPath.row]
        AudioService.shared.speak(text: item.audioText)
    }
}
