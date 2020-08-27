//
//  MainTabBarController.swift
//  MoodBoredApp
//
//  Created by Marc Meinhardt on 02.08.20.
//  Copyright © 2020 Marc Meinhardt. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    public static let mainTabBarController = MainTabBarController()
    
    private let HomeVc = HomeViewController()
    private let FeedVc = FeedViewController()

    struct viewTitles {
        static let home     = "Home"
        static let library  = "Library"
    }
    
    let circle  = "circle32"
    
    // VIEW DID LOAD :
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [
            createController(title: viewTitles.home, imageName: circle, vc: HomeVc),
            createController(title: viewTitles.library, imageName: circle, vc: FeedVc),
        ]
    }
    
}


extension MainTabBarController {
    
    private func createController(title: String, imageName: String, vc: UIViewController) -> UINavigationController {
        let recentVc = UINavigationController(rootViewController: vc)
        recentVc.tabBarItem.title = title
        recentVc.tabBarItem.image = UIImage(named: imageName)
        return recentVc
    }
}
