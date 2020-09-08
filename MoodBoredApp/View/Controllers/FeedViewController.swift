//
//  FeedViewController.swift
//  MoodBoredApp
//
//  Created by Marc Meinhardt on 02.08.20.
//  Copyright © 2020 Marc Meinhardt. All rights reserved.
//

import UIKit

class FeedViewController : UIViewController {
    
    // PROPERTIES :
    
    let postDataArray = ["AAA", "BBB", "CCC", "DDD", "EEE", "FFF", "GGG", "HHH", "III", "JJJ"]

    var cellMarginSize = 4.0
    
    struct viewTitles {
        static let home     = "Home"
        static let library  = "Library"
    }
    
    let colors : [UIColor] = [.systemRed, .systemBlue]
    
    let menuBar = MenuBar()
    
    let mainFeedCellID = "feedViewCell "//"mainFeedCellID"
    let gridFeedCellID = "gridFeedCellID"
    let playlistFeedCellID = "playlistFeedCellID"
    
    
    lazy var mainCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(FeedViewCell.self, forCellWithReuseIdentifier: mainFeedCellID)
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: playlistFeedCellID)
        cv.isPagingEnabled = true
        cv.backgroundColor = .systemBackground
        cv.showsHorizontalScrollIndicator = false
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    let playlistListView = UITableView ()
    
    // VIEW DID LOAD :
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        configureNavigationBar()
//        configureCollectionView()
//        setupGridView()
        configureMenuBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

    }
    
    // NAVIGATION BAR :
    
    func configureNavigationBar() {
        self.navigationItem.title = viewTitles.library
        navigationController?.navigationBar.isHidden = false
        navigationController?.hidesBarsOnSwipe = true
        navigationController?.navigationBar.isTranslucent = false
        
        tabBarController?.tabBar.isTranslucent = false
    }
    
    // MENU BAR :
    
    func configureMenuBar() {
        
        view.addSubview(menuBar)
        view.addSubview(mainCollectionView)

        menuBar.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            // menubar
            menuBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            menuBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            menuBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            menuBar.heightAnchor.constraint(equalToConstant: 36),
            
            // collectionview
            mainCollectionView.topAnchor.constraint(equalTo: menuBar.bottomAnchor, constant: 0),
            mainCollectionView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 0),
            mainCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainCollectionView.heightAnchor.constraint(equalToConstant: view.frame.height)
        ])

        menuBar.delegate = self
    }
    
    // ACTIONS
    func callAction() {
        print("> present view")
        let view = PostDetailViewController()
        navigationController?.popViewController(animated: true)
        view.modalPresentationStyle = .overFullScreen
        self.present(view, animated: true, completion: nil)
        //self.navigationController?.pushViewController(view, animated: true)
    }
}

// COLLECTION VIEW : delegate + datasource

extension FeedViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.mainCollectionView {
            
            return colors.count
            
        }
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if indexPath == [0, 0] {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: mainFeedCellID, for: indexPath) as! FeedViewCell
            return cell
        } else if indexPath == [0, 1] {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: playlistFeedCellID, for: indexPath) as! UICollectionViewCell
            cell.backgroundColor = .magenta
            return cell
        }

        fatalError()

    }

}

// COLLECTION VIEW : delegate flow layout

extension FeedViewController: UICollectionViewDelegateFlowLayout {
    
    // DELEGATE FLOW LAYOUT : responsive grid view
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt
        indexPath: IndexPath) -> CGSize {
        
        if collectionView == self.mainCollectionView {

            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
            
        }
        fatalError()
    }
    
    // DELEGATE FLOW LAYOUT :
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        let index = targetContentOffset.pointee.x / view.frame.width
//        menuBar.selectItem(at: Int(index))
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.scrollIndicator(to: scrollView.contentOffset)
    }
}


extension FeedViewController : MenuBarDelegate {
    
    func didSelectItemAt(index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        mainCollectionView.scrollToItem(at: indexPath, at: [], animated: true)
    }
}

