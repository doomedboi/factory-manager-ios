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
    
    func bind(_ model: nomenclatureModel) {
        nameLabel.text = model.name
    }
    
}
