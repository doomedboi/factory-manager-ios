//
//  ViewController.swift
//  factory-manager-ios
//
//  Created by soFuckingHot on 05.01.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        present(TabbarViewController(nibName: "TabbarViewController", bundle: nil), animated: true, completion: nil)
        
    }


    
}

