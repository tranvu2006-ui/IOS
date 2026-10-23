//
//  StatsHeaderView.swift
//  AppHocTiengNhat
//

import UIKit

public class StatsHeaderView: UIView {
    
    private let streakValueLabel = UILabel()
    private let masteredValueLabel = UILabel()
    private let accuracyValueLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        backgroundColor = .secondarySystemGroupedBackground
        layer.cornerRadius = 18
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray5.cgColor
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.04
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowRadius = 6
        
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stack)
        
        let item1 = createStatItem(
            icon: "flame.fill",
            iconColor: .systemOrange,
            title: "Streak",
            valueLabel: streakValueLabel
        )
        let item2 = createStatItem(
            icon: "star.fill",
            iconColor: .systemYellow,
            title: "Đã thuộc",
            valueLabel: masteredValueLabel
        )
        let item3 = createStatItem(
            icon: "target",
            iconColor: .systemGreen,
            title: "Độ chính xác",
            valueLabel: accuracyValueLabel
        )
        
        stack.addArrangedSubview(item1)
        stack.addArrangedSubview(item2)
        stack.addArrangedSubview(item3)
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor, constant: 14),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -14)
        ])
        
        refresh()
    }
    
    private func createStatItem(icon: String, iconColor: UIColor, title: String, valueLabel: UILabel) -> UIView {
        let container = UIView()
        
        let iconView = UIImageView(image: UIImage(systemName: icon))
        iconView.tintColor = iconColor
        iconView.contentMode = .scaleAspectFit
        iconView.translatesAutoresizingMaskIntoConstraints = false
        
        valueLabel.font = .systemFont(ofSize: 18, weight: .bold)
        valueLabel.textColor = .label
        valueLabel.textAlignment = .center
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 12, weight: .medium)
        titleLabel.textColor = .secondaryLabel
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        container.addSubview(iconView)
        container.addSubview(valueLabel)
        container.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            iconView.topAnchor.constraint(equalTo: container.topAnchor),
            iconView.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 22),
            iconView.heightAnchor.constraint(equalToConstant: 22),
            
            valueLabel.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 4),
            valueLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            valueLabel.leadingAnchor.constraint(greaterThanOrEqualTo: container.leadingAnchor),
            valueLabel.trailingAnchor.constraint(lessThanOrEqualTo: container.trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: valueLabel.bottomAnchor, constant: 2),
            titleLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])
        
        return container
    }
    
    public func refresh() {
        let streak = ProgressService.shared.getStreak()
        let mastered = ProgressService.shared.getMasteredCount()
        let accuracy = ProgressService.shared.getQuizAccuracyPercentage()
        
        streakValueLabel.text = "\(streak) ngày"
        masteredValueLabel.text = "\(mastered) từ"
        accuracyValueLabel.text = accuracy > 0 ? "\(accuracy)%" : "--"
    }
}
