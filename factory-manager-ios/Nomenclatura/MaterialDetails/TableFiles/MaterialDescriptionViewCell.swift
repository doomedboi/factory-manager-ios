//
//  MaterialDescriptionViewCell.swift
//  factory-manager-ios
//
//  Created by soFuckingHot on 03.02.2022.
//

import UIKit

class MaterialDescriptionViewCell: UITableViewCell {

    
    @IBOutlet weak var articleLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var sostavLabel: UILabel!
    @IBOutlet weak var widthLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bind(model: ClothModel) {
        self.articleLabel.text = String(describing: model.article)
        self.colorLabel.text = model.color
        self.sostavLabel.text = model.composition
        self.widthLabel.text = String(describing: model.width)
        self.priceLabel.text = String(describing: model.price)
    }
    
}
