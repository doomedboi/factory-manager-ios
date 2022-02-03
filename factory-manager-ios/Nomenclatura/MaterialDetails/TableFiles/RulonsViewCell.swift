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
    
    @IBAction func didSpisatBtnTap(_ sender: Any) {
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bind(_ model: ClothArticleModel) {
        self.numberLabel.text = String(describing: model.number)
        self.Lenght.text = String(describing: model.length)
    }
    
}
