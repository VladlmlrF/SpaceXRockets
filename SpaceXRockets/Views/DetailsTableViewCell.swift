//
//  DetailsTableViewCell.swift
//  SpaceXRockets
//
//  Created by Владимир Фалин on 20.07.2022.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {

    let propertyNameLabel = UILabel()
    let propertyValueLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupPropertyLabel(label: propertyNameLabel, aligment: .left)
        setupPropertyLabel(label: propertyValueLabel, aligment: .right)
        setupPropertyLabelConstraint(label: propertyNameLabel, left: 30, right: -contentView.frame.width / 2 - 30)
        setupPropertyLabelConstraint(label: propertyValueLabel, left: contentView.frame.width / 2 + 70, right: -30)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupPropertyLabel(label: UILabel, aligment: NSTextAlignment) {
        label.text = "?"
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = aligment
        label.font = .systemFont(ofSize: 17)
        contentView.addSubview(label)
    }
    
    private func setupPropertyLabelConstraint(label: UILabel, left: CGFloat, right: CGFloat) {
        label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        label.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: left).isActive = true
        label.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: right).isActive = true
    }
}
