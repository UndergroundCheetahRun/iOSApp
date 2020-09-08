//
//  FeedViewCell.swift
//  MoodBoredApp
//
//  Created by Marc Meinhardt on 27.08.20.
//  Copyright © 2020 Marc Meinhardt. All rights reserved.
//

import Foundation
import UIKit

class FeedViewCell : UICollectionViewCell {
    
    let posts : [String]? = ["AAA", "BBB", "CCC", "DDD", "EEE", "FFF", "GGG", "HHH", "III", "JJJ"]
    
    let postCellId = "postId"
    
    var cellMarginSize = 4.0
    
    lazy var postGridView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets.init(top: 4, left: 4, bottom: 4, right: 4)
        
        let cv = UICollectionView(frame: .init(), collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(PostViewCell.self, forCellWithReuseIdentifier: postCellId)
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .yellow
        
        configureCollectionView()
        setupGridView()
        DispatchQueue.main.async {
            self.postGridView.reloadData()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // COLLECTION VIEW: configure collection view
    func configureCollectionView() {
        
        // Add Collection View
        addSubview(postGridView)
        
        // Add Auto Layout Constraints
        NSLayoutConstraint.activate([
            postGridView.topAnchor.constraint(equalTo: topAnchor),
            postGridView.leadingAnchor.constraint(equalTo: leadingAnchor),
            postGridView.trailingAnchor.constraint(equalTo: trailingAnchor),
            postGridView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        // Configure Collection View Background
        postGridView.backgroundColor = .green
    }
    
    func setupGridView() {
        let flow = postGridView.collectionViewLayout as! UICollectionViewFlowLayout
        flow.minimumInteritemSpacing = 4 //CGFloat(self.cellMarginSize)
        flow.minimumLineSpacing = 4 // CGFloat(self.cellMarginSize) //* 2)
    }
    

}

// COLLECTION VIEW : delegate + datasource

extension FeedViewCell: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        if collectionView == self.postGridView {
            guard let posts = posts else { return 0 }
            return posts.count
        }

        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if collectionView == self.postGridView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: postCellId, for: indexPath) as! PostViewCell
            return cell
        }
        fatalError()

    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.postGridView {
            print("> post pressed")
        }
    }
}

// COLLECTION VIEW : delegate flow layout

extension FeedViewCell: UICollectionViewDelegateFlowLayout {

    // DELEGATE FLOW LAYOUT : responsive grid view

    // See SL Swift : https://www.youtube.com/watch?v=FMqX628vE1c&t=729s
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt
        indexPath: IndexPath) -> CGSize {

        if collectionView == self.postGridView {
            let width = self.calculateWidth()
            print(width)
            return CGSize(width: width, height: width * 3/2)
        }

        fatalError()
    }

    // DELEGATE FLOW LAYOUT :


    // FUNCTION : calculate width of a cell

    func calculateWidth() -> CGFloat {

        let collectionViewWidth = self.contentView.frame.width
        let estimateWidth = collectionViewWidth / 3.5
        let estimatedWidth = CGFloat(estimateWidth)
        let cellCount = floor(CGFloat(frame.size.width / estimatedWidth))

        let margins = CGFloat(cellMarginSize * 2)
        let width = (collectionViewWidth - CGFloat(cellMarginSize) * (cellCount - 1) - margins) / cellCount
        //print(estimateWidth, estimatedWidth, cellCount, margins, width)

        return width
    }
}

