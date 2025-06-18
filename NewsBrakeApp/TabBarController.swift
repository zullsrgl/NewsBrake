//
//  TabBarController.swift
//  NewsBrakeApp
//
//  Created by Zülal Sarıoğlu on 11.06.2025.
//

import PureLayout

class TabBarController: UITabBarController {
    
    let homeVC = HomeViewController()
    let searchVC = SearchViewController()
    let favoritesVC = FavoritesViewController()
    let appearance = UITabBarAppearance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = .systemBackground
        appearance.backgroundEffect = UIBlurEffect(style: .light)
        appearance.stackedLayoutAppearance.selected.iconColor = .systemPurple
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.systemPurple]
        appearance.stackedLayoutAppearance.normal.iconColor = .gray
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.gray]
        tabBar.standardAppearance = appearance
        
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        }
        configureTabs()
    }
    
    func configureTabs() {
        
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 4)
        searchVC.tabBarItem = UITabBarItem(title: "search", image: UIImage(systemName: "magnifyingglass"), tag: 2)
        favoritesVC.tabBarItem = UITabBarItem(title: "favorites", image: UIImage(systemName: "heart"), tag: 3)
        
        let homeNav = UINavigationController(rootViewController: homeVC)
        let searchNav = UINavigationController(rootViewController: searchVC)
        let favNav = UINavigationController(rootViewController: favoritesVC)
        viewControllers = [homeNav, searchNav, favNav]
    }
    
}
