//
//  HomeViewController.swift
//  MoodBoredApp
//
//  Created by Marc Meinhardt on 02.08.20.
//  Copyright © 2020 Marc Meinhardt. All rights reserved.
//

import UIKit

class HomeViewController : UIViewController {
    
    // PROPERTIES :
    var adBannerView    = UIView()
    var replyLabel      = UIButton()
    var collectionLabel = UILabel()
    var moodLabel       = UILabel()
    
    let tableView       = UITableView() 
    
    let collectionListView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 4
        let cv = UICollectionView(frame: .infinite, collectionViewLayout: layout)
        return cv
    }()
    
    let moodListView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 4
        let cv = UICollectionView(frame: .infinite, collectionViewLayout: layout)
        return cv
    }()
    
    let stackView = UIStackView()
    
    // VIEW DID LOAD:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }

    func configureView() {
        view.backgroundColor = .systemBackground
        configureAddBannerView()
        configureReplyLabel()
        configureCollectionsLabel()
        configureCollectionsViews()
        configureMoodsLabel()
        configureMoodsViews()
    }
    
    func configureAddBannerView() {
        view.addSubview(adBannerView)
        
        adBannerView.translatesAutoresizingMaskIntoConstraints = false
        adBannerView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        adBannerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        adBannerView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -10).isActive = true
        adBannerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        adBannerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        adBannerView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        adBannerView.backgroundColor = .red
    }
    
    func configureReplyLabel() {
        view.addSubview(replyLabel)
        
        replyLabel.backgroundColor = .magenta
        
        replyLabel.translatesAutoresizingMaskIntoConstraints = false
        replyLabel.topAnchor.constraint(equalTo: self.adBannerView.bottomAnchor, constant: 50).isActive = true
        replyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        replyLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -10).isActive = true
        replyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        replyLabel.setTitle("TEST BUTTON LENGTH TEST BUTTON TEST BUTTON ", for: .normal)
        replyLabel.layer.cornerRadius = 16
        replyLabel.titleLabel?.font = UIFont.systemFont(ofSize: 21, weight: UIFont.Weight.medium)
        replyLabel.titleLabel?.numberOfLines = 4
    }
    
    func configureCollectionsLabel() {
        
        view.addSubview(collectionLabel)

        collectionLabel.translatesAutoresizingMaskIntoConstraints = false
        collectionLabel.topAnchor.constraint(equalTo: replyLabel.bottomAnchor, constant: 50).isActive = true
        collectionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        collectionLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -10).isActive = true

        collectionLabel.backgroundColor = .magenta
        collectionLabel.text = "Collections"
    }
    
    func configureMoodsLabel() {
        view.addSubview(moodLabel)
        
        moodLabel.translatesAutoresizingMaskIntoConstraints = false
        moodLabel.topAnchor.constraint(equalTo: collectionListView.bottomAnchor, constant: 10).isActive = true
        moodLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        moodLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -10).isActive = true
        
        moodLabel.backgroundColor = .magenta
        moodLabel.text = "Moods"
    }
    
    func configureCollectionsViews() {
        view.addSubview(collectionListView)
        
        setCollectionListViewDelegates()
        
        collectionListView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
        
        collectionListView.translatesAutoresizingMaskIntoConstraints = false
        collectionListView.topAnchor.constraint(equalTo: collectionLabel.bottomAnchor, constant: 10).isActive = true
        collectionListView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        collectionListView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        collectionListView.heightAnchor.constraint(equalToConstant: 50 ).isActive = true

        collectionListView.backgroundColor = .yellow
    }
    
    func configureMoodsViews() {
        view.addSubview(moodListView)
        
        setMoodListViewDelegates()
        
        moodListView.register(MoodViewCell.self, forCellWithReuseIdentifier: "cellId")
        
        moodListView.translatesAutoresizingMaskIntoConstraints = false
        moodListView.topAnchor.constraint(equalTo: moodLabel.bottomAnchor, constant: 10).isActive = true
        moodListView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        moodListView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        moodListView.heightAnchor.constraint(equalToConstant: 300 ).isActive = true
        
        moodListView.backgroundColor = .yellow
    }
    
    func setCollectionListViewDelegates() {
        
        collectionListView.delegate     = self
        collectionListView.dataSource   = self
    }
    
    func setMoodListViewDelegates() {
        
        moodListView.delegate     = self
        moodListView.dataSource   = self
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300 * 9/16, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionListView {
            return 10
        } else if collectionView == self.moodListView {
            return 5
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.collectionListView {
            let collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! CollectionViewCell
            return collectionViewCell
        } else if collectionView == self.moodListView {
            let moodViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! MoodViewCell
            return moodViewCell
        }
        fatalError()
    } 
}
