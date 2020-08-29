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
    
    let mainFeedCellID = "mainFeedCellID"
    let gridFeedCellID = "gridFeedCellID"
    let playlistFeedCellID = "playlistFeedCellID"
    
    lazy var mainCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(FeedCell.self, forCellWithReuseIdentifier: mainFeedCellID)
        cv.backgroundColor = .clear
        cv.isPagingEnabled = true
        cv.showsHorizontalScrollIndicator = false
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    let playlistListView = UITableView ()
    
    let postListView : UICollectionView = {
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
        self.setupGridView()
        DispatchQueue.main.async {
            self.postListView.reloadData()
        }
    }
    
    // NAVIGATION BAR :
    
    func configureNavigationBar() {
        self.navigationItem.title = viewTitles.library
        
        navigationController?.navigationBar.isHidden = false
        navigationController?.hidesBarsOnSwipe = true
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
            mainCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: mainCollectionView.trailingAnchor, multiplier: 0),
//            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: mainCollectionView.bottomAnchor, multiplier: 0)
        ])
        
        menuBar.delegate = self
    }
    
    // COLLECTION VIEW: configure collection view
    func configureCollectionView() {
        
        // Add Collection View
        view.addSubview(postListView)
        
        // Configure Collection View Background
        postListView.backgroundColor = .clear
        
        // Set Delegates
        setCollectionListViewDelegates()
        
        // Register Cell
        postListView.register(PostViewCell.self, forCellWithReuseIdentifier: "PostCellId")
        
        // Add Auto Layout Constraints
        postListView.translatesAutoresizingMaskIntoConstraints = false
        postListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        postListView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        postListView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        postListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
    }
    
    // COLLECTION VIEW: configure collection view delegates
    func setCollectionListViewDelegates() {
        postListView.delegate     = self
        postListView.dataSource   = self
    }
    
    func setupGridView() {
        let flow = postListView.collectionViewLayout as! UICollectionViewFlowLayout
        flow.minimumInteritemSpacing = 4 //CGFloat(self.cellMarginSize)
        flow.minimumLineSpacing = 4 // CGFloat(self.cellMarginSize) //* 2)
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
            
        } else if collectionView == self.postListView {
            
            return postDataArray.count
            
        }
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if collectionView == self.mainCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: mainFeedCellID, for: indexPath) as! FeedCell
            cell.backgroundColor = colors[indexPath.row]
            return cell
            
        } else if collectionView == self.postListView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCellId", for: indexPath) as! PostViewCell
            return cell
        }
        fatalError()

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.postListView {
            print("> post pressed")
            callAction()
        }
    }
}

// COLLECTION VIEW : delegate flow layout

extension FeedViewController: UICollectionViewDelegateFlowLayout {
    
    // DELEGATE FLOW LAYOUT : responsive grid view
    
    // See SL Swift : https://www.youtube.com/watch?v=FMqX628vE1c&t=729s
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt
        indexPath: IndexPath) -> CGSize {
        
        if collectionView == self.mainCollectionView {

            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
            
        } else if collectionView == self.postListView {
            let width = self.calculateWidth()
            return CGSize(width: width, height: width * 3/2)
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


extension FeedViewController : MenuBarDelegate {
    
    func didSelectItemAt(index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        mainCollectionView.scrollToItem(at: indexPath, at: [], animated: true)
    }
}

