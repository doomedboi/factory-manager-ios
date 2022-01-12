//
//  ProfileViewController.swift
//  factory-manager-ios
//
//  Created by soFuckingHot on 07.01.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var lastNameLabel: UILabel!
    
    @IBOutlet weak var middleNameLabel: UILabel!
    
    @IBOutlet weak var firstNameLabel: UILabel!
    
    
    @IBAction func exitAccountDidTap(_ sender: Any) {
        
        CoreDataManager.shared.removeToken()
        
        //  move to login screen
        let vc = LoginViewController(nibName: "LoginViewController", bundle: nil)
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true, completion: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NetworkManager.me() { responseObject in
        
            let splitName: [String] = responseObject.name.components(separatedBy: " ")
            print(splitName)
            
            let namesCount = splitName.count
            if namesCount == 0 {
                return
            }
            
            //  unpack data
            DispatchQueue.main.async {
            self.lastNameLabel.text = splitName[0] ?? ""
            self.middleNameLabel.text = namesCount > 1 ? splitName[1] : ""
            self.firstNameLabel.text =  namesCount > 2 ? splitName[2] : ""
            }
            
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selfInit()
        
    }
    
    private func selfInit() {
        self.title = "Профиль"
    }

}
