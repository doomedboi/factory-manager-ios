//
//  NomenclaturaTableViewCell.swift
//  factory-manager-ios
//
//  Created by soFuckingHot on 07.01.2022.
//

import UIKit

struct nomenclatureModel {
    let icon: UIImage
    let name: String
    let article: String
}

class NomenclaturaTableViewCell: UITableViewCell {
        
    @IBOutlet weak var designView: UIView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var articleLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        self.selectionStyle = .none
        
        designView.backgroundColor = .orange
        designView.layer.masksToBounds = true
        
    }

    override func layoutSubviews() {
          super.layoutSubviews()
          //set the values for top,left,bottom,right margins
          let margins = UIEdgeInsets(top: 5, left: 8, bottom: 5, right: 8)
          contentView.frame = contentView.frame.inset(by: margins)
          contentView.layer.cornerRadius = 8
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setOutlets(name: String, article: String) {
        nameLabel.text = name
        articleLabel.text = article
    }
    
    //  Generic come on but later
    func bindCloth(_ model: ClothModel) {
        self.setOutlets(name: model.name, article: String(model.article))
    }
    
    func bindAccessory(_ model: AccessoryModel) {
        self.setOutlets(name: model.name, article: String(model.article))
    }
    
    func bindProduct(_ model: ProductModel) {
        self.setOutlets(name: model.name, article: String(model.article))
    }
}
