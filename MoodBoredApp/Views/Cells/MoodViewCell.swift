//
//  MoodViewCell.swift
//  MoodBoredApp
//
//  Created by Marc Meinhardt on 04.08.20.
//  Copyright © 2020 Marc Meinhardt. All rights reserved.
//

import UIKit

class MoodViewCell: UICollectionViewCell {
    
    var cellBackground  = UIView()
    var iconView        = UIImageView()
    var dateLabel       = UILabel()
    var textLabel       = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    func configureView() {
        backgroundColor = .clear
        configureCellBackground()
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
