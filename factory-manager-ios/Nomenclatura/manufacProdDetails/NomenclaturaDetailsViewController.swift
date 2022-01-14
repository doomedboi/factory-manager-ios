//
//  NomenclaturaDetailsViewController.swift
//  factory-manager-ios
//
//  Created by soFuckingHot on 12.01.2022.
//

import UIKit

class NomenclaturaDetailsViewController: UIViewController {

    
    @IBOutlet weak var viewWithImage: UIView!
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var articleLabel: UILabel!
    @IBOutlet weak var longDurationLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    var model: ProductModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewWithImage.layer.backgroundColor = UIColor(red: 0.933, green: 0.978, blue: 1, alpha: 1).cgColor
        viewWithImage.layer.borderWidth = 4
        viewWithImage.layer.borderColor = UIColor(red: 0.82, green: 0.933, blue: 0.988, alpha: 1).cgColor
        self.title = model?.name
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bind(model!)
    }
    
    func bind(_ model: ProductModel) {
        
        if let img = NetworkHelper.getFullImagePath(localPath: model.image) {
            self.productImage.sd_setImage(with: img, completed: nil)
        }
        articleLabel.text = String(describing: model.article)
        longDurationLabel.text = String(describing: model.length)
        weightLabel.text = String(describing: model.width)
        
    }
    

}
