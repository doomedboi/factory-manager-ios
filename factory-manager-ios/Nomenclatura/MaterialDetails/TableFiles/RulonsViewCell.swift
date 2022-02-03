//
//  RulonsViewCell.swift
//  factory-manager-ios
//
//  Created by soFuckingHot on 03.02.2022.
//

import UIKit

class RulonsViewCell: UITableViewCell {

    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var Lenght: UILabel!
    @IBOutlet weak var amountTextFiled: UITextField!
    var operationStatus = false
    var model: ClothArticleModel?
    private var actuallyLen = 0.0
    
    @IBAction func didSpisatBtnTap(_ sender: Any) {
        guard let amount = amountTextFiled.text else { return }
        guard let article = model?.article else { return }
        guard let number = model?.number else { return }
        
        
        DispatchQueue.main.async {
            NetworkManager.clothDecommission(article:  article, number: number, length: Double(amount)!,
                                             complition: { status in
                if status == true {
                    let newLen = (self.actuallyLen  - Double(amount)!)
                    
                    self.UpdateVisualAmount(to: newLen)
                    self.actuallyLen = newLen
                    self.operationStatus = false
                }
            })
        }
        
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    private func UpdateVisualAmount(to: Double) {
        print(to)
        DispatchQueue.main.async {
            self.Lenght.text = String(describing: to)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bind(_ model: ClothArticleModel) {
       self.numberLabel.text = String(describing: model.number)
       self.Lenght.text = String(describing: model.length)
        
        self.model = model
        self.actuallyLen = model.length
    }
    
}
