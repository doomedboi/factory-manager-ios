//
//  LoginViewController.swift
//  factory-manager-ios
//
//  Created by soFuckingHot on 05.01.2022.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var topLabelConstr: NSLayoutConstraint!
    
    
    @IBOutlet weak var loginTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
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
        
        self.loginTextField.delegate = self
        self.passwordTextField.delegate = self
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        loginTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }

    @IBAction func didLoginBtnTap(_ sender: Any) {
        let login = loginTextField.text ?? ""
        let passw = passwordTextField.text ?? ""
        
        let encoder = JSONEncoder()
        let body = userLoginBody(login: login, password: passw)
        
        print("here")
        do {
            let reqBody = try encoder.encode(body)
                    let queue = DispatchQueue.global(qos: .utility)
            NetworkManager.login(reqBody) { user in
                        queue.async {
                            print(user.accessToken)
                            UserDefaults.standard.set(user.accessToken , forKey: CoreDataManager.shared.kUserTokenKey)
                        }
                        DispatchQueue.main.async {
                            let vc = TabbarViewController(nibName: "TabbarViewController", bundle: nil)
                            vc.modalPresentationStyle = .overFullScreen
                            self.present(vc, animated: true, completion: nil)
                        }
                    } onError: { err in
                        DispatchQueue.main.async {
                            let alertText = NetworkHelper.getApiErrors(errors: err.errors)
                            let alert = UIAlertController(title: "Проверьте поля", message: alertText, preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Повторить попытку", style: .cancel, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                            
                        }
                    }
                } catch {
                    print(error)
                }
        
    }
    
    

}
