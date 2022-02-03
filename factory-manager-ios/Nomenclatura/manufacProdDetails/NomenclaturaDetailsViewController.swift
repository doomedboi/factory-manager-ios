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
    @IBOutlet weak var listOfTkanei: UILabel!
    @IBOutlet weak var listOfFurnitura: UILabel!
    @IBOutlet weak var listOfChanges: UITableView!
    @IBOutlet weak var scrollContentView: UIView!
    
    var localModal: ProductModel?
    
    var previousStates: [ProductModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.listOfChanges.reloadData()
            }
        }
        
    }
    
    func initTable() {
        listOfChanges.dataSource = self
        listOfChanges.delegate = self
        listOfChanges.register(UINib(nibName: "ChangesTableViewCell", bundle: nil), forCellReuseIdentifier: "ChangesTableViewCell")
        listOfChanges.register(UINib(nibName: "ItemDescriptionViewCell", bundle: nil), forCellReuseIdentifier: "ItemDescriptionViewCell")
        listOfChanges.register(UINib(nibName: "HistoryViewCell", bundle: nil),  forCellReuseIdentifier: "HistoryViewCell")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewWithImage.layer.backgroundColor = UIColor(red: 0.933, green: 0.978, blue: 1, alpha: 1).cgColor
        viewWithImage.layer.borderWidth = 4
        viewWithImage.layer.borderColor = UIColor(red: 0.82, green: 0.933, blue: 0.988, alpha: 1).cgColor
        self.title = localModal?.name
        initTable()
        // Do any additional setup after loading the view.
        print("========")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bind(localModal!)
        
        let itemArticle = localModal?.article ?? 0
        
        DispatchQueue.main.async {
            NetworkManager.getPreviousProducts(article: itemArticle, complition:  { objects in
                print("OBJECTS IN CALLBACK")
                print(objects)
                self.previousStates = objects
            })
        }
        
        
        self.listOfChanges.reloadData()
    }
    
    func fetchClothes(model: ProductModel) -> String {
        var clothesString = ""
        for cloth in model.clothes {
            clothesString += cloth.name + "\n"
        }
        
        return clothesString
    }
    
    func fetchAccessory(model: ProductModel) -> String {
        var accessory = ""
        for access in model.accessories {
            accessory += access.name + "\n"
        }
        
        return accessory
    }
    
    func bind(_ model: ProductModel) {
        
        if let img = NetworkHelper.getFullImagePath(localPath: model.image) {
            self.productImage.sd_setImage(with: img, placeholderImage: UIImage(named: "error_i"), completed: nil)
        }
    }
}


extension NomenclaturaDetailsViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return previousStates.count + 2
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let deqCell = listOfChanges.dequeueReusableCell(withIdentifier: "ItemDescriptionViewCell", for: indexPath)
            guard let cell = deqCell as? ItemDescriptionViewCell else { return UITableViewCell() }
            cell.bind(localModal!)
            return cell
        }
        
        //  history of ch label
        if indexPath.row == 1 {
            let cell = listOfChanges.dequeueReusableCell(withIdentifier: "HistoryViewCell", for: indexPath)
            guard let upcell = cell as? HistoryViewCell else { return UITableViewCell() }
            return upcell
        }
        
        let activityData = self.previousStates[indexPath.row-2]
        print("=====")
        print(activityData)
        
        let dequeuedCell = listOfChanges.dequeueReusableCell(withIdentifier: "ChangesTableViewCell", for: indexPath)
        
        // not work without guard asks unwrap
        guard let upcastedCell = dequeuedCell as? ChangesTableViewCell
        else {
            return UITableViewCell()
        }
        
        upcastedCell.bind(activityData)
        
        return upcastedCell
    }
}

extension NomenclaturaDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1 {
            return 60.0
        } else {
            return tableView.rowHeight
        }
    }
}

