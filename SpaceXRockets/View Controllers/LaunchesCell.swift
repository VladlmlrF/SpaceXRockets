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
        
        setupLaunchNameLabel()
        setupDateLabel()
        setupImageView()
        contentView.addSubview(launchNameLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(rocketImageView)
        setupImageViewConstraint()
        setupLaunchLabelConstraint()
        setupDateLabelConstraint()
    }
    
    override var frame: CGRect {
            get {
                return super.frame
            }
            set (newFrame) {
                var frame = newFrame
                let newWidth = frame.width - 40 // get 80% width here
                //let space = (frame.width - newWidth) / 2
                frame.size.width = newWidth
                frame.origin.x += 20

                super.frame = frame

            }
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let bottomSpace: CGFloat = 20
        self.contentView.frame = self.contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: bottomSpace, right: 0))
    }
    
    private func setupImageView() {
        rocketImageView.image = UIImage()
        rocketImageView.contentMode = .scaleAspectFit
        rocketImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupImageViewConstraint() {
        rocketImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        rocketImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        rocketImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        rocketImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    private func setupLaunchNameLabel() {
        launchNameLabel.text = "Hello"
        launchNameLabel.textColor = .white
        launchNameLabel.font = .systemFont(ofSize: 20)
        launchNameLabel.textAlignment = .left
        launchNameLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupLaunchLabelConstraint() {
        launchNameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        launchNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        launchNameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        launchNameLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    private func setupDateLabel() {
        dateLabel.text = "Hello"
        dateLabel.textColor = .lightGray
        dateLabel.textAlignment = .left
        dateLabel.font = .systemFont(ofSize: 16)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupDateLabelConstraint() {
        dateLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
        dateLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -120).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }

}
