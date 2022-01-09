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
        nomenclatureNC.tabBarItem.image = UIImage(systemName: "circle")
        
        
        ordersNC.tabBarItem.title = "orders"
        ordersNC.tabBarItem.image = UIImage(systemName: "circle")
        
        
        profileNC.tabBarItem.title = "profile"
        profileNC.tabBarItem.image = UIImage(systemName: "circle")

        self.setViewControllers([nomenclatureNC, ordersNC, profileNC], animated: true)
        modalPresentationStyle = .overFullScreen
        print("KEEEK")
    }
}

