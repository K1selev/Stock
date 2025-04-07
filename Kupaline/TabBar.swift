//
//  TabBar.swift
//  Kupaline
//
//  Created by Сергей Киселев on 01.03.2025.
//

import UIKit

class TabBar: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeVC = HomeViewController()
        let profitVC = ProfitViewController()
        let quotesVC = QuotesViewController()
        let bankVC = BankViewController()
        let settingsVC = SettingsViewController()
        
        homeVC.tabBarItem = UITabBarItem(title: "Home",
                                          image: UIImage(named: "tabbar_home_disactive"),
                                         selectedImage: UIImage(named: "tabbar_home_active"))
        profitVC.tabBarItem = UITabBarItem(title: "Profit",
                                        image: UIImage(named: "tabbar_profit_disactive"),
                                        selectedImage: UIImage(named: "tabbar_profit_active"))
        quotesVC.tabBarItem = UITabBarItem(title: "Quotes",
                                        image: UIImage(named: "tabbar_quotes_disactive"),
                                        selectedImage: UIImage(named: "tabbar_quotes_active"))
        bankVC.tabBarItem = UITabBarItem(title: "Bank",
                                            image: UIImage(named: "tabbar_bank_disactive"),
                                            selectedImage: UIImage(named: "tabbar_bank_active"))
        settingsVC.tabBarItem = UITabBarItem(title: "Settings",
            image: UIImage(named: "tabbar_settings_disactive"),
            selectedImage: UIImage(named: "tabbar_settings_active"))
        
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .gray
        tabBar.backgroundColor = UIColor(named: "customBlack")
        tabBar.layer.cornerRadius = 12
        viewControllers = [homeVC, profitVC, quotesVC, bankVC, settingsVC]
        selectedIndex = 0
    }
}
