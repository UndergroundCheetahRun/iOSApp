//
//  FeedViewController.swift
//  MoodBoredApp
//
//  Created by Marc Meinhardt on 02.08.20.
//  Copyright © 2020 Marc Meinhardt. All rights reserved.
//

import UIKit

class LibraryViewController : UIViewController {

    // PROPERTIES :

    let dataArray = ["AAA", "BBB", "CCC", "DDD", "EEE", "FFF", "GGG", "HHH", "III", "JJJ"]

    var cellMarginSize = 4.0
    
    struct viewTitles {
        static let home     = "Home"
        static let library  = "Library"
    }
    
    let moodListView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets.init(top: 4, left: 4, bottom: 4, right: 4)
        let cv = UICollectionView(frame: .init(), collectionViewLayout: layout)
        return cv
    }()
    
    // VIEW DID LOAD :
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        configureView()
        configureNavigationBar()
        configureCollectionView()
        setupGridView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.setupGridView()
        DispatchQueue.main.async {
            self.moodListView.reloadData()
        }
    }
    
    // NAVIGATION BAR :
    func configureNavigationBar() {
        self.navigationItem.title = viewTitles.library
    }
    
    // VIEW : configure View
    func configureView() {
        
    }
    
    // COLLECTION VIEW: configure collection view
    func configureCollectionView() {
        
        // Add Collection View
        view.addSubview(moodListView)
        
        // Configure Collection View Background
        moodListView.backgroundColor = .clear
        
        // Set Delegates
        setCollectionListViewDelegates()
        
        // Register Cell
        moodListView.register(MoodViewCell.self, forCellWithReuseIdentifier: "MoodCellId")
        
        // Add Auto Layout Constraints
        moodListView.translatesAutoresizingMaskIntoConstraints = false
        moodListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        moodListView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        moodListView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        moodListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
    }
    
    // COLLECTION VIEW: configure collection view delegates
    func setCollectionListViewDelegates() {
        moodListView.delegate     = self
        moodListView.dataSource   = self
    }
    
    func setupGridView() {
        let flow = moodListView.collectionViewLayout as! UICollectionViewFlowLayout
        flow.minimumInteritemSpacing = 4 //CGFloat(self.cellMarginSize)
        flow.minimumLineSpacing = 4 // CGFloat(self.cellMarginSize) //* 2)
    }
}

extension LibraryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoodCellId", for: indexPath) as! MoodViewCell
        return cell
    }
}

extension LibraryViewController: UICollectionViewDelegateFlowLayout {
    
    // GRID : responsive grid view
    
    // See SL Swift : https://www.youtube.com/watch?v=FMqX628vE1c&t=729s
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.calculateWidth()
        return CGSize(width: width, height: width * 3/2)
    }

    // FUNCTION : calculate width of a cell
    func calculateWidth() -> CGFloat {
        let estimateWidth = view.frame.width / 3.5
        let estimatedWidth = CGFloat(estimateWidth)
        let cellCount = floor(CGFloat(self.view.frame.size.width / estimatedWidth))
        
        let margins = CGFloat(cellMarginSize * 2)
        let width = (self.view.frame.size.width - CGFloat(cellMarginSize) * (cellCount - 1) - margins) / cellCount
        //print(estimateWidth, estimatedWidth, cellCount, margins, width)
        
        return width
    }
}
