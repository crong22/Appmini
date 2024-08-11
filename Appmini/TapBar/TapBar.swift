//
//  TapBar.swift
//  Appmini
//
//  Created by Woo on 8/11/24.
//

import UIKit

enum TabBarItem: CaseIterable {
    case today, game, app, arcade, search

    var viewController : UIViewController {
        switch self {
        case .today:
            let vc = TodayViewController()
            vc.tabBarItem = UITabBarItem(title: "투데이", image: UIImage(systemName: "book"), tag: 0)
            return UINavigationController(rootViewController: vc)
        case .game:
            let vc = GameViewController()
            vc.tabBarItem = UITabBarItem(title: "게임", image: UIImage(systemName: "gamecontroller"), tag: 1)
            return UINavigationController(rootViewController: vc)
        case .app:
            let vc = APPViewController()
            vc.tabBarItem = UITabBarItem(title: "앱", image: UIImage(systemName: "square.stack.fill"), tag: 2)
            return UINavigationController(rootViewController: vc)
        case .arcade:
            let vc = ArcadeViewController()
            vc.tabBarItem = UITabBarItem(title: "아케이드", image: UIImage(systemName: "star"), tag: 3)
            return UINavigationController(rootViewController: vc)
        case .search:
            let vc = SearchViewController()
            vc.tabBarItem = UITabBarItem(title: "검색", image: UIImage(systemName: "magnifyingglass"), tag: 4)
            return UINavigationController(rootViewController: vc)
        }

    }
}
