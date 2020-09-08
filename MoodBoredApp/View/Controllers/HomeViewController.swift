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
    
    var collectionDataArray = ["Flakey Feelings", "Paddy Paper", "Coming Soon"]
    var moodDataArray = ["Mad\nRed", "Chill\nOrange", "Happy\nYellow", "Disgusted\nGreen", "Sad\nBlue", "Scared\nPurple", "Loved\nPink", "Empty\nGray"]
    
    // PROPERTIES :
    
    let backgroundImage = UIButton()
    let backgroundImageButton = UIButton()
    var backgroundImageIsHidden = false
    
    let containerView       = UIView()
    let replyContainerView  = UIView()
    var adBannerView        = UIView()
    var replyLabel          = ReplyLabel()
    var collectionLabel     = UILabel()
    var moodLabel           = UILabel()
    
    let tableView           = UITableView()
    
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
    
    // VIEW DID LOAD:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    // VIEW WILL APPEAR :
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    // VIEW WILL DISAPPEAR :
    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
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
        configureMoodsViews()
        configureMoodsLabel()
        configureCollectionsViews()
        configureCollectionsLabel()
        configureReplyContainerView()
        configureReplyLabel()
    }
    
    // NAVIGATION BAR :
    
    func configureNavigationBar() {
        navigationController?.navigationBar.isHidden = true
        navigationItem.title = "Home"
        navigationController?.navigationBar.isTranslucent = false
        
        tabBarController?.tabBar.isTranslucent = false
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
    
    // SCROLL VIEW : using a tableview
    
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
    
    // REPLIES CONTAINER VIEW :
    
    func configureReplyContainerView() {
        
        containerView.addSubview(replyContainerView)
        
        replyContainerView.translatesAutoresizingMaskIntoConstraints = false
        replyContainerView.topAnchor.constraint(equalTo: adBannerView.bottomAnchor, constant: 0).isActive = true
        replyContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        replyContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        replyContainerView.bottomAnchor.constraint(equalTo: collectionLabel.topAnchor, constant: 0).isActive = true
        
        replyContainerView.backgroundColor = .clear
        
        var tapGesture : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideBackgroundImageAction))
        tapGesture.numberOfTapsRequired = 1
        replyContainerView.addGestureRecognizer(tapGesture)
    }
    
    // REPLIES :
    
    func configureReplyLabel() {
        replyContainerView.addSubview(replyLabel)
        
        replyLabel.translatesAutoresizingMaskIntoConstraints = false
        replyLabel.centerYAnchor.constraint(equalTo: replyContainerView.centerYAnchor).isActive = true
        replyLabel.centerXAnchor.constraint(equalTo: replyContainerView.centerXAnchor).isActive = true
        replyLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 55).isActive = true
        replyLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 70).isActive = true
        replyLabel.widthAnchor.constraint(lessThanOrEqualToConstant: view.frame.width * 0.85).isActive = true
        
        replyLabel.backgroundColor      = UIColor(white: 0.4, alpha: 0.5)
        replyLabel.text                 = "It happens sometimes.           \nWanna talk about it ?"
        replyLabel.clipsToBounds        = true
        replyLabel.textAlignment        = .center
        replyLabel.layer.cornerRadius   = 20
        replyLabel.numberOfLines        = 2
        replyLabel.textColor            = .white
        replyLabel.font                 = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.medium)
    }
    
    // LABELS :
    
    func configureCollectionsLabel() {
        
        containerView.addSubview(collectionLabel)

        collectionLabel.translatesAutoresizingMaskIntoConstraints = false
        collectionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        collectionLabel.bottomAnchor.constraint(equalTo: collectionListView.topAnchor, constant: -10).isActive = true
        collectionLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -10).isActive = true

        collectionLabel.backgroundColor = .clear
        collectionLabel.text = "Collections"
        collectionLabel.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.bold)
        collectionLabel.alpha = 0.45
    }
    
    func configureMoodsLabel() {
        containerView.addSubview(moodLabel)
        
        moodLabel.translatesAutoresizingMaskIntoConstraints = false
        moodLabel.bottomAnchor.constraint(equalTo: moodListView.topAnchor, constant: -10).isActive = true
        moodLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        moodLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -10).isActive = true
        
        moodLabel.backgroundColor = .clear
        moodLabel.text = "Moods"
        moodLabel.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.bold)
        moodLabel.alpha = 0.45
    }
    
    // COLLECTION VIEWS :
    
    func configureCollectionsViews() {
        containerView.addSubview(collectionListView)
        
        setCollectionListViewDelegates()
        
        collectionListView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
        
        collectionListView.translatesAutoresizingMaskIntoConstraints = false
        collectionListView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        collectionListView.bottomAnchor.constraint(equalTo: moodLabel.topAnchor, constant: -20).isActive = true
        collectionListView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        collectionListView.heightAnchor.constraint(equalToConstant: view.frame.height * 0.05 ).isActive = true

        collectionListView.backgroundColor = .clear
        collectionListView.showsHorizontalScrollIndicator = false
        collectionListView.allowsMultipleSelection = false
    }
    
    func configureMoodsViews() {
        containerView.addSubview(moodListView)
        
        setMoodListViewDelegates()
        
        moodListView.register(MoodViewCell.self, forCellWithReuseIdentifier: "MoodCellId")
        
        moodListView.translatesAutoresizingMaskIntoConstraints = false
        moodListView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        moodListView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        moodListView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -32).isActive = true
        moodListView.heightAnchor.constraint(equalToConstant: view.frame.height * 0.45 ).isActive = true
        
        moodListView.backgroundColor = .clear
        moodListView.showsHorizontalScrollIndicator = false
        moodListView.allowsMultipleSelection = false
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

    func didDoubleTapCollectionView(gesture: UITapGestureRecognizer) {

    }
    
    func showBackgroundImageAction() {
        backgroundImage.alpha = 1
        backgroundImageIsHidden = false
    }
    
    @objc func hideBackgroundImageAction() {
        backgroundImage.alpha = 0
        backgroundImageIsHidden = true
        
        print(self.moodListView.indexPathsForSelectedItems?.first as Any)
        let indexPath = self.moodListView.indexPathsForSelectedItems?.first
        
        
//        if let indexPath = self.moodListView.indexPathsForSelectedItems {
//        let selectedCells = self.moodListView.cellForItem(at: indexPath)
//
//        if let collectionView = moodListView {
//
//        }
//            let indexPath = collectionView.indexPathsForSelectedItems?.first,
//            let cell = collectionView.cellForItem(at: indexPath) as? TestCell,
//            let data = cell.data {
//                    print(data)
//        }
    }
    
    func selectAction() {
        showBackgroundImageAction()
    }
    
    @objc func confirmAction(_ gesture: UITapGestureRecognizer) {
        let view = CreatePostViewController()
        
        view.modalPresentationStyle = .fullScreen
        self.navigationController?.present(view, animated: true, completion: nil)
    }
    
    func deselectMoodAction() {
        
    }
}

// COLLECTION VIEWS : datasource, flow layout

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionListView {
            
            return collectionDataArray.count
            
        } else if collectionView == self.moodListView {
            
            return moodDataArray.count
            
        }
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.collectionListView {
            let collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! CollectionViewCell
            collectionViewCell.textLabel.text = "\(collectionDataArray[indexPath.row])"
            return collectionViewCell
            
        } else if collectionView == self.moodListView {
            let moodViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoodCellId", for: indexPath) as! MoodViewCell
            moodViewCell.textLabel.text = moodDataArray[indexPath.row]
            return moodViewCell
        }
        fatalError()
    }
}

extension HomeViewController : UICollectionViewDelegate {
    
    // COLLECTION VIEW : cell highlighted
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        if collectionView == self.collectionListView {
            if let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewCell {
                cell.selectCollectionAction()
            }
        } else if collectionView == self.moodListView {
            if let cell = collectionView.cellForItem(at: indexPath) as? MoodViewCell {
                if cell.isHighlighted == true {
                    selectAction()
                }
            }
        }
    }
    
    // COLLECTION VIEW : cell unhighlighted
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        if collectionView == self.collectionListView {
            
        } else if collectionView == self.moodListView {
            if let cell = collectionView.cellForItem(at: indexPath) as? MoodViewCell {
                cell.hideBorderAction()
                if cell.isHighlighted == true {
                    cell.moodIsSelected = false
                } else {
                    cell.moodIsSelected = false
                }
            }
        }
    }

    // COLLECTION VIEW : cell selected
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionListView {

        } else if collectionView == self.moodListView {
            if let cell = collectionView.cellForItem(at: indexPath) as? MoodViewCell {
                cell.showBorderAction()
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
            }
        }
    }
}

extension HomeViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.collectionListView {
            
            return CGSize(width: self.collectionListView.frame.height * 5.5, height: self.collectionListView.frame.height)
            
        } else if collectionView == self.moodListView {
            
            return CGSize(width: collectionView.frame.height * 9/16, height: collectionView.frame.height)
        }
        fatalError()
    }
}

