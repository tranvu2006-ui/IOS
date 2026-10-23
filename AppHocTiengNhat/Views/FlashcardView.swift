//
//  FlashcardView.swift
//  AppHocTiengNhat
//

import UIKit

public protocol FlashcardViewDelegate: AnyObject {
    func flashcardViewDidTapAudio(_ view: FlashcardView, character: KanaCharacter)
}

public class FlashcardView: UIView {
    public weak var delegate: FlashcardViewDelegate?
    public private(set) var isFlipped: Bool = false
    public private(set) var currentCharacter: KanaCharacter?
    
    // Container views for 3D flip
    private let frontView = UIView()
    private let backView = UIView()
    
    // Front elements
    private let characterLabel = UILabel()
    private let groupBadgeLabel = UILabel()
    private let frontAudioButton = UIButton(type: .system)
    private let tapHintLabel = UILabel()
    
    // Back elements
    private let romajiLabel = UILabel()
    private let exampleWordLabel = UILabel()
    private let exampleMeaningLabel = UILabel()
    private let backAudioButton = UIButton(type: .system)
    
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
        groupBadgeLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        groupBadgeLabel.textColor = .systemBlue
        groupBadgeLabel.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.12)
        groupBadgeLabel.layer.cornerRadius = 10
        groupBadgeLabel.clipsToBounds = true
        groupBadgeLabel.textAlignment = .center
        groupBadgeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        characterLabel.font = .systemFont(ofSize: 96, weight: .bold)
        characterLabel.textAlignment = .center
        characterLabel.textColor = .label
        characterLabel.translatesAutoresizingMaskIntoConstraints = false
        
        frontAudioButton.setImage(UIImage(systemName: "speaker.wave.3.fill"), for: .normal)
        frontAudioButton.tintColor = .systemBlue
        frontAudioButton.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.12)
        frontAudioButton.layer.cornerRadius = 22
        frontAudioButton.translatesAutoresizingMaskIntoConstraints = false
        frontAudioButton.addTarget(self, action: #selector(audioButtonTapped), for: .touchUpInside)
        
        tapHintLabel.text = "Chạm vào thẻ để lật xem nghĩa"
        tapHintLabel.font = .systemFont(ofSize: 13, weight: .regular)
        tapHintLabel.textColor = .secondaryLabel
        tapHintLabel.textAlignment = .center
        tapHintLabel.translatesAutoresizingMaskIntoConstraints = false
        
        frontView.addSubview(groupBadgeLabel)
        frontView.addSubview(characterLabel)
        frontView.addSubview(frontAudioButton)
        frontView.addSubview(tapHintLabel)
    }
    
    private func setupBackContent() {
        romajiLabel.font = .systemFont(ofSize: 42, weight: .bold)
        romajiLabel.textAlignment = .center
        romajiLabel.textColor = .systemIndigo
        romajiLabel.translatesAutoresizingMaskIntoConstraints = false
        
        exampleWordLabel.font = .systemFont(ofSize: 22, weight: .semibold)
        exampleWordLabel.textAlignment = .center
        exampleWordLabel.textColor = .label
        exampleWordLabel.translatesAutoresizingMaskIntoConstraints = false
        
        exampleMeaningLabel.font = .systemFont(ofSize: 17, weight: .medium)
        exampleMeaningLabel.textAlignment = .center
        exampleMeaningLabel.textColor = .secondaryLabel
        exampleMeaningLabel.numberOfLines = 2
        exampleMeaningLabel.translatesAutoresizingMaskIntoConstraints = false
        
        backAudioButton.setImage(UIImage(systemName: "speaker.wave.2.fill"), for: .normal)
        backAudioButton.tintColor = .systemIndigo
        backAudioButton.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.12)
        backAudioButton.layer.cornerRadius = 20
        backAudioButton.translatesAutoresizingMaskIntoConstraints = false
        backAudioButton.addTarget(self, action: #selector(audioButtonTapped), for: .touchUpInside)
        
        backView.addSubview(romajiLabel)
        backView.addSubview(exampleWordLabel)
        backView.addSubview(exampleMeaningLabel)
        backView.addSubview(backAudioButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Container constraints
            frontView.topAnchor.constraint(equalTo: topAnchor),
            frontView.leadingAnchor.constraint(equalTo: leadingAnchor),
            frontView.trailingAnchor.constraint(equalTo: trailingAnchor),
            frontView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            backView.topAnchor.constraint(equalTo: topAnchor),
            backView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            // Front elements
            groupBadgeLabel.topAnchor.constraint(equalTo: frontView.topAnchor, constant: 20),
            groupBadgeLabel.centerXAnchor.constraint(equalTo: frontView.centerXAnchor),
            groupBadgeLabel.heightAnchor.constraint(equalToConstant: 26),
            groupBadgeLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 90),
            
            characterLabel.centerXAnchor.constraint(equalTo: frontView.centerXAnchor),
            characterLabel.centerYAnchor.constraint(equalTo: frontView.centerYAnchor, constant: -10),
            
            frontAudioButton.centerXAnchor.constraint(equalTo: frontView.centerXAnchor),
            frontAudioButton.topAnchor.constraint(equalTo: characterLabel.bottomAnchor, constant: 16),
            frontAudioButton.widthAnchor.constraint(equalToConstant: 44),
            frontAudioButton.heightAnchor.constraint(equalToConstant: 44),
            
            tapHintLabel.bottomAnchor.constraint(equalTo: frontView.bottomAnchor, constant: -16),
            tapHintLabel.leadingAnchor.constraint(equalTo: frontView.leadingAnchor, constant: 16),
            tapHintLabel.trailingAnchor.constraint(equalTo: frontView.trailingAnchor, constant: -16),
            
            // Back elements
            romajiLabel.centerXAnchor.constraint(equalTo: backView.centerXAnchor),
            romajiLabel.topAnchor.constraint(equalTo: backView.topAnchor, constant: 40),
            
            backAudioButton.centerXAnchor.constraint(equalTo: backView.centerXAnchor),
            backAudioButton.topAnchor.constraint(equalTo: romajiLabel.bottomAnchor, constant: 12),
            backAudioButton.widthAnchor.constraint(equalToConstant: 40),
            backAudioButton.heightAnchor.constraint(equalToConstant: 40),
            
            exampleWordLabel.topAnchor.constraint(equalTo: backAudioButton.bottomAnchor, constant: 30),
            exampleWordLabel.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 20),
            exampleWordLabel.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -20),
            
            exampleMeaningLabel.topAnchor.constraint(equalTo: exampleWordLabel.bottomAnchor, constant: 10),
            exampleMeaningLabel.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 20),
            exampleMeaningLabel.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -20)
        ])
    }
    
    public func configure(with item: KanaCharacter) {
        self.currentCharacter = item
        resetFlip(animated: false)
        
        characterLabel.text = item.character
        groupBadgeLabel.text = " \(item.type.rawValue) • Hàng \(item.rowGroup) "
        romajiLabel.text = "/\(item.romaji)/"
        exampleWordLabel.text = "Ví dụ: \(item.exampleWord)"
        exampleMeaningLabel.text = item.exampleMeaning
    }
    
    @objc private func handleCardTap() {
        flip()
    }
    
    @objc private func audioButtonTapped() {
        guard let item = currentCharacter else { return }
        delegate?.flashcardViewDidTapAudio(self, character: item)
    }
    
    public func flip() {
        let fromView = isFlipped ? backView : frontView
        let toView = isFlipped ? frontView : backView
        
        UIView.transition(from: fromView, to: toView, duration: 0.4, options: [.transitionFlipFromRight, .showHideTransitionViews]) { [weak self] _ in
            guard let self = self else { return }
            self.isFlipped.toggle()
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
