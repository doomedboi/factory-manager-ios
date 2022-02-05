//
//  OrderMapViewController.swift
//  factory-manager-ios
//
//  Created by soFuckingHot on 05.02.2022.
//

import UIKit
import SDWebImage

class OrderMapViewController: UIViewController {

    
    @IBOutlet weak var icon: UIImageView!
    var imagePath = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "План раскроя"
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.bind(imagePath: self.imagePath)
    }

    func bind(imagePath: String) {
        var baseUrl = "https://sewing.mrfox131.software/"
        baseUrl += imagePath
        guard let downloadUrl = URL(string: baseUrl) else { return }
        
        self.icon.sd_setImage(with: downloadUrl, completed: nil)
    }
    
    

}
