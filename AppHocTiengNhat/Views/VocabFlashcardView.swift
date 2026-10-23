//
//  VocabFlashcardView.swift
//  AppHocTiengNhat
//

import UIKit

public class VocabFlashcardView: UIView {
    public private(set) var isFlipped: Bool = false
    public private(set) var currentWord: VocabWord?
    
    private let frontView = UIView()
    private let backView = UIView()
    
    // Front Elements
    private let topicBadgeLabel = UILabel()
    private let favoriteButton = UIButton(type: .system)
    private let mainWordLabel = UILabel()
    private let readingLabel = UILabel()
    private let frontAudioButton = UIButton(type: .system)
    private let tapHintLabel = UILabel()
    
    // Back Elements
    private let romajiLabel = UILabel()
    private let meaningLabel = UILabel()
    private let exampleContainer = UIView()
    private let exampleJpLabel = UILabel()
    private let exampleViLabel = UILabel()
    private let exampleAudioButton = UIButton(type: .system)
    
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
        topicBadgeLabel.font = .systemFont(ofSize: 13, weight: .bold)
        topicBadgeLabel.textColor = .systemPurple
        topicBadgeLabel.backgroundColor = UIColor.systemPurple.withAlphaComponent(0.12)
        topicBadgeLabel.layer.cornerRadius = 10
        topicBadgeLabel.clipsToBounds = true
        topicBadgeLabel.textAlignment = .center
        topicBadgeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
        favoriteButton.tintColor = .systemYellow
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.addTarget(self, action: #selector(didTapFavorite), for: .touchUpInside)
        
        mainWordLabel.font = .systemFont(ofSize: 48, weight: .bold)
        mainWordLabel.textAlignment = .center
        mainWordLabel.textColor = .label
        mainWordLabel.numberOfLines = 2
        mainWordLabel.adjustsFontSizeToFitWidth = true
        mainWordLabel.translatesAutoresizingMaskIntoConstraints = false
        
        readingLabel.font = .systemFont(ofSize: 18, weight: .medium)
        readingLabel.textColor = .secondaryLabel
        readingLabel.textAlignment = .center
        readingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        frontAudioButton.setImage(UIImage(systemName: "speaker.wave.3.fill"), for: .normal)
        frontAudioButton.tintColor = .systemPurple
        frontAudioButton.backgroundColor = UIColor.systemPurple.withAlphaComponent(0.12)
        frontAudioButton.layer.cornerRadius = 22
        frontAudioButton.translatesAutoresizingMaskIntoConstraints = false
        frontAudioButton.addTarget(self, action: #selector(playWordAudio), for: .touchUpInside)
        
        tapHintLabel.text = "Chạm để xem nghĩa và ví dụ câu"
        tapHintLabel.font = .systemFont(ofSize: 13, weight: .regular)
        tapHintLabel.textColor = .secondaryLabel
        tapHintLabel.textAlignment = .center
        tapHintLabel.translatesAutoresizingMaskIntoConstraints = false
        
        frontView.addSubview(topicBadgeLabel)
        frontView.addSubview(favoriteButton)
        frontView.addSubview(mainWordLabel)
        frontView.addSubview(readingLabel)
        frontView.addSubview(frontAudioButton)
        frontView.addSubview(tapHintLabel)
    }
    
    private func setupBackContent() {
        romajiLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        romajiLabel.textColor = .systemPurple
        romajiLabel.textAlignment = .center
        romajiLabel.translatesAutoresizingMaskIntoConstraints = false
        
        meaningLabel.font = .systemFont(ofSize: 26, weight: .bold)
        meaningLabel.textColor = .label
        meaningLabel.textAlignment = .center
        meaningLabel.numberOfLines = 2
        meaningLabel.translatesAutoresizingMaskIntoConstraints = false
        
        exampleContainer.backgroundColor = .secondarySystemBackground
        exampleContainer.layer.cornerRadius = 14
        exampleContainer.translatesAutoresizingMaskIntoConstraints = false
        
        exampleJpLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        exampleJpLabel.textColor = .label
        exampleJpLabel.numberOfLines = 0
        exampleJpLabel.translatesAutoresizingMaskIntoConstraints = false
        
        exampleViLabel.font = .systemFont(ofSize: 13, weight: .regular)
        exampleViLabel.textColor = .secondaryLabel
        exampleViLabel.numberOfLines = 0
        exampleViLabel.translatesAutoresizingMaskIntoConstraints = false
        
        exampleAudioButton.setImage(UIImage(systemName: "speaker.wave.2.fill"), for: .normal)
        exampleAudioButton.tintColor = .systemPurple
        exampleAudioButton.translatesAutoresizingMaskIntoConstraints = false
        exampleAudioButton.addTarget(self, action: #selector(playExampleAudio), for: .touchUpInside)
        
        exampleContainer.addSubview(exampleJpLabel)
        exampleContainer.addSubview(exampleViLabel)
        exampleContainer.addSubview(exampleAudioButton)
        
        backView.addSubview(romajiLabel)
        backView.addSubview(meaningLabel)
        backView.addSubview(exampleContainer)
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
            topicBadgeLabel.topAnchor.constraint(equalTo: frontView.topAnchor, constant: 18),
            topicBadgeLabel.leadingAnchor.constraint(equalTo: frontView.leadingAnchor, constant: 18),
            topicBadgeLabel.heightAnchor.constraint(equalToConstant: 26),
            topicBadgeLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 80),
            
            favoriteButton.centerYAnchor.constraint(equalTo: topicBadgeLabel.centerYAnchor),
            favoriteButton.trailingAnchor.constraint(equalTo: frontView.trailingAnchor, constant: -18),
            favoriteButton.widthAnchor.constraint(equalToConstant: 30),
            favoriteButton.heightAnchor.constraint(equalToConstant: 30),
            
            mainWordLabel.centerXAnchor.constraint(equalTo: frontView.centerXAnchor),
            mainWordLabel.centerYAnchor.constraint(equalTo: frontView.centerYAnchor, constant: -25),
            mainWordLabel.leadingAnchor.constraint(equalTo: frontView.leadingAnchor, constant: 16),
            mainWordLabel.trailingAnchor.constraint(equalTo: frontView.trailingAnchor, constant: -16),
            
            readingLabel.topAnchor.constraint(equalTo: mainWordLabel.bottomAnchor, constant: 6),
            readingLabel.centerXAnchor.constraint(equalTo: frontView.centerXAnchor),
            
            frontAudioButton.topAnchor.constraint(equalTo: readingLabel.bottomAnchor, constant: 16),
            frontAudioButton.centerXAnchor.constraint(equalTo: frontView.centerXAnchor),
            frontAudioButton.widthAnchor.constraint(equalToConstant: 44),
            frontAudioButton.heightAnchor.constraint(equalToConstant: 44),
            
            tapHintLabel.bottomAnchor.constraint(equalTo: frontView.bottomAnchor, constant: -16),
            tapHintLabel.leadingAnchor.constraint(equalTo: frontView.leadingAnchor, constant: 16),
            tapHintLabel.trailingAnchor.constraint(equalTo: frontView.trailingAnchor, constant: -16),
            
            // Back
            romajiLabel.topAnchor.constraint(equalTo: backView.topAnchor, constant: 36),
            romajiLabel.centerXAnchor.constraint(equalTo: backView.centerXAnchor),
            
            meaningLabel.topAnchor.constraint(equalTo: romajiLabel.bottomAnchor, constant: 12),
            meaningLabel.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 16),
            meaningLabel.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -16),
            
            exampleContainer.topAnchor.constraint(equalTo: meaningLabel.bottomAnchor, constant: 24),
            exampleContainer.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 16),
            exampleContainer.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -16),
            exampleContainer.bottomAnchor.constraint(lessThanOrEqualTo: backView.bottomAnchor, constant: -20),
            
            exampleJpLabel.topAnchor.constraint(equalTo: exampleContainer.topAnchor, constant: 12),
            exampleJpLabel.leadingAnchor.constraint(equalTo: exampleContainer.leadingAnchor, constant: 14),
            exampleJpLabel.trailingAnchor.constraint(equalTo: exampleAudioButton.leadingAnchor, constant: -8),
            
            exampleViLabel.topAnchor.constraint(equalTo: exampleJpLabel.bottomAnchor, constant: 4),
            exampleViLabel.leadingAnchor.constraint(equalTo: exampleContainer.leadingAnchor, constant: 14),
            exampleViLabel.trailingAnchor.constraint(equalTo: exampleAudioButton.leadingAnchor, constant: -8),
            exampleViLabel.bottomAnchor.constraint(equalTo: exampleContainer.bottomAnchor, constant: -12),
            
            exampleAudioButton.centerYAnchor.constraint(equalTo: exampleContainer.centerYAnchor),
            exampleAudioButton.trailingAnchor.constraint(equalTo: exampleContainer.trailingAnchor, constant: -10),
            exampleAudioButton.widthAnchor.constraint(equalToConstant: 32),
            exampleAudioButton.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
    
    public func configure(with item: VocabWord) {
        self.currentWord = item
        resetFlip(animated: false)
        
        topicBadgeLabel.text = " \(item.topicId.uppercased()) "
        mainWordLabel.text = item.displayText
        readingLabel.text = item.kanji != nil ? item.kana : ""
        romajiLabel.text = "/\(item.romaji)/"
        meaningLabel.text = item.meaningVi
        
        exampleJpLabel.text = item.exampleJp ?? ""
        exampleViLabel.text = item.exampleVi ?? ""
        exampleContainer.isHidden = (item.exampleJp == nil)
        
        updateFavoriteButton()
    }
    
    private func updateFavoriteButton() {
        guard let item = currentWord else { return }
        let isMastered = ProgressService.shared.isMastered(id: item.id)
        let iconName = isMastered ? "star.fill" : "star"
        favoriteButton.setImage(UIImage(systemName: iconName), for: .normal)
    }
    
    @objc private func didTapFavorite() {
        guard let item = currentWord else { return }
        let newState = ProgressService.shared.toggleMastered(id: item.id)
        let iconName = newState ? "star.fill" : "star"
        favoriteButton.setImage(UIImage(systemName: iconName), for: .normal)
    }
    
    @objc private func handleCardTap() {
        flip()
    }
    
    @objc private func playWordAudio() {
        guard let word = currentWord else { return }
        AudioService.shared.speak(text: word.speechText)
    }
    
    @objc private func playExampleAudio() {
        guard let word = currentWord, let ex = word.exampleJp else { return }
        AudioService.shared.speak(text: ex)
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
