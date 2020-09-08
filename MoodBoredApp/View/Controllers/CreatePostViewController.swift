//
//  CreatePostViewController.swift
//  MoodBoredApp
//
//  Created by Marc Meinhardt on 07.08.20.
//  Copyright © 2020 Marc Meinhardt. All rights reserved.
//

import UIKit

class CreatePostViewController: UIViewController {
    
    var currentDate     = Date()
    var dateLabel       = UILabel()
    var textField       = UITextField()
    var cancelButton    = UIButton()
    var savePostButton  = UIButton()
    var stickersButton  = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        configureNavBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {

    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func configureNavBar() {
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = "Create"
        
        tabBarController?.tabBar.isTranslucent = false
    }

    func configureView() {
        view.backgroundColor = .gray
        configureBackButton()
        configureStickerButton()
        configureDateLabel()
        configureSaveButton()
    }
    
    func configureDateLabel() {
        view.addSubview(dateLabel)
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.topAnchor.constraint(equalTo: cancelButton.bottomAnchor, constant: 4).isActive = true
        dateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        dateLabel.backgroundColor = .yellow
        dateLabel.text = "Date Label goes here"
    }
    
    func configureBackButton() {
        view.addSubview(cancelButton)
        
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        cancelButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        cancelButton.backgroundColor = .magenta
        cancelButton.addTarget(self, action: #selector(cancelAction), for: UIControl.Event.touchUpInside)
    }
    
    func configureStickerButton() {
        view.addSubview(stickersButton)
        
        stickersButton.translatesAutoresizingMaskIntoConstraints = false
        stickersButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        stickersButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        stickersButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        stickersButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        stickersButton.backgroundColor = .magenta
        stickersButton.addTarget(self, action: #selector(cancelAction), for: UIControl.Event.touchUpInside)
    }
    
    func configureSaveButton() {
        view.addSubview(savePostButton)
        
        savePostButton.translatesAutoresizingMaskIntoConstraints = false
        savePostButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
        savePostButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        savePostButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        savePostButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        savePostButton.backgroundColor = .green
        savePostButton.addTarget(self, action: #selector(saveAction), for: UIControl.Event.touchUpInside)
    }
    
    // ACTION :
    
    @objc func cancelAction(sender: UIButton) {
        //self.navigationController?.popToRootViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    
    
    @objc func saveAction(sender: UIButton) {
        
        print ("> save pressed")
        
        print(presentingViewController ?? "returned nil")
        
        if let tabBar = presentingViewController as? UITabBarController {
            tabBar.selectedIndex = 1
        }

        dismiss(animated: true)
    }
    
}


