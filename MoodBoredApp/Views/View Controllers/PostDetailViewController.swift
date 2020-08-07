//
//  PostDetailViewController.swift
//  MoodBoredApp
//
//  Created by Marc Meinhardt on 08.08.20.
//  Copyright © 2020 Marc Meinhardt. All rights reserved.
//

import UIKit

class PostDetailViewController: UIViewController {

        var dismissButton    = UIButton()
        var saveButton      = UIButton()
        
        override func viewDidLoad() {
            super.viewDidLoad()

            configureView()
    //        configureTabBar()
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
            configureDismissButton()
        }
        
        func configureDismissButton() {
            view.addSubview(dismissButton)
            
            dismissButton.translatesAutoresizingMaskIntoConstraints = false
            dismissButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
            dismissButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
            dismissButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
            dismissButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
            
            dismissButton.backgroundColor = .magenta
            dismissButton.addTarget(self, action: #selector(dismissAction), for: UIControl.Event.touchUpInside)
        }
        
        // ACTION :
        
        @objc func dismissAction(sender: UIButton) {
            dismiss(animated: true, completion: nil)
        }
    }
