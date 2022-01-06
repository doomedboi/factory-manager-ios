//
//  LoginViewController.swift
//  factory-manager-ios
//
//  Created by soFuckingHot on 05.01.2022.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var topLabelConstr: NSLayoutConstraint!
    
    @IBOutlet weak var welcomeTitle: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        topLabelConstr.constant = UIScreen.main.bounds.width * 0.4
        var multiplayer = 1.0
        if UIScreen.main.bounds.height < 570 {
            multiplayer = 0.04
        } else {
            multiplayer = 0.065
        }
        print(multiplayer)
        welcomeTitle.font = welcomeTitle.font.withSize(UIScreen.main.bounds.height * multiplayer)
        
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
