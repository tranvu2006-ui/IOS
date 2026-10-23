//
//  KanjiFlashcardView.swift
//  AppHocTiengNhat
//

import UIKit

public class KanjiFlashcardView: UIView {
    public private(set) var isFlipped: Bool = false
    public private(set) var currentKanji: KanjiCharacter?
    
    private let frontView = UIView()
    private let backView = UIView()
    
    // Front Elements
    private let badgeLabel = UILabel()
    private let kanjiLabel = UILabel()
    private let hanVietLabel = UILabel()
    private let frontAudioButton = UIButton(type: .system)
    private let tapHintLabel = UILabel()
    
    // Back Elements
    private let meaningLabel = UILabel()
    private let readingsStackView = UIStackView()
    private let onyomiLabel = UILabel()
    private let kunyomiLabel = UILabel()
    private let examplesContainerStack = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        backgroundColor = .clear
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.12
        layer.shadowOffset = CGSize(width: 0, height: 8)
        layer.shadowRadius = 16
        
        setupCardSide(frontView)
        setupCardSide(backView)
        
        addSubview(frontView)
        addSubview(backView)
        backView.isHidden = true
        
        setupFrontContent()
        setupBackContent()
        setupConstraints()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleCardTap))
        addGestureRecognizer(tapGesture)
    }
    
    private func setupCardSide(_ view: UIView) {
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 24
        view.layer.borderWidth = 1.5
        view.layer.borderColor = UIColor.systemGray5.cgColor
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupFrontContent() {
        badgeLabel.font = .systemFont(ofSize: 13, weight: .bold)
        badgeLabel.textColor = .systemOrange
        badgeLabel.backgroundColor = UIColor.systemOrange.withAlphaComponent(0.12)
        badgeLabel.layer.cornerRadius = 10
        badgeLabel.clipsToBounds = true
        badgeLabel.textAlignment = .center
        badgeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        kanjiLabel.font = .systemFont(ofSize: 96, weight: .bold)
        kanjiLabel.textAlignment = .center
        kanjiLabel.textColor = .label
        kanjiLabel.translatesAutoresizingMaskIntoConstraints = false
        
        hanVietLabel.font = .systemFont(ofSize: 24, weight: .heavy)
        hanVietLabel.textColor = .systemOrange
        hanVietLabel.textAlignment = .center
        hanVietLabel.translatesAutoresizingMaskIntoConstraints = false
        
        frontAudioButton.setImage(UIImage(systemName: "speaker.wave.3.fill"), for: .normal)
        frontAudioButton.tintColor = .systemOrange
        frontAudioButton.backgroundColor = UIColor.systemOrange.withAlphaComponent(0.12)
        frontAudioButton.layer.cornerRadius = 22
        frontAudioButton.translatesAutoresizingMaskIntoConstraints = false
        frontAudioButton.addTarget(self, action: #selector(playPrimaryAudio), for: .touchUpInside)
        
        tapHintLabel.text = "Chạm để xem âm On/Kun và từ vựng"
        tapHintLabel.font = .systemFont(ofSize: 13, weight: .regular)
        tapHintLabel.textColor = .secondaryLabel
        tapHintLabel.textAlignment = .center
        tapHintLabel.translatesAutoresizingMaskIntoConstraints = false
        
        frontView.addSubview(badgeLabel)
        frontView.addSubview(kanjiLabel)
        frontView.addSubview(hanVietLabel)
        frontView.addSubview(frontAudioButton)
        frontView.addSubview(tapHintLabel)
    }
    
    private func setupBackContent() {
        meaningLabel.font = .systemFont(ofSize: 22, weight: .bold)
        meaningLabel.textColor = .systemOrange
        meaningLabel.textAlignment = .center
        meaningLabel.translatesAutoresizingMaskIntoConstraints = false
        
        onyomiLabel.font = .systemFont(ofSize: 14, weight: .medium)
        onyomiLabel.textColor = .label
        onyomiLabel.numberOfLines = 0
        
        kunyomiLabel.font = .systemFont(ofSize: 14, weight: .medium)
        kunyomiLabel.textColor = .label
        kunyomiLabel.numberOfLines = 0
        
        readingsStackView.axis = .vertical
        readingsStackView.spacing = 6
        readingsStackView.backgroundColor = .secondarySystemBackground
        readingsStackView.layer.cornerRadius = 12
        readingsStackView.isLayoutMarginsRelativeArrangement = true
        readingsStackView.layoutMargins = UIEdgeInsets(top: 10, left: 14, bottom: 10, right: 14)
        readingsStackView.translatesAutoresizingMaskIntoConstraints = false
        readingsStackView.addArrangedSubview(onyomiLabel)
        readingsStackView.addArrangedSubview(kunyomiLabel)
        
        examplesContainerStack.axis = .vertical
        examplesContainerStack.spacing = 8
        examplesContainerStack.distribution = .fillEqually
        examplesContainerStack.translatesAutoresizingMaskIntoConstraints = false
        
        backView.addSubview(meaningLabel)
        backView.addSubview(readingsStackView)
        backView.addSubview(examplesContainerStack)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            frontView.topAnchor.constraint(equalTo: topAnchor),
            frontView.leadingAnchor.constraint(equalTo: leadingAnchor),
            frontView.trailingAnchor.constraint(equalTo: trailingAnchor),
            frontView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            backView.topAnchor.constraint(equalTo: topAnchor),
            backView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            // Front
            badgeLabel.topAnchor.constraint(equalTo: frontView.topAnchor, constant: 18),
            badgeLabel.centerXAnchor.constraint(equalTo: frontView.centerXAnchor),
            badgeLabel.heightAnchor.constraint(equalToConstant: 26),
            badgeLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 120),
            
            kanjiLabel.centerXAnchor.constraint(equalTo: frontView.centerXAnchor),
            kanjiLabel.centerYAnchor.constraint(equalTo: frontView.centerYAnchor, constant: -30),
            
            hanVietLabel.topAnchor.constraint(equalTo: kanjiLabel.bottomAnchor, constant: 4),
            hanVietLabel.centerXAnchor.constraint(equalTo: frontView.centerXAnchor),
            
            frontAudioButton.topAnchor.constraint(equalTo: hanVietLabel.bottomAnchor, constant: 14),
            frontAudioButton.centerXAnchor.constraint(equalTo: frontView.centerXAnchor),
            frontAudioButton.widthAnchor.constraint(equalToConstant: 44),
            frontAudioButton.heightAnchor.constraint(equalToConstant: 44),
            
            tapHintLabel.bottomAnchor.constraint(equalTo: frontView.bottomAnchor, constant: -16),
            tapHintLabel.leadingAnchor.constraint(equalTo: frontView.leadingAnchor, constant: 16),
            tapHintLabel.trailingAnchor.constraint(equalTo: frontView.trailingAnchor, constant: -16),
            
            // Back
            meaningLabel.topAnchor.constraint(equalTo: backView.topAnchor, constant: 20),
            meaningLabel.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 16),
            meaningLabel.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -16),
            
            readingsStackView.topAnchor.constraint(equalTo: meaningLabel.bottomAnchor, constant: 12),
            readingsStackView.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 16),
            readingsStackView.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -16),
            
            examplesContainerStack.topAnchor.constraint(equalTo: readingsStackView.bottomAnchor, constant: 12),
            examplesContainerStack.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 16),
            examplesContainerStack.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -16),
            examplesContainerStack.bottomAnchor.constraint(lessThanOrEqualTo: backView.bottomAnchor, constant: -16)
        ])
    }
    
    public func configure(with item: KanjiCharacter) {
        self.currentKanji = item
        resetFlip(animated: false)
        
        badgeLabel.text = " JLPT N5 • \(item.strokeCount) Nét "
        kanjiLabel.text = item.kanji
        hanVietLabel.text = item.hanViet
        
        meaningLabel.text = item.meaningVi
        onyomiLabel.text = "On (Âm Hán): \(item.onyomi)"
        kunyomiLabel.text = "Kun (Âm Thuần): \(item.kunyomi)"
        
        // Rebuild example rows
        examplesContainerStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        for example in item.examples.prefix(3) {
            let row = createExampleRow(example)
            examplesContainerStack.addArrangedSubview(row)
        }
    }
    
    private func createExampleRow(_ example: KanjiExample) -> UIView {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let wordLabel = UILabel()
        wordLabel.text = "\(example.word) • \(example.reading)"
        wordLabel.font = .systemFont(ofSize: 14, weight: .bold)
        wordLabel.textColor = .label
        wordLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let meaningLabel = UILabel()
        meaningLabel.text = example.meaning
        meaningLabel.font = .systemFont(ofSize: 12, weight: .regular)
        meaningLabel.textColor = .secondaryLabel
        meaningLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let speakBtn = UIButton(type: .system)
        speakBtn.setImage(UIImage(systemName: "speaker.wave.2.fill"), for: .normal)
        speakBtn.tintColor = .systemOrange
        speakBtn.translatesAutoresizingMaskIntoConstraints = false
        speakBtn.addAction(UIAction(handler: { _ in
            AudioService.shared.speak(text: example.word)
        }), for: .touchUpInside)
        
        view.addSubview(wordLabel)
        view.addSubview(meaningLabel)
        view.addSubview(speakBtn)
        
        NSLayoutConstraint.activate([
            wordLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
            wordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            wordLabel.trailingAnchor.constraint(equalTo: speakBtn.leadingAnchor, constant: -8),
            
            meaningLabel.topAnchor.constraint(equalTo: wordLabel.bottomAnchor, constant: 2),
            meaningLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            meaningLabel.trailingAnchor.constraint(equalTo: speakBtn.leadingAnchor, constant: -8),
            meaningLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8),
            
            speakBtn.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            speakBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            speakBtn.widthAnchor.constraint(equalToConstant: 32),
            speakBtn.heightAnchor.constraint(equalToConstant: 32)
        ])
        
        return view
    }
    
    @objc private func handleCardTap() {
        flip()
    }
    
    @objc private func playPrimaryAudio() {
        guard let kanji = currentKanji, let firstExample = kanji.examples.first else { return }
        AudioService.shared.speak(text: firstExample.word)
    }
    
    public func flip() {
        let fromView = isFlipped ? backView : frontView
        let toView = isFlipped ? frontView : backView
        
        UIView.transition(from: fromView, to: toView, duration: 0.4, options: [.transitionFlipFromRight, .showHideTransitionViews]) { [weak self] _ in
            self?.isFlipped.toggle()
        }
    }
    
    public func resetFlip(animated: Bool = false) {
        if isFlipped {
            if animated {
                flip()
            } else {
                frontView.isHidden = false
                backView.isHidden = true
                isFlipped = false
            }
        }
    }
}
