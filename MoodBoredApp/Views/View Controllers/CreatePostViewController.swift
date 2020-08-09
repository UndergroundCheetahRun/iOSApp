//
//  CreatePostViewController.swift
//  MoodBoredApp
//
//  Created by Marc Meinhardt on 07.08.20.
//  Copyright © 2020 Marc Meinhardt. All rights reserved.
//

import UIKit

class CreatePostViewController: UIViewController {

    var cancelButton    = UIButton()
    var saveButton      = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
//        configureTabBar()
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = "Create"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        configureTabBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureTabBar()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func configureTabBar() {
        self.tabBarController?.tabBar.isHidden = true
    }

    func configureView() {
        view.backgroundColor = .gray
        configureBackButton()
        configureSaveButton()
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
    
    func configureSaveButton() {
        view.addSubview(saveButton)
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
        saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        saveButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        saveButton.backgroundColor = .green
        saveButton.addTarget(self, action: #selector(saveAction), for: UIControl.Event.touchUpInside)
    }
    
    // ACTION :
    
    @objc func cancelAction(sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    @objc func saveAction(sender: UIButton) {
        let view = LibraryViewController()
        self.navigationController?.pushViewController(view, animated: true)
        dismiss(animated: true, completion: nil)
    }
}
