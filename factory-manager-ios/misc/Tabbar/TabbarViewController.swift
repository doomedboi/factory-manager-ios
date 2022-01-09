//
//  TabbarViewController.swift
//  factory-manager-ios
//
//  Created by soFuckingHot on 07.01.2022.
//

import UIKit

class TabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        createTabBarView()
    }
    
    private func createTabBarView() {
        //  get nav. controllers
        let nomenclatureNC = UINavigationController(rootViewController: nomenclatureViewController())
        let ordersNC = UINavigationController(rootViewController: OrdersViewController())
        let profileNC = UINavigationController(rootViewController: ProfileViewController())
        
        nomenclatureNC.tabBarItem.title = "Номенклатура"
        nomenclatureNC.tabBarItem.image = UIImage(named: "nomenclature_i")
        
        
        ordersNC.tabBarItem.title = "orders"
        ordersNC.tabBarItem.image = UIImage(named: "basket_i")
        
        
        profileNC.tabBarItem.title = "profile"
        profileNC.tabBarItem.image = UIImage(named: "profile_i")

        self.setViewControllers([nomenclatureNC, ordersNC, profileNC], animated: true)
        modalPresentationStyle = .overFullScreen
        
        self.tabBar.tintColor = .orange
    }
}

