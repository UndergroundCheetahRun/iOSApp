//
//  PostViewCell.swift
//  MoodBoredApp
//
//  Created by Marc Meinhardt on 07.08.20.
//  Copyright © 2020 Marc Meinhardt. All rights reserved.
//

import UIKit

class PostViewCell: UICollectionViewCell {
    
    var cellBackground  = UIView()
    var iconView        = UIImageView()
    var dateLabel       = UILabel()
    var textLabel       = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        backgroundColor = .clear
        configureCellBackground()
        configureDateLabel()
        configureCollectionIcon()
        configurePostText()
    }
    
    func configureCellBackground() {
        addSubview(cellBackground)
        
        cellBackground.translatesAutoresizingMaskIntoConstraints = false
        cellBackground.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        cellBackground.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        cellBackground.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        cellBackground.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        
        cellBackground.backgroundColor = .magenta
        cellBackground.layer.cornerRadius = self.frame.height * 1/30
    }
    
    func configureCellImage() {
        
    }
    
    func configureDateLabel() {
        addSubview(dateLabel)
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        
        dateLabel.text = "5m ago"
        dateLabel.numberOfLines = 1
    }
    
    func configurePostText() {
        addSubview(textLabel)
        
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        textLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        textLabel.text = "Text"
        textLabel.numberOfLines = 2
    }
    
    func configureCollectionIcon() {
        addSubview(iconView)
        
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        iconView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        iconView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        iconView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        iconView.backgroundColor = .clear
        iconView.image = UIImage.init(named: "circle32")
    }
}
