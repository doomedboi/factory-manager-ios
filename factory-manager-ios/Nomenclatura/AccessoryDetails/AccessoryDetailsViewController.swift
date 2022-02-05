//
//  AccessoryDetailsViewController.swift
//  factory-manager-ios
//
//  Created by soFuckingHot on 14.01.2022.
//

import UIKit

class AccessoryDetailsViewController: UIViewController {

    var model: AccessoryModel?
    
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var headerImage: UIImageView!
    
    
    @IBOutlet weak var articleLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var lenLabel: UILabel!
    @IBOutlet weak var widthLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var amounLabel: UILabel!
    
    @IBOutlet weak var amountTextField: UITextField!
    
    @IBOutlet weak var kgAcceptSwitcher: UISegmentedControl!
    
    private var selectedIndex: Int = 1
    
    private func causeAlert() {
        let alert = UIAlertController(title: "Проверьте поля", message: "Количество не может быть меньше или равно нулю!",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Повторить попытку", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func didSpisatTap(_ sender: Any) {
        guard let quanity = amountTextField.text else { return }
        //  Decommission in kg
        if selectedIndex == 0 {
            
            guard let qDouble = Double(quanity) else {
               causeAlert()
                return
            }
            
            if qDouble <= 0 {
                causeAlert()
                return
            }
            
            DispatchQueue.main.async {
                NetworkManager.accessoryInKg(article: self.model!.article, amount: qDouble, complition: {
                    status in
                    if status == true {
                        self.updateAmount()
                    }
                })
            }
        } else {
            guard let qInt = Int(quanity) else { return } //  ALERT
            DispatchQueue.main.async {
                NetworkManager.accessoryDecommission(article: self.model!.article, quanity: qInt, complition: { status in
                    if status == true {
                        self.updateAmount()
                    }
                })
            }
        }
    }
    
    @objc func decommishHandler(_ sender: UISegmentedControl) {
        decommish(index: self.kgAcceptSwitcher.selectedSegmentIndex)
    }
    
    private func decommish(index: Int) {
        selectedIndex = index
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerView.layer.backgroundColor = UIColor(red: 0.933, green: 0.978, blue: 1, alpha: 1).cgColor
        headerView.layer.borderWidth = 4
        headerView.layer.borderColor = UIColor(red: 0.82, green: 0.933, blue: 0.988, alpha: 1).cgColor
        self.title = model?.name
        if model?.kgAcceptable != true {
            self.kgAcceptSwitcher.isHidden = true
        }
        self.kgAcceptSwitcher.addTarget(self, action: #selector(decommishHandler(_:)), for: .valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.kgAcceptSwitcher.selectedSegmentIndex = 1
        
        bind(model!)
    }
    
    private func updateAmount() {
        DispatchQueue.main.async {
            NetworkManager.getAccessoryAmount(article: self.model!.article, complition: { response in
                self.updateVisualAmount(amount: response.amount!)
            })
        }
    }
    
    private func updateVisualAmount(amount: Int) {
        DispatchQueue.main.async {
            self.amounLabel.text = String(describing: amount)
        }
    }
    func bind(_ model: AccessoryModel) {
        if let img = NetworkHelper.getFullImagePath(localPath: model.image) {
            self.headerImage.sd_setImage(with: img, completed: nil)
        }
        
        let weight = model.weight ?? 0
        
        let weightStr =
            (model.kgAcceptable == false) ? String(describing: Int(weight)) + "кг" : String(describing: weight) + "кг"
        
        var amount = 0
        updateAmount()
        
        articleLabel.text = String(describing: model.article)
        typeLabel.text = model.type
        lenLabel.text = String(describing: model.length)
        widthLabel.text = String(describing: model.width)
        weightLabel.text = weightStr
        countLabel.text = String(describing: model.price)

        print(model)
    }
    
    

}
