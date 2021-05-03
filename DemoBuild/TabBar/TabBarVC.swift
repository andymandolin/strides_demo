//
//  TabBarVC.swift
//  DemoBuild
//
//  Created by Andy Geipel on 5/1/21.
//

import UIKit

class TabBarVC: UITabBarController {
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearanceAndAttributes()
    }
    
    // MARK: - UI Customization
    
    private func setupAppearanceAndAttributes() {
        let appearance = UITabBarItem.appearance()
        let attributes = [NSAttributedString.Key.font:UIFont(name: Constants().pokemonFont, size: 14)]
        appearance.setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)
        UITabBar.appearance().tintColor = UIColor(red: 102/255, green: 224/255, blue: 185/255, alpha: 1.0)
        UITabBar.appearance().unselectedItemTintColor = .white
    }
}
