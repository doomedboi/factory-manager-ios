//
//  AccessoryDetailsViewController.swift
//  factory-manager-ios
//
//  Created by soFuckingHot on 14.01.2022.
//

import UIKit

class AccessoryDetailsViewController: UIViewController {

    var model: AccessoryModel?
    
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var headerImage: UIImageView!
    
    
    @IBOutlet weak var articleLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var lenLabel: UILabel!
    @IBOutlet weak var widthLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerView.layer.backgroundColor = UIColor(red: 0.933, green: 0.978, blue: 1, alpha: 1).cgColor
        headerView.layer.borderWidth = 4
        headerView.layer.borderColor = UIColor(red: 0.82, green: 0.933, blue: 0.988, alpha: 1).cgColor
        self.title = model?.name
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        bind(model!)
    }
    
    func bind(_ model: AccessoryModel) {
        if let img = NetworkHelper.getFullImagePath(localPath: model.image) {
            self.headerImage.sd_setImage(with: img, completed: nil)
        }
        
        articleLabel.text = String(describing: model.article)
        typeLabel.text = model.type
        lenLabel.text = String(describing: model.length)
        widthLabel.text = String(describing: model.width)
        weightLabel.text = String(describing: model.weight)
        countLabel.text = String(describing: model.price)
        
        
    }
    
    

}
