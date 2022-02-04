//
//  ItemDescriptionViewCell.swift
//  factory-manager-ios
//
//  Created by soFuckingHot on 02.02.2022.
//

import UIKit

class ItemDescriptionViewCell: UITableViewCell {

    
    @IBOutlet weak var articleLabel: UILabel!
    @IBOutlet weak var lenghtLabel: UILabel!
    @IBOutlet weak var width: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var listOfTkanei: UILabel!
    @IBOutlet weak var listOfFurnitura: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func bind(_ model: ProductModel) {
        articleLabel.text = String(describing: model.article)
        lenghtLabel.text = String(describing: model.length)
        width.text = String(describing: model.width)
        sizeLabel.text = String(describing: model.size)
        listOfTkanei.text = fetchClothes(model: model)
        listOfFurnitura.text = fetchAccessory(model: model)
        descriptionLabel.text = model.comment
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension ItemDescriptionViewCell {
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
