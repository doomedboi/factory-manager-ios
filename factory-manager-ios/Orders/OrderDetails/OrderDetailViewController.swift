//
//  OrderDetailViewController.swift
//  factory-manager-ios
//
//  Created by soFuckingHot on 14.01.2022.
//

import UIKit

class OrderDetailViewController: UIViewController {

    var model: OrderModel?
    
    @IBOutlet weak var numberLabel: UILabel!
    
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = String(describing: model?.id)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bind(model!)
    }
    
    func bind(_ model: OrderModel) {
        numberLabel.text = String(describing: model.id!)
        dataLabel.text = model.creation_date
        priceLabel.text = String(describing: model.cost)
        statusLabel.text = orderStages[model.stage ?? 0]
    }
    

}
