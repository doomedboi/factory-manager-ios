//
//  OrdersTableViewCell.swift
//  factory-manager-ios
//
//  Created by soFuckingHot on 09.01.2022.
//

import UIKit

struct orderModel {
    let number: String
    let customer: String
    let status: String
}

class OrdersTableViewCell: UITableViewCell {

    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var customerLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var designView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
        self.backgroundColor = .clear
        
        designView.backgroundColor = .orange
        designView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    override func layoutSubviews() {
          super.layoutSubviews()
          //set the values for top,left,bottom,right margins
          let margins = UIEdgeInsets(top: 5, left: 8, bottom: 5, right: 8)
          contentView.frame = contentView.frame.inset(by: margins)
          contentView.layer.cornerRadius = 8
    }
    
    func bind(_ model: orderModel) {
        numberLabel.text = model.number
        customerLabel.text = model.customer
        statusLabel.text = model.status
    }
    
}
