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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[selectedCategoryIndex].items.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = self.data[selectedCategoryIndex].items[indexPath.row]
        
        let cell = nomenclatureList.dequeueReusableCell(withIdentifier: "NomenclaturaTableViewCell", for: indexPath)
        guard let upcastedCell = cell as? NomenclaturaTableViewCell else {
            return UITableViewCell()
        }
        
        upcastedCell.bind(data)
        print("good")
        return upcastedCell
    }
        
    
    private let data: [nomenTableViewModel] = {
        let first1: [nomenclatureModel] = [
            nomenclatureModel(icon: UIImage(), name: "kk", article: "kk")
        ]
        
        let first2: [nomenclatureModel] = [
            nomenclatureModel(icon: UIImage(), name: "xx", article: "xx"),
            nomenclatureModel(icon: UIImage(), name: "xx1", article: "xx2")
        ]
        
        let first3: [nomenclatureModel] = [
            nomenclatureModel(icon: UIImage(), name: "furnitura", article: ".."),
            nomenclatureModel(icon: UIImage(), name: "furnitura2", article: "..2")
        ]
        
        return [
            nomenTableViewModel(category: "kk", items: first1),
            nomenTableViewModel(category: "xx", items: first2),
            nomenTableViewModel(category: "zz", items: first3)
        ]
    }()
    
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


