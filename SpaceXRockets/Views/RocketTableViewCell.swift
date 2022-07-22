//
//  RocketTableViewCell.swift
//  SpaceXRockets
//
//  Created by Владимир Фалин on 17.07.2022.
//

import UIKit

class RocketTableViewCell: UITableViewCell {

    let rocketImageView = UIImageView()
    let rocketNameLabel = UILabel()
    let rocketHeightLabel = UILabel()
    let rocketDiameterLabel = UILabel()
    let rocketMassLabel = UILabel()

    //MARK: - override metods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .darkGray
        contentView.layer.cornerRadius = 20
        
        setupRocketImageView()
        setupLabel(label: rocketNameLabel, font: .boldSystemFont(ofSize: 20))
        setupLabel(label: rocketHeightLabel, font: .systemFont(ofSize: 16))
        setupLabel(label: rocketDiameterLabel, font: .systemFont(ofSize: 16))
        setupLabel(label: rocketMassLabel, font: .systemFont(ofSize: 16))
        
        setupImageViewConstraint()
        setupLabelConstraint(label: rocketNameLabel, topAnchor: 20)
        setupLabelConstraint(label: rocketHeightLabel, topAnchor: 60)
        setupLabelConstraint(label: rocketDiameterLabel, topAnchor: 100)
        setupLabelConstraint(label: rocketMassLabel, topAnchor: 140)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10))
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if self.isSelected {
            contentView.backgroundColor = .lightGray
        } else {
            contentView.backgroundColor = .darkGray
        }
    }

    // MARK: - Private methods
    
    private func setupRocketImageView() {
        rocketImageView.contentMode = .scaleToFill
        rocketImageView.clipsToBounds = true
        rocketImageView.translatesAutoresizingMaskIntoConstraints = false
        rocketImageView.backgroundColor = .white
        rocketImageView.layer.cornerRadius = 20
        contentView.addSubview(rocketImageView)
    }
    
    private func setupImageViewConstraint() {
        rocketImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        rocketImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        rocketImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        rocketImageView.widthAnchor.constraint(equalToConstant: 180).isActive = true
    }
    
    private func setupLabel(label: UILabel, font: UIFont) {
        label.textColor = .white
        label.textAlignment = .right
        label.font = font
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        contentView.addSubview(label)
    }

    private func setupLabelConstraint(label: UILabel, topAnchor: CGFloat) {
        label.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        label.leftAnchor.constraint(equalTo: rocketImageView.rightAnchor, constant: 20).isActive = true
        label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: topAnchor).isActive = true
        label.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
}
