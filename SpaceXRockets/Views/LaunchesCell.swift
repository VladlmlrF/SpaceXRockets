//
//  LaunchesCell.swift
//  SpaceXRockets
//
//  Created by Владимир Фалин on 20.07.2022.
//

import UIKit

class LaunchesCell: UITableViewCell {

    let launchNameLabel = UILabel()
    let dateLabel = UILabel()
    let rocketImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .darkGray
        contentView.layer.cornerRadius = 20
        
        setupLabel(label: launchNameLabel, fontSize: 20, color: .white)
        setupLabel(label: dateLabel, fontSize: 16, color: .lightGray)
        setupImageView()
        setupImageViewConstraint()
        setupLaunchLabelConstraint()
        setupDateLabelConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.frame = self.contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 20, bottom: 20, right: 20))
    }
    
    private func setupImageView() {
        rocketImageView.image = UIImage()
        rocketImageView.contentMode = .scaleAspectFit
        rocketImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(rocketImageView)
    }
    
    private func setupImageViewConstraint() {
        rocketImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        rocketImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        rocketImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        rocketImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    private func setupLabel(label: UILabel, fontSize: CGFloat, color: UIColor) {
        label.text = "?"
        label.textColor = color
        label.font = .systemFont(ofSize: fontSize)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)
    }
    
    private func setupLaunchLabelConstraint() {
        launchNameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        launchNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        launchNameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        launchNameLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    private func setupDateLabelConstraint() {
        dateLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
        dateLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -120).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }

}
