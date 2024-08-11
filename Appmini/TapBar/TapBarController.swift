//
//  TapBarController.swift
//  Appmini
//
//  Created by Woo on 8/11/24.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let controllers = TabBarItem.allCases.map { $0.viewController }
        setViewControllers(controllers, animated: true)
        
        tabBar.tintColor = .blue
        tabBar.unselectedItemTintColor = .gray
    }
}
