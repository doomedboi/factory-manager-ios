//
//  HistoryViewCell.swift
//  factory-manager-ios
//
//  Created by soFuckingHot on 02.02.2022.
//

import UIKit

class HistoryViewCell: UITableViewCell {

    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bind(_ title: String) {
        self.titleLabel.text = title
    }
    
}
