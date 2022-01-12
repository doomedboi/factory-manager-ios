//
//  nomenclatureViewController.swift
//  factory-manager-ios
//
//  Created by soFuckingHot on 06.01.2022.
//

import UIKit

struct nomenTableViewModel {
    let category: String
    let items: [nomenclatureModel]
}

class nomenclatureViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var clothData: [ClothModel]?
    var accessoryData: [AccessoryModel]?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedCategoryIndex == 1 {
            return clothData?.count ?? 0
        } else if selectedCategoryIndex == 2 {
            return accessoryData?.count ?? 0
        }
        return 0
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
        } // else {}
        print("good")
        return upcastedCell
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
        //(TabbarViewController(nibName: "TabbarViewController", bundle: nil), animated: true, completion: nil)
        
        self.navigationController?.isNavigationBarHidden = true
        
        print("heeeeeeeeee")
        
        }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NetworkManager.cloth() { responseObjectsArray in
            self.clothData = responseObjectsArray
        }
        NetworkManager.accessory() {
            responseObjectsArray in
            self.accessoryData = responseObjectsArray
        }
    }
    
    @objc func presentContent(target: UISegmentedControl) {
        guard target == self.segmentControll else { return }
        
        self.selectedCategoryIndex = target.selectedSegmentIndex
        self.nomenclatureList.reloadData()
    }
    
    private func commonInit() {
        
        self.segmentControll.addTarget(self, action: #selector(presentContent), for: .valueChanged)
        
        nomenclatureList.dataSource = self
        nomenclatureList.delegate = self
        nomenclatureList.register(UINib(nibName: "NomenclaturaTableViewCell", bundle: nil), forCellReuseIdentifier: "NomenclaturaTableViewCell")
    
        nomenclatureList.separatorStyle = .none
        nomenclatureList.backgroundColor = .clear
    }

}


