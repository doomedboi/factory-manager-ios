//
//  DetailsViewController.swift
//  factory-manager-ios
//
//  Created by soFuckingHot on 14.01.2022.
//

import UIKit

class DetailsViewController: UIViewController {

    var model: ClothModel?
    
    @IBOutlet weak var viewWithImage: UIImageView!
    
    @IBOutlet weak var viewImageContainer: UIView!
    
    @IBOutlet weak var articleLabel: UILabel!
    
    @IBOutlet weak var colorLabel: UILabel!
    
    @IBOutlet weak var sostabLabel: UILabel!
    
    @IBOutlet weak var widthLabel: UILabel!
    
    @IBOutlet weak var costLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewImageContainer.layer.backgroundColor = UIColor(red: 0.933, green: 0.978, blue: 1, alpha: 1).cgColor
        viewImageContainer.layer.borderWidth = 4
        viewImageContainer.layer.borderColor = UIColor(red: 0.82, green: 0.933, blue: 0.988, alpha: 1).cgColor
        self.title = model?.name
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bind(model!)
        print(model)
    }
    
    func bind(_ model: ClothModel) {
        if let img = NetworkHelper.getFullImagePath(localPath: model.image) {
            self.viewWithImage.sd_setImage(with: img, completed: nil)
        }
        articleLabel.text = String(describing: model.article)
        colorLabel.text = String(describing: model.color)
        sostabLabel.text = model.composition
        widthLabel.text = String(describing: model.width)
        costLabel.text = String(describing: model.price)
        
    }
    


}
