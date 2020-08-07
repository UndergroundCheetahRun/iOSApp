//
//  CollectionViewCell.swift
//  MoodBoredApp
//
//  Created by Marc Meinhardt on 02.08.20.
//  Copyright © 2020 Marc Meinhardt. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    var cellBackground = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureCell()
    }
    
    func configureCell() {
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
        
        cellBackground.backgroundColor = .systemBlue
        cellBackground.layer.cornerRadius = self.frame.height / 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
