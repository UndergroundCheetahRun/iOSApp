//
//  MoodViewCell.swift
//  MoodBoredApp
//
//  Created by Marc Meinhardt on 04.08.20.
//  Copyright © 2020 Marc Meinhardt. All rights reserved.
//

import UIKit

class MoodViewCell: UICollectionViewCell {
    
    var imageView  = UIView()
    var iconView        = UIImageView()
    var dateLabel       = UILabel()
    var textLabel       = UILabel()
    
    var borderAlpha : CGFloat = 0
    
    
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
        configureCollectionIcon()
        configureMoodLabel()
    }
    
    func configureCellBackground() {
        addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        
        imageView.backgroundColor = .magenta
        imageView.layer.cornerRadius = self.frame.height * 1/30
    }
    
    func configureCellImage() {
        
    }
    
    func configureMoodLabel() {
        addSubview(textLabel)
        
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        textLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        textLabel.text = "Mood\nLabel"
        textLabel.numberOfLines = 2
    }
    
    func configureCollectionIcon() {
        addSubview(iconView)
        
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        iconView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        iconView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        iconView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        iconView.backgroundColor = .clear
        iconView.image = UIImage.init(named: "circle32")
    }
    
    // ACTIONS
    
    func showBorderAction() {
        print("> mood selected")
        self.borderAlpha = 1
        imageView.layer.borderColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: borderAlpha).cgColor
        imageView.layer.borderWidth = 4
    }
    
    func hideBorderAction() {
        self.borderAlpha = 0
        imageView.layer.borderColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: borderAlpha).cgColor
        imageView.layer.borderWidth = 4
    }
}
