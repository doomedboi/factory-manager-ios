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
    
    @IBOutlet weak var detailsTable: UITableView!
    
    
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
    
    
    private func initTable() {
        self.detailsTable.delegate = self
        self.detailsTable.dataSource = self
        self.detailsTable.register(UINib(nibName: "RulonsViewCell", bundle: nil), forCellReuseIdentifier: "RulonsViewCell")
    }
    
    func bind(_ model: ClothModel) {
        if let img = NetworkHelper.getFullImagePath(localPath: model.image) {
            self.viewWithImage.sd_setImage(with: img, completed: nil)
        }
        /*
        articleLabel.text = String(describing: model.article)
        colorLabel.text = String(describing: model.color)
        sostabLabel.text = model.composition
        widthLabel.text = String(describing: model.width)
        costLabel.text = String(describing: model.price)
        */
    }
    


}


extension DetailsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        /*if indexPath.row == 0 {
            let deqCell = detailsTable.dequeueReusableCell(withIdentifier: "ItemDescriptionViewCell", for: indexPath)
            guard let cell = deqCell as? ItemDescriptionViewCell else { return UITableViewCell() }
            cell.bind(localModal!)
            return cell
        }
        
        //  history of ch label
        if indexPath.row == 1 {
            let cell = detailsTable.dequeueReusableCell(withIdentifier: "HistoryViewCell", for: indexPath)
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
        
        return upcastedCell */
        return UITableViewCell()
    }
}

extension DetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1 {
            return 60.0
        } else {
            return tableView.rowHeight
        }
    }
    
}
