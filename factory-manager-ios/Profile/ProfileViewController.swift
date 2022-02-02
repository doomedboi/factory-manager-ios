//
//  ProfileViewController.swift
//  factory-manager-ios
//
//  Created by soFuckingHot on 07.01.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    
    @IBOutlet weak var lastName: UILabel!
    
    @IBOutlet weak var middleNameLabel: UILabel!
    
    @IBOutlet weak var firstNameLabel: UILabel!
    
    @IBOutlet weak var typeOfAccountLabel: UILabel!
    
    let roles = [1: "Заказчик",
                 2: "Менеджер",
                 3: "Кладовщик",
                 4: "Швея",
                 5: "Директор"
    ]
    
    @IBAction func exitAccountDidTap(_ sender: Any) {
        
        CoreDataManager.shared.removeToken()
        
        //  move to login screen
        let vc = LoginViewController(nibName: "LoginViewController", bundle: nil)
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true, completion: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NetworkManager.me() { responseObject in
        
            let splitName: [String] = responseObject.name.components(separatedBy: " ")
            print(splitName)
            print("=====")
            
            let namesCount = splitName.count
            if namesCount == 0 {
                return
            }
            
            //  unpack data
            DispatchQueue.main.async {
            self.lastName.text = splitName[0] ?? ""
            self.middleNameLabel.text = namesCount > 1 ? splitName[1] : ""
            self.firstNameLabel.text =  namesCount > 2 ? splitName[2] : ""
                self.typeOfAccountLabel.text = self.roles[ responseObject.role]
            }
            
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selfInit()
        
    }
    
    @IBOutlet weak var contentView: UIView!
    
    private func selfInit() {
        self.title = "Профиль"
        self.contentView.backgroundColor = UIColor(named: "backgroundColor")
        
    }

}
