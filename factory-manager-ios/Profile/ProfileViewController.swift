//
//  ProfileViewController.swift
//  factory-manager-ios
//
//  Created by soFuckingHot on 07.01.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBAction func exitAccountDidTap(_ sender: Any) {
        CoreDataManager.shared.removeToken()
        
        //  move to login screen
        let vc = LoginViewController(nibName: "LoginViewController", bundle: nil)
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true, completion: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        selfInit()
        // Do any additional setup after loading the view.
    }
    
    private func selfInit() {
        self.title = "Профиль"
    }

}
