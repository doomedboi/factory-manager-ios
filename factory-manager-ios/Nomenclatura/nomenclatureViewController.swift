//
//  nomenclatureViewController.swift
//  factory-manager-ios
//
//  Created by soFuckingHot on 06.01.2022.
//

import UIKit
import CloudKit

struct nomenTableViewModel {
    let category: String
    let items: [nomenclatureModel]
}

class nomenclatureViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var clothData: [ClothModel]? {
        didSet {
            DispatchQueue.main.async {
                self.nomenclatureList.reloadData()
            }
        }
    }
    var accessoryData: [AccessoryModel]? {
        didSet {
            DispatchQueue.main.async {
                self.nomenclatureList.reloadData()
            }
        }
    }
    var productData: [ProductModel]? {
        didSet {
            DispatchQueue.main.async {
            self.nomenclatureList.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var size: Int = 0
        
        if selectedCategoryIndex == 1 {
            size = clothData?.count ?? 0
        } else if selectedCategoryIndex == 2 {
            size = accessoryData?.count ?? 0
        } else {
            size = productData?.count ?? 0
        }
        return size
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = nomenclatureList.dequeueReusableCell(withIdentifier: "NomenclaturaTableViewCell", for: indexPath)
        guard let upcastedCell = cell as? NomenclaturaTableViewCell else {
            return UITableViewCell()
        }
        
        if selectedCategoryIndex == 1 {
            upcastedCell.bindCloth(clothData![indexPath.row])
        } else if selectedCategoryIndex == 2 {
            upcastedCell.bindAccessory(accessoryData![indexPath.row])
        }  else if selectedCategoryIndex == 0 {
            upcastedCell.bindProduct(productData![indexPath.row])
        }

        return upcastedCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedCategoryIndex == 0 {
        
        let detailsVc = NomenclaturaDetailsViewController(nibName: "NomenclaturaDetailsViewController", bundle: nil)
        
        let modelData = self.productData?[indexPath.row]
        detailsVc.localModal = modelData
        
        navigationController?.pushViewController(detailsVc, animated: true)
            
        } else if selectedCategoryIndex == 1 {
            let vc = DetailsViewController(nibName: "DetailsViewController", bundle: nil)
            let modelData = self.clothData?[indexPath.row]
            vc.model = modelData
            
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = AccessoryDetailsViewController(nibName: "AccessoryDetailsViewController", bundle: nil)
            let modelData = self.accessoryData?[indexPath.row]
            vc.model = modelData
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
        
    
    private func fetchDataFromServer() {
        //NetworkManager.cloth()
    }
    
    
    @IBOutlet weak var nomenclatureList: UITableView!
    @IBOutlet weak var segmentControll: UISegmentedControl!
    @IBOutlet weak var contentViews: UIView!
    
    private var selectedCategoryIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.orange], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray], for: .normal)
        UILabel.appearance(whenContainedInInstancesOf: [UISegmentedControl.self]).numberOfLines = 0
        commonInit()
        
        self.nomenclatureList.reloadData()
    }

    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        DispatchQueue.main.async {
            
        NetworkManager.cloth() { responseObjectsArray in
            self.clothData = responseObjectsArray
        }
        NetworkManager.accessory() {
            responseObjectsArray in
            self.accessoryData = responseObjectsArray
        }
        NetworkManager.product() {
            responseObjectsArray in
            self.productData = responseObjectsArray
        }
        }
        
    }
    
    
    @objc func presentContent(target: UISegmentedControl) {
        guard target == self.segmentControll else { return }
        
        self.selectedCategoryIndex = target.selectedSegmentIndex
        DispatchQueue.main.async {
            self.nomenclatureList.reloadData()
        }
    }
    
    private func commonInit() {
        
        self.segmentControll.addTarget(self, action: #selector(presentContent), for: .valueChanged)
        
        nomenclatureList.dataSource = self
        nomenclatureList.delegate = self
        nomenclatureList.register(UINib(nibName: "NomenclaturaTableViewCell", bundle: nil), forCellReuseIdentifier: "NomenclaturaTableViewCell")
    
        nomenclatureList.separatorStyle = .none
        nomenclatureList.backgroundColor = .clear
        self.contentViews.backgroundColor = UIColor(named: "backgroundColor")
        
    }

}


