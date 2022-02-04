//
//  ChangesTableViewCell.swift
//  factory-manager-ios
//
//  Created by soFuckingHot on 01.02.2022.
//

import UIKit

class ChangesTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lenghtLabel: UILabel!
    
    @IBOutlet weak var widhtLabel: UILabel!
    
    @IBOutlet weak var tkaniList: UILabel!
    
    @IBOutlet weak var furnituraList: UILabel!
    
    
    @IBOutlet weak var contentVie: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentVie.layer.cornerRadius = 5
        self.contentVie.layer.borderWidth = 5
        self.contentVie.layer.borderColor = UIColor(named: "backgroundColor")?.cgColor
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bind(_ model: ProductModel) {
        self.lenghtLabel.text = String(describing: model.length)
        self.widhtLabel.text =  String(describing: model.width)
        self.tkaniList.text = fetchClothes(model: model)
        self.furnituraList.text = fetchAccessory(model: model)
        
        print("hththth")
    }
    
}

extension ChangesTableViewCell {
    func fetchClothes(model: ProductModel) -> String {
        var clothesString = ""
        for cloth in model.clothes {
            clothesString += cloth.name + "\n"
        }
        
        return clothesString
    }
    
    func fetchAccessory(model: ProductModel) -> String {
        var accessory = ""
        for access in model.accessories {
            accessory += access.name + "\n"
        }
        
        return accessory
    }
}
