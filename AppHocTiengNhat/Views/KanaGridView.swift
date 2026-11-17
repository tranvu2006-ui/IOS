//
//  KanaGridView.swift
//  AppHocTiengNhat
//

import UIKit

public struct KanaGridItem {
    public let character: String
    public let romaji: String
    public let type: KanaType
    
    public init(character: String, romaji: String, type: KanaType) {
        self.character = character
        self.romaji = romaji
        self.type = type
    }
}

public protocol KanaGridViewDelegate: AnyObject {
    func kanaGridViewDidSelect(character: String, romaji: String)
}

public class KanaGridView: UIView {
    
    public weak var delegate: KanaGridViewDelegate?
    public private(set) var kanaType: KanaType = .hiragana
    public private(set) var isRomajiHidden: Bool = false
    
    private let scrollView = UIScrollView()
    private let tableStackView = UIStackView()
    
    // 11 hàng chuẩn 50 âm (5 cột: a, i, u, e, o)
    // Các ô để nil là ô khuyết trong tiếng Nhật (như yi, ye trong hàng ya; wi, wu, we trong hàng wa...)
    private let hiraganaGridRows: [[(char: String, romaji: String)?]] = [
        [("あ", "a"), ("い", "i"), ("う", "u"), ("え", "e"), ("お", "o")],
        [("か", "ka"), ("き", "ki"), ("く", "ku"), ("け", "ke"), ("こ", "ko")],
        [("さ", "sa"), ("し", "shi"), ("す", "su"), ("せ", "se"), ("そ", "so")],
        [("た", "ta"), ("ち", "chi"), ("つ", "tsu"), ("て", "te"), ("と", "to")],
        [("な", "na"), ("に", "ni"), ("ぬ", "nu"), ("ね", "ne"), ("の", "no")],
        [("は", "ha"), ("ひ", "hi"), ("ふ", "fu"), ("へ", "he"), ("ほ", "ho")],
        [("ま", "ma"), ("み", "mi"), ("む", "mu"), ("め", "me"), ("も", "mo")],
        [("や", "ya"), nil, ("ゆ", "yu"), nil, ("よ", "yo")],
        [("ら", "ra"), ("り", "ri"), ("る", "ru"), ("れ", "re"), ("ろ", "ro")],
        [("わ", "wa"), nil, nil, nil, ("を", "o")],
        [("ん", "n"), nil, nil, nil, nil]
    ]
    
    private let katakanaGridRows: [[(char: String, romaji: String)?]] = [
        [("ア", "a"), ("イ", "i"), ("ウ", "u"), ("エ", "e"), ("オ", "o")],
        [("カ", "ka"), ("キ", "ki"), ("ク", "ku"), ("ケ", "ke"), ("コ", "ko")],
        [("サ", "sa"), ("シ", "shi"), ("ス", "su"), ("セ", "se"), ("ソ", "so")],
        [("タ", "ta"), ("チ", "chi"), ("ツ", "tsu"), ("テ", "te"), ("ト", "to")],
        [("ナ", "na"), ("ニ", "ni"), ("ヌ", "nu"), ("ネ", "ne"), ("ノ", "no")],
        [("ハ", "ha"), ("ヒ", "hi"), ("フ", "fu"), ("ヘ", "he"), ("ホ", "ho")],
        [("マ", "ma"), ("ミ", "mi"), ("ム", "mu"), ("メ", "me"), ("モ", "mo")],
        [("ヤ", "ya"), nil, ("ユ", "yu"), nil, ("ヨ", "yo")],
        [("ラ", "ra"), ("リ", "ri"), ("ル", "ru"), ("レ", "re"), ("ロ", "ro")],
        [("ワ", "wa"), nil, nil, nil, ("ヲ", "o")],
        [("ン", "n"), nil, nil, nil, nil]
    ]
    
    private var cellRomajiLabels: [UILabel] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        backgroundColor = .systemBackground
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = true
        scrollView.alwaysBounceVertical = true
        addSubview(scrollView)
        
        tableStackView.axis = .vertical
        tableStackView.spacing = 18
        tableStackView.alignment = .fill
        tableStackView.distribution = .fillEqually
        tableStackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(tableStackView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            tableStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            tableStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 12),
            tableStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -12),
            tableStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -24),
            tableStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -24)
        ])
        
        renderGrid()
    }
    
    public func setKanaType(_ type: KanaType) {
        guard self.kanaType != type else { return }
        self.kanaType = type
        renderGrid()
    }
    
    public func toggleRomajiVisibility() -> Bool {
        isRomajiHidden.toggle()
        for label in cellRomajiLabels {
            label.isHidden = isRomajiHidden
        }
        return isRomajiHidden
    }
    
    public func getAllCharactersInOrder() -> [(char: String, romaji: String)] {
        let rows = (kanaType == .hiragana) ? hiraganaGridRows : katakanaGridRows
        var list: [(char: String, romaji: String)] = []
        for r in rows {
            for cell in r {
                if let cell = cell {
                    list.append(cell)
                }
            }
        }
        return list
    }
    
    private func renderGrid() {
        tableStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        cellRomajiLabels.removeAll()
        
        let rows = (kanaType == .hiragana) ? hiraganaGridRows : katakanaGridRows
        
        for rowItems in rows {
            let rowStack = UIStackView()
            rowStack.axis = .horizontal
            rowStack.spacing = 10
            rowStack.alignment = .fill
            rowStack.distribution = .fillEqually
            
            for item in rowItems {
                if let item = item {
                    let cell = createKanaCell(character: item.char, romaji: item.romaji)
                    rowStack.addArrangedSubview(cell)
                } else {
                    let empty = UIView()
                    empty.backgroundColor = .clear
                    rowStack.addArrangedSubview(empty)
                }
            }
            
            tableStackView.addArrangedSubview(rowStack)
        }
    }
    
    private func createKanaCell(character: String, romaji: String) -> UIView {
        let button = UIControl()
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 68).isActive = true
        
        let charLabel = UILabel()
        charLabel.text = character
        charLabel.font = .systemFont(ofSize: 34, weight: .regular)
        // Màu xanh tím nhạt giống hệt ảnh mẫu
        charLabel.textColor = UIColor(red: 44/255, green: 76/255, blue: 135/255, alpha: 1.0)
        charLabel.textAlignment = .center
        charLabel.isUserInteractionEnabled = false
        charLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let romajiLabel = UILabel()
        romajiLabel.text = romaji
        romajiLabel.font = .systemFont(ofSize: 15, weight: .regular)
        romajiLabel.textColor = UIColor(red: 120/255, green: 135/255, blue: 165/255, alpha: 1.0)
        romajiLabel.textAlignment = .center
        romajiLabel.isUserInteractionEnabled = false
        romajiLabel.isHidden = isRomajiHidden
        romajiLabel.translatesAutoresizingMaskIntoConstraints = false
        cellRomajiLabels.append(romajiLabel)
        
        button.addSubview(charLabel)
        button.addSubview(romajiLabel)
        
        NSLayoutConstraint.activate([
            charLabel.topAnchor.constraint(equalTo: button.topAnchor, constant: 4),
            charLabel.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            
            romajiLabel.topAnchor.constraint(equalTo: charLabel.bottomAnchor, constant: 2),
            romajiLabel.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            romajiLabel.bottomAnchor.constraint(lessThanOrEqualTo: button.bottomAnchor, constant: -2)
        ])
        
        button.addAction(UIAction(handler: { [weak self] _ in
            // Nhấp nháy nhẹ phản hồi
            UIView.animate(withDuration: 0.1, animations: {
                charLabel.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
            }) { _ in
                UIView.animate(withDuration: 0.1) {
                    charLabel.transform = .identity
                }
            }
            self?.delegate?.kanaGridViewDidSelect(character: character, romaji: romaji)
        }), for: .touchUpInside)
        
        return button
    }
}
