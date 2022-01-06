//
//  OrangeButton.swift
//  factory-manager-ios
//
//  Created by soFuckingHot on 05.01.2022.
//

import UIKit

class OrangeButton : UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setStyle()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setStyle()
    }
    
    private func setStyle() {
        layer.cornerRadius = 4
        layer.backgroundColor = UIColor(red: 1, green: 0.425, blue: 0.179, alpha: 1).cgColor
        setTitleColor( .white, for: .normal)
    }
}
