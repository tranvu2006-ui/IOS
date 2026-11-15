//
//  GrammarFlashcardView.swift
//  AppHocTiengNhat
//

import UIKit

public protocol GrammarFlashcardViewDelegate: AnyObject {
    func grammarFlashcardDidToggleMastered(_ card: GrammarFlashcardView, point: GrammarPoint, isMastered: Bool)
}

public class GrammarFlashcardView: UIView {
    public private(set) var isFlipped: Bool = false
    public private(set) var currentPoint: GrammarPoint?
    public weak var delegate: GrammarFlashcardViewDelegate?

    private let frontView = UIView()
    private let backView = UIView()

    // Front Elements
    private let badgeLabel = UILabel()
    private let favoriteButton = UIButton(type: .system)
    private let titleLabel = UILabel()
    private let structureContainer = UIView()
    private let structureLabel = UILabel()
    private let meaningLabel = UILabel()
    private let tapHintLabel = UILabel()

    // Back Elements
    private let backScrollView = UIScrollView()
    private let backContentView = UIView()
    private let backTitleLabel = UILabel()
    private let explanationHeaderLabel = UILabel()
    private let explanationLabel = UILabel()
    private let exampleContainer = UIView()
    private let exampleHeaderLabel = UILabel()
    private let exampleJpLabel = UILabel()
    private let exampleReadingLabel = UILabel()
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

        let frontTap = UITapGestureRecognizer(target: self, action: #selector(handleCardTap))
        frontView.addGestureRecognizer(frontTap)

        let backTap = UITapGestureRecognizer(target: self, action: #selector(handleCardTap))
        backTap.cancelsTouchesInView = false
        backScrollView.addGestureRecognizer(backTap)
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
        badgeLabel.font = .systemFont(ofSize: 12, weight: .bold)
        badgeLabel.textColor = .systemTeal
        badgeLabel.backgroundColor = UIColor.systemTeal.withAlphaComponent(0.14)
        badgeLabel.layer.cornerRadius = 10
        badgeLabel.clipsToBounds = true
        badgeLabel.textAlignment = .center
        badgeLabel.translatesAutoresizingMaskIntoConstraints = false

        favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
        favoriteButton.tintColor = .systemYellow
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.addTarget(self, action: #selector(didTapFavorite), for: .touchUpInside)

        titleLabel.font = .systemFont(ofSize: 22, weight: .bold)
        titleLabel.textColor = .label
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        structureContainer.backgroundColor = UIColor.systemTeal.withAlphaComponent(0.08)
        structureContainer.layer.cornerRadius = 16
        structureContainer.layer.borderWidth = 1
        structureContainer.layer.borderColor = UIColor.systemTeal.withAlphaComponent(0.25).cgColor
        structureContainer.translatesAutoresizingMaskIntoConstraints = false

        structureLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        structureLabel.textColor = .label
        structureLabel.textAlignment = .center
        structureLabel.numberOfLines = 0
        structureLabel.adjustsFontSizeToFitWidth = true
        structureLabel.minimumScaleFactor = 0.75
        structureLabel.translatesAutoresizingMaskIntoConstraints = false
        structureContainer.addSubview(structureLabel)

        meaningLabel.font = .systemFont(ofSize: 18, weight: .bold)
        meaningLabel.textColor = .systemTeal
        meaningLabel.textAlignment = .center
        meaningLabel.numberOfLines = 0
        meaningLabel.translatesAutoresizingMaskIntoConstraints = false

        tapHintLabel.text = "Chạm vào thẻ để xem giải thích & ví dụ câu"
        tapHintLabel.font = .systemFont(ofSize: 13, weight: .regular)
        tapHintLabel.textColor = .secondaryLabel
        tapHintLabel.textAlignment = .center
        tapHintLabel.translatesAutoresizingMaskIntoConstraints = false

        frontView.addSubview(badgeLabel)
        frontView.addSubview(favoriteButton)
        frontView.addSubview(titleLabel)
        frontView.addSubview(structureContainer)
        frontView.addSubview(meaningLabel)
        frontView.addSubview(tapHintLabel)
    }

    private func setupBackContent() {
        backScrollView.translatesAutoresizingMaskIntoConstraints = false
        backScrollView.showsVerticalScrollIndicator = true
        backContentView.translatesAutoresizingMaskIntoConstraints = false

        backView.addSubview(backScrollView)
        backScrollView.addSubview(backContentView)

        backTitleLabel.font = .systemFont(ofSize: 15, weight: .bold)
        backTitleLabel.textColor = .systemTeal
        backTitleLabel.numberOfLines = 0
        backTitleLabel.translatesAutoresizingMaskIntoConstraints = false

        explanationHeaderLabel.text = "💡 Giải thích & Cách dùng"
        explanationHeaderLabel.font = .systemFont(ofSize: 15, weight: .bold)
        explanationHeaderLabel.textColor = .label
        explanationHeaderLabel.translatesAutoresizingMaskIntoConstraints = false

        explanationLabel.font = .systemFont(ofSize: 14, weight: .regular)
        explanationLabel.textColor = .secondaryLabel
        explanationLabel.numberOfLines = 0
        explanationLabel.translatesAutoresizingMaskIntoConstraints = false

        exampleContainer.backgroundColor = .secondarySystemBackground
        exampleContainer.layer.cornerRadius = 14
        exampleContainer.translatesAutoresizingMaskIntoConstraints = false

        exampleHeaderLabel.text = "Ví dụ minh họa"
        exampleHeaderLabel.font = .systemFont(ofSize: 12, weight: .bold)
        exampleHeaderLabel.textColor = .systemTeal
        exampleHeaderLabel.translatesAutoresizingMaskIntoConstraints = false

        exampleJpLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        exampleJpLabel.textColor = .label
        exampleJpLabel.numberOfLines = 0
        exampleJpLabel.translatesAutoresizingMaskIntoConstraints = false

        exampleReadingLabel.font = .systemFont(ofSize: 13, weight: .regular)
        exampleReadingLabel.textColor = .systemTeal
        exampleReadingLabel.numberOfLines = 0
        exampleReadingLabel.translatesAutoresizingMaskIntoConstraints = false

        exampleViLabel.font = .systemFont(ofSize: 13, weight: .medium)
        exampleViLabel.textColor = .secondaryLabel
        exampleViLabel.numberOfLines = 0
        exampleViLabel.translatesAutoresizingMaskIntoConstraints = false

        exampleAudioButton.setImage(UIImage(systemName: "speaker.wave.2.fill"), for: .normal)
        exampleAudioButton.tintColor = .systemTeal
        exampleAudioButton.backgroundColor = UIColor.systemTeal.withAlphaComponent(0.14)
        exampleAudioButton.layer.cornerRadius = 18
        exampleAudioButton.translatesAutoresizingMaskIntoConstraints = false
        exampleAudioButton.addTarget(self, action: #selector(playExampleAudio), for: .touchUpInside)

        exampleContainer.addSubview(exampleHeaderLabel)
        exampleContainer.addSubview(exampleJpLabel)
        exampleContainer.addSubview(exampleReadingLabel)
        exampleContainer.addSubview(exampleViLabel)
        exampleContainer.addSubview(exampleAudioButton)

        backContentView.addSubview(backTitleLabel)
        backContentView.addSubview(explanationHeaderLabel)
        backContentView.addSubview(explanationLabel)
        backContentView.addSubview(exampleContainer)
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
            badgeLabel.leadingAnchor.constraint(equalTo: frontView.leadingAnchor, constant: 18),
            badgeLabel.heightAnchor.constraint(equalToConstant: 26),
            badgeLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 140),

            favoriteButton.centerYAnchor.constraint(equalTo: badgeLabel.centerYAnchor),
            favoriteButton.trailingAnchor.constraint(equalTo: frontView.trailingAnchor, constant: -18),
            favoriteButton.widthAnchor.constraint(equalToConstant: 32),
            favoriteButton.heightAnchor.constraint(equalToConstant: 32),

            titleLabel.topAnchor.constraint(equalTo: badgeLabel.bottomAnchor, constant: 22),
            titleLabel.leadingAnchor.constraint(equalTo: frontView.leadingAnchor, constant: 18),
            titleLabel.trailingAnchor.constraint(equalTo: frontView.trailingAnchor, constant: -18),

            structureContainer.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 18),
            structureContainer.leadingAnchor.constraint(equalTo: frontView.leadingAnchor, constant: 18),
            structureContainer.trailingAnchor.constraint(equalTo: frontView.trailingAnchor, constant: -18),
            structureContainer.heightAnchor.constraint(lessThanOrEqualToConstant: 150),

            structureLabel.topAnchor.constraint(equalTo: structureContainer.topAnchor, constant: 14),
            structureLabel.leadingAnchor.constraint(equalTo: structureContainer.leadingAnchor, constant: 14),
            structureLabel.trailingAnchor.constraint(equalTo: structureContainer.trailingAnchor, constant: -14),
            structureLabel.bottomAnchor.constraint(equalTo: structureContainer.bottomAnchor, constant: -14),

            meaningLabel.topAnchor.constraint(equalTo: structureContainer.bottomAnchor, constant: 18),
            meaningLabel.leadingAnchor.constraint(equalTo: frontView.leadingAnchor, constant: 18),
            meaningLabel.trailingAnchor.constraint(equalTo: frontView.trailingAnchor, constant: -18),
            meaningLabel.bottomAnchor.constraint(lessThanOrEqualTo: tapHintLabel.topAnchor, constant: -12),

            tapHintLabel.bottomAnchor.constraint(equalTo: frontView.bottomAnchor, constant: -16),
            tapHintLabel.leadingAnchor.constraint(equalTo: frontView.leadingAnchor, constant: 16),
            tapHintLabel.trailingAnchor.constraint(equalTo: frontView.trailingAnchor, constant: -16),

            // Back
            backScrollView.topAnchor.constraint(equalTo: backView.topAnchor),
            backScrollView.leadingAnchor.constraint(equalTo: backView.leadingAnchor),
            backScrollView.trailingAnchor.constraint(equalTo: backView.trailingAnchor),
            backScrollView.bottomAnchor.constraint(equalTo: backView.bottomAnchor),

            backContentView.topAnchor.constraint(equalTo: backScrollView.topAnchor),
            backContentView.leadingAnchor.constraint(equalTo: backScrollView.leadingAnchor),
            backContentView.trailingAnchor.constraint(equalTo: backScrollView.trailingAnchor),
            backContentView.bottomAnchor.constraint(equalTo: backScrollView.bottomAnchor),
            backContentView.widthAnchor.constraint(equalTo: backScrollView.widthAnchor),

            backTitleLabel.topAnchor.constraint(equalTo: backContentView.topAnchor, constant: 18),
            backTitleLabel.leadingAnchor.constraint(equalTo: backContentView.leadingAnchor, constant: 18),
            backTitleLabel.trailingAnchor.constraint(equalTo: backContentView.trailingAnchor, constant: -18),

            explanationHeaderLabel.topAnchor.constraint(equalTo: backTitleLabel.bottomAnchor, constant: 12),
            explanationHeaderLabel.leadingAnchor.constraint(equalTo: backContentView.leadingAnchor, constant: 18),
            explanationHeaderLabel.trailingAnchor.constraint(equalTo: backContentView.trailingAnchor, constant: -18),

            explanationLabel.topAnchor.constraint(equalTo: explanationHeaderLabel.bottomAnchor, constant: 6),
            explanationLabel.leadingAnchor.constraint(equalTo: backContentView.leadingAnchor, constant: 18),
            explanationLabel.trailingAnchor.constraint(equalTo: backContentView.trailingAnchor, constant: -18),

            exampleContainer.topAnchor.constraint(equalTo: explanationLabel.bottomAnchor, constant: 16),
            exampleContainer.leadingAnchor.constraint(equalTo: backContentView.leadingAnchor, constant: 16),
            exampleContainer.trailingAnchor.constraint(equalTo: backContentView.trailingAnchor, constant: -16),
            exampleContainer.bottomAnchor.constraint(equalTo: backContentView.bottomAnchor, constant: -18),

            exampleHeaderLabel.topAnchor.constraint(equalTo: exampleContainer.topAnchor, constant: 12),
            exampleHeaderLabel.leadingAnchor.constraint(equalTo: exampleContainer.leadingAnchor, constant: 14),
            exampleHeaderLabel.trailingAnchor.constraint(equalTo: exampleAudioButton.leadingAnchor, constant: -8),

            exampleJpLabel.topAnchor.constraint(equalTo: exampleHeaderLabel.bottomAnchor, constant: 6),
            exampleJpLabel.leadingAnchor.constraint(equalTo: exampleContainer.leadingAnchor, constant: 14),
            exampleJpLabel.trailingAnchor.constraint(equalTo: exampleAudioButton.leadingAnchor, constant: -8),

            exampleReadingLabel.topAnchor.constraint(equalTo: exampleJpLabel.bottomAnchor, constant: 4),
            exampleReadingLabel.leadingAnchor.constraint(equalTo: exampleContainer.leadingAnchor, constant: 14),
            exampleReadingLabel.trailingAnchor.constraint(equalTo: exampleAudioButton.leadingAnchor, constant: -8),

            exampleViLabel.topAnchor.constraint(equalTo: exampleReadingLabel.bottomAnchor, constant: 4),
            exampleViLabel.leadingAnchor.constraint(equalTo: exampleContainer.leadingAnchor, constant: 14),
            exampleViLabel.trailingAnchor.constraint(equalTo: exampleAudioButton.leadingAnchor, constant: -8),
            exampleViLabel.bottomAnchor.constraint(equalTo: exampleContainer.bottomAnchor, constant: -12),

            exampleAudioButton.centerYAnchor.constraint(equalTo: exampleContainer.centerYAnchor),
            exampleAudioButton.trailingAnchor.constraint(equalTo: exampleContainer.trailingAnchor, constant: -12),
            exampleAudioButton.widthAnchor.constraint(equalToConstant: 36),
            exampleAudioButton.heightAnchor.constraint(equalToConstant: 36)
        ])
    }

    public func configure(with point: GrammarPoint) {
        self.currentPoint = point
        resetFlip(animated: false)
        backScrollView.setContentOffset(.zero, animated: false)

        let level = point.lessonNumber <= 25 ? "N5" : "N4"
        let accentColor: UIColor = point.lessonNumber <= 25 ? .systemTeal : .systemBlue
        badgeLabel.text = "  BÀI \(point.lessonNumber) • NGỮ PHÁP \(level)  "
        badgeLabel.textColor = accentColor
        badgeLabel.backgroundColor = accentColor.withAlphaComponent(0.14)
        titleLabel.text = point.title
        structureLabel.text = point.structure
        meaningLabel.text = point.meaning

        backTitleLabel.text = "Bài \(point.lessonNumber) (\(level)): \(point.title)"
        explanationLabel.text = point.explanation
        exampleJpLabel.text = point.exampleJp
        exampleReadingLabel.text = point.exampleReading
        exampleViLabel.text = point.exampleVi

        updateFavoriteButton()
    }

    private func updateFavoriteButton() {
        guard let point = currentPoint else { return }
        let isMastered = ProgressService.shared.isMastered(id: point.id)
        let iconName = isMastered ? "star.fill" : "star"
        favoriteButton.setImage(UIImage(systemName: iconName), for: .normal)
    }

    @objc private func didTapFavorite() {
        guard let point = currentPoint else { return }
        let newState = ProgressService.shared.toggleMastered(id: point.id)
        let iconName = newState ? "star.fill" : "star"
        favoriteButton.setImage(UIImage(systemName: iconName), for: .normal)
        delegate?.grammarFlashcardDidToggleMastered(self, point: point, isMastered: newState)
    }

    @objc private func handleCardTap() {
        flip()
    }

    @objc private func playExampleAudio() {
        guard let point = currentPoint else { return }
        AudioService.shared.speak(text: point.exampleJp)
    }

    public func flip() {
        let fromView = isFlipped ? backView : frontView
        let toView = isFlipped ? frontView : backView

        UIView.transition(
            from: fromView,
            to: toView,
            duration: 0.4,
            options: [.transitionFlipFromRight, .showHideTransitionViews]
        ) { [weak self] _ in
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
