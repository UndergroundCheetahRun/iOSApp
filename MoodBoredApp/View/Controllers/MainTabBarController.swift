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
        static let home = "Home"
        static let feed = "Feed"
    }
    
    struct imageNames {
        static let circle  = "circle32"
        static let home    = "ICON_DOCK_UNHIGHLIGHTED_House_x2"
        static let feed    = "ICON_DOCK_UNHIGHLIGHTED_Feed_x2"
        static let selectedHome    = "ICON_DOCK_HIGHLIGHTED_House_x2"
        static let selectedFeed    = "ICON_DOCK_HIGHLIGHTED_Feed_x2"
    }
    
    // VIEW DID LOAD :
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [
            createController(title: viewTitles.home, imageName: imageNames.home, selectedImage: imageNames.selectedHome, vc: HomeVc),
            createController(title: viewTitles.feed, imageName: imageNames.feed, selectedImage: imageNames.selectedFeed, vc: FeedVc),
        ]
    }
    
}


extension MainTabBarController {
    
    private func createController(title: String, imageName: String, selectedImage: String, vc: UIViewController) -> UINavigationController {
        let recentVc = UINavigationController(rootViewController: vc)
        recentVc.tabBarItem.title = title
        recentVc.tabBarItem.image = UIImage(named: imageName)
        recentVc.tabBarItem.selectedImage = UIImage(named: selectedImage)
        return recentVc
    }
}
