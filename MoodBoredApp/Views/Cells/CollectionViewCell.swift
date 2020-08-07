//
//  CollectionViewCell.swift
//  MoodBoredApp
//
//  Created by Marc Meinhardt on 02.08.20.
//  Copyright © 2020 Marc Meinhardt. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    var cellBackground  = UIView()
    var iconView        = UIImageView()
    var dateLabel       = UILabel()
    var textLabel       = UILabel()
    
    var stackView       = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell() {
        backgroundColor = .clear
        configureCellBackground()
        configureStackView()
    }
    
    func configureCellBackground() {
        
        addSubview(cellBackground)
        
        cellBackground.translatesAutoresizingMaskIntoConstraints = false
        cellBackground.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        cellBackground.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        cellBackground.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        cellBackground.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        
        cellBackground.backgroundColor = .systemBlue
        cellBackground.layer.cornerRadius = self.frame.height / 2
    }
    
    func configureStackView() {
        self.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        
        stackView.addArrangedSubview(iconView)
        stackView.addArrangedSubview(textLabel)
        
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 2
        stackView.alignment = .center
        
        configureCollectionLabel()
        configureCollectionIcon()
    }
    
    func configureCollectionLabel() {
        let barChar = " | "
        let collectionName = "Collection Label"
        
        let attributeStringFull = NSMutableAttributedString()
        let attributeStringOne = NSAttributedString.init(string: barChar, attributes: [NSAttributedString.Key.baselineOffset: 1])
        let attributeStringTwo = NSAttributedString.init(string: collectionName, attributes: [NSAttributedString.Key.baselineOffset: 0])
        
        attributeStringFull.append(attributeStringOne)
        attributeStringFull.append(attributeStringTwo)
        
        textLabel.attributedText = attributeStringFull
        textLabel.numberOfLines = 1
    }
    
    func configureCollectionIcon() {
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        iconView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        iconView.backgroundColor = .clear
        iconView.image = UIImage.init(named: "circle32")
    }
}
