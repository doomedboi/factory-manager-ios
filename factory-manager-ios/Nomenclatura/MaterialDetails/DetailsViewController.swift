//
//  DetailsViewController.swift
//  factory-manager-ios
//
//  Created by soFuckingHot on 14.01.2022.
//

import UIKit

class DetailsViewController: UIViewController {

    var model: ClothModel?
    
    var rulons: [ClothArticleModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.detailsTable.reloadData()
            }
        }
    }
    
    @IBOutlet weak var viewWithImage: UIImageView!
    
    @IBOutlet weak var viewImageContainer: UIView!
    
    @IBOutlet weak var detailsTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewImageContainer.layer.backgroundColor = UIColor(red: 0.933, green: 0.978, blue: 1, alpha: 1).cgColor
        viewImageContainer.layer.borderWidth = 4
        viewImageContainer.layer.borderColor = UIColor(red: 0.82, green: 0.933, blue: 0.988, alpha: 1).cgColor
        self.title = model?.name
        initTable()
        DispatchQueue.main.async {
            NetworkManager.getClothByArticle(article: 123, complition: { rulonsArray in
                self.rulons = rulonsArray
            })
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setImage(model!)
    }
    
    
    private func initTable() {
        self.detailsTable.delegate = self
        self.detailsTable.dataSource = self
        self.detailsTable.register(UINib(nibName: "RulonsViewCell", bundle: nil), forCellReuseIdentifier: "RulonsViewCell")
        self.detailsTable.register(UINib(nibName: "MaterialDescriptionViewCell", bundle: nil), forCellReuseIdentifier: "MaterialDescriptionViewCell")
        self.detailsTable.register(UINib(nibName: "HistoryViewCell", bundle: nil), forCellReuseIdentifier: "HistoryViewCell")
    }
    
    func setImage(_ model: ClothModel) {
        if let img = NetworkHelper.getFullImagePath(localPath: model.image) {
            self.viewWithImage.sd_setImage(with: img, completed: nil)
        }
    }
}


extension DetailsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rulons.count > 0 ? rulons.count + 2 : rulons.count + 1
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let deqCell = detailsTable.dequeueReusableCell(withIdentifier: "MaterialDescriptionViewCell", for: indexPath)
            guard let castedCell = deqCell as? MaterialDescriptionViewCell else { return UITableViewCell() }
            castedCell.bind(model: model!)
            
            return castedCell
        }
        
        if indexPath.row == 1 {
            let cell = detailsTable.dequeueReusableCell(withIdentifier: "HistoryViewCell", for: indexPath)
            guard let upcell = cell as? HistoryViewCell else { return UITableViewCell() }
            upcell.bind("РУЛОНЫ")
            return upcell
            
        }
        
        let offset = rulons.count > 0 ? -2 : 0
        let currentCellInfo = rulons[indexPath.row + offset]
        let cell = detailsTable.dequeueReusableCell(withIdentifier: "RulonsViewCell", for: indexPath)
        guard let castedCell = cell as? RulonsViewCell else { return UITableViewCell() }
        castedCell.bind(currentCellInfo)
        
        return castedCell
        
    }
}

extension DetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1 && rulons.count > 0 {
            return 60.0
        } else {
            return tableView.rowHeight
        }
    }
    
}
