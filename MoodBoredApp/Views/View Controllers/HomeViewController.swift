//
//  HomeViewController.swift
//  MoodBoredApp
//
//  Created by Marc Meinhardt on 02.08.20.
//  Copyright © 2020 Marc Meinhardt. All rights reserved.
//

import UIKit

class HomeViewController : UIViewController {
    
    // DATA :
    
    var collectionDataArray = ["Collection", "Collection"]
    var moodDataArray = ["Mood", "Mood", "Mood", "Mood", "Mood", "Mood", "Mood"]
    
    // PROPERTIES :
    
    var adBannerView    = UIView()
    var replyLabel      = UIButton()
    var collectionLabel = UILabel()
    var moodLabel       = UILabel()
    
    let backgroundImage = UIButton()
    let backgroundImageButton = UIButton()
    var backgroundImageIsHidden = false
    
    let collectionListView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 4
        layout.sectionInset = UIEdgeInsets.init(top: 0, left: 4, bottom: 0, right: 0)
        let cv = UICollectionView(frame: .infinite, collectionViewLayout: layout)
        return cv
    }()
    
    let moodListView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 4
        layout.sectionInset = UIEdgeInsets.init(top: 0, left: 4, bottom: 0, right: 0)
        let cv = UICollectionView(frame: .infinite, collectionViewLayout: layout)
        return cv
    }()
    
    let tableView = UITableView()
    let containerView = UIView()
    
    // VIEW DID LOAD:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    func configureView() {
        view.backgroundColor = .systemBackground
        
        configureNavigationBar()
        configureBackgroundImage()
        configureTableView()
        configureContainerView()
        configureBackgroundImageButton()
        configureAddBannerView()
        configureReplyLabel()
        configureMoodsViews()
        configureMoodsLabel()
        configureCollectionsViews()
        configureCollectionsLabel()
    }
    
    // NAVIGATION BAR :
    
    func configureNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
    // BACKGROUND IMAGE :
    
    func configureBackgroundImage() {
        view.addSubview(backgroundImage)
        
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        backgroundImage.backgroundColor = .lightGray
        
        hideBackgroundImageAction()
    }
    
    // SCROLL VIEW :
    
    func configureTableView() {
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        tableView.contentSize = CGSize(width: view.frame.width, height: view.safeAreaLayoutGuide.layoutFrame.height + 1)
        
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
    }
    
    // CONTAINER VIEW :
    func configureContainerView() {
        tableView.addSubview(containerView)
        
        containerView.frame.size = CGSize(width: view.frame.width, height: view.safeAreaLayoutGuide.layoutFrame.height - (self.tabBarController?.tabBar.frame.height)! - UIApplication.shared.statusBarFrame.height)
        
        containerView.backgroundColor = .clear
    }
    
    // BACKGROUND IMAGE BUTTON :
    
    func configureBackgroundImageButton() {
        containerView.addSubview(backgroundImageButton)
        
        backgroundImageButton.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        backgroundImageButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        backgroundImageButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        backgroundImageButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        
        backgroundImageButton.addTarget(self, action: #selector(hideBackgroundImageAction), for: UIControl.Event.touchUpInside)
        
        backgroundImageButton.backgroundColor = .clear
    }
    
    // AD BANNER :
    
    func configureAddBannerView() {
        containerView.addSubview(adBannerView)
        
        adBannerView.translatesAutoresizingMaskIntoConstraints = false
        adBannerView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0).isActive = true
        adBannerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        adBannerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        adBannerView.widthAnchor.constraint(equalToConstant: 320).isActive = true
        
        adBannerView.backgroundColor = .red
    }
    
    // REPLIES :
    
    func configureReplyLabel() {
        containerView.addSubview(replyLabel)
        
        replyLabel.translatesAutoresizingMaskIntoConstraints = false
        replyLabel.topAnchor.constraint(equalTo: adBannerView.topAnchor, constant: 80).isActive = true
        replyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        replyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        replyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        replyLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        replyLabel.backgroundColor = .magenta
        replyLabel.setTitle("TEST BUTTON LENGTH TEST BUTTON TEST BUTTON ", for: .normal)
        replyLabel.layer.cornerRadius = 16
        replyLabel.titleLabel?.font = UIFont.systemFont(ofSize: 21, weight: UIFont.Weight.medium)
        replyLabel.titleLabel?.numberOfLines = 4
    }
    
    // LABELS :
    
    func configureCollectionsLabel() {
        
        containerView.addSubview(collectionLabel)

        collectionLabel.translatesAutoresizingMaskIntoConstraints = false
        collectionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        collectionLabel.bottomAnchor.constraint(equalTo: collectionListView.topAnchor, constant: -10).isActive = true
        collectionLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -10).isActive = true

        collectionLabel.backgroundColor = .magenta
        collectionLabel.text = "Collections"
    }
    
    func configureMoodsLabel() {
        containerView.addSubview(moodLabel)
        
        moodLabel.translatesAutoresizingMaskIntoConstraints = false
        moodLabel.bottomAnchor.constraint(equalTo: moodListView.topAnchor, constant: -10).isActive = true
        moodLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        moodLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -10).isActive = true
        
        moodLabel.backgroundColor = .magenta
        moodLabel.text = "Moods"
    }
    
    // COLLECTION VIEWS :
    
    func configureCollectionsViews() {
        containerView.addSubview(collectionListView)
        
        setCollectionListViewDelegates()
        
        collectionListView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
        
        collectionListView.translatesAutoresizingMaskIntoConstraints = false
        collectionListView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        collectionListView.bottomAnchor.constraint(equalTo: moodLabel.topAnchor, constant: -10).isActive = true
        collectionListView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        collectionListView.heightAnchor.constraint(equalToConstant: 45 ).isActive = true

        collectionListView.backgroundColor = .clear
    }
    
    func configureMoodsViews() {
        containerView.addSubview(moodListView)
        
        setMoodListViewDelegates()
        
        moodListView.register(MoodViewCell.self, forCellWithReuseIdentifier: "MoodCellId")
        
        moodListView.translatesAutoresizingMaskIntoConstraints = false
        moodListView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        moodListView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        moodListView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20).isActive = true
        moodListView.heightAnchor.constraint(equalToConstant: 300 ).isActive = true
        
        moodListView.backgroundColor = .clear
    }
    
    func setCollectionListViewDelegates() {
        
        collectionListView.delegate     = self
        collectionListView.dataSource   = self
    }
    
    func setMoodListViewDelegates() {
        
        moodListView.delegate     = self
        moodListView.dataSource   = self
    }
    
    // ACTIONS:
    
    func showBackgroundImageAction() {
        backgroundImage.alpha = 1
        backgroundImageIsHidden = false
    }
    
    @objc func hideBackgroundImageAction() {
        backgroundImage.alpha = 0
        backgroundImageIsHidden = true
    }
    
    func confirmAction() {
        let view = CreatePostViewController()
        navigationController?.popViewController(animated: true)
        view.modalPresentationStyle = .overFullScreen
        self.present(view, animated: true, completion: nil)
        //self.navigationController?.pushViewController(view, animated: true)
    }
    
}

// COLLECTION VIEWS : datasource, flow layout

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionListView {
            
            return 10
            
        } else if collectionView == self.moodListView {
            
            return moodDataArray.count
            
        }
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.collectionListView {
            let collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! CollectionViewCell
            return collectionViewCell
        } else if collectionView == self.moodListView {
            let moodViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoodCellId", for: indexPath) as! MoodViewCell
            return moodViewCell
        }
        fatalError()
    }
}

extension HomeViewController : UICollectionViewDelegate {
    
    // COLLECTION VIEW : cell highlighted
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        if collectionView == self.collectionListView {
            
        } else if collectionView == self.moodListView {
            if let cell = collectionView.cellForItem(at: indexPath) {
                
            }
        }
    }
    
    // COLLECTION VIEW : cell unhighlighted
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        if collectionView == self.collectionListView {
            
        } else if collectionView == self.moodListView {
            if let cell = collectionView.cellForItem(at: indexPath) {
                
            }
        }
    }

    // COLLECTION VIEW : cell selected
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionListView {
            if let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewCell {
                cell.selectCollectionAction()
            }
        } else if collectionView == self.moodListView {
            if let cell = collectionView.cellForItem(at: indexPath) as? MoodViewCell {
                cell.showBorderAction()
                showBackgroundImageAction()
            }
        }
    }
    
    // COLLECTION VIEW : cell deselected
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionListView {
            if let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewCell {
                cell.deselectCollectionAction()
            }
        } else if collectionView == self.moodListView {
            if let cell = collectionView.cellForItem(at: indexPath) as? MoodViewCell {
                cell.hideBorderAction()
                hideBackgroundImageAction()
            }
        }
    }
}

extension HomeViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.collectionListView {
            
            return CGSize(width: self.collectionListView.frame.height * 4/1, height: self.collectionListView.frame.height)
            
        } else if collectionView == self.moodListView {
            
            return CGSize(width: 300 * 9/16, height: 300)
        }
        fatalError()
    }
}
