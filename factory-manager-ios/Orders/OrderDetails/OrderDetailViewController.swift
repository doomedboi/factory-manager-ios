//
//  OrderDetailViewController.swift
//  factory-manager-ios
//
//  Created by soFuckingHot on 14.01.2022.
//

import UIKit

class OrderDetailViewController: UIViewController {

    var model: OrderModel?
    
    @IBOutlet weak var itemsTable: UITableView!
    @IBOutlet weak var segmentView: UISegmentedControl!
    
    @IBOutlet weak var itemsViewOutlet: UIView!
    @IBOutlet weak var infoViewOutlet: UIView!
    
    
    private var selectedIndex = 0
    
    
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var customerLabel: UILabel!
    @IBOutlet weak var managerLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title =  "Заказ номер \(model?.id ?? 0)"
        
        self.itemsTable.delegate = self
        self.itemsTable.dataSource = self
        self.itemsTable.register(UINib(nibName: "NomenclaturaTableViewCell", bundle: nil), forCellReuseIdentifier: "NomenclaturaTableViewCell")
        
        segmentView.addTarget(self, action: #selector(segmentControlChangeHandler(_:)), for: .valueChanged)
        self.fetch()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bind(model!)
        print("=====================")
        print(model?.products)
        
    }
    
    private func fetch(_ segmentIndex: Int = 0) {
        var firstHidden: Bool = !(segmentIndex == 0)
        var secondHidden = !firstHidden
        self.infoViewOutlet.isHidden = firstHidden
        self.itemsViewOutlet.isHidden = secondHidden
    }
    
    @objc func segmentControlChangeHandler(_ sender: Any) {
        fetch(segmentView.selectedSegmentIndex)
    }
    
    func bind(_ model: OrderModel) {
        print(model.id!)
        numberLabel.text = String(describing: model.id!)
        dataLabel.text = String(model.creationDate.prefix(10))
        priceLabel.text = String(describing: model.cost)
        statusLabel.text = orderStages[model.stage ?? 0]
        customerLabel.text = model.customer.name
        managerLabel.text = model.manager.name
    }
    

}

extension OrderDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let detailsView = NomenclaturaDetailsViewController(nibName: "NomenclaturaDetailsViewController", bundle: nil)
        
        detailsView.localModal = model?.products[indexPath.row].product
        print(model?.products)
        
        
        navigationController?.pushViewController(detailsView, animated: true)
    }
}

extension OrderDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.products.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let activityData = self.model?.products[indexPath.row].product
        
        let dequeuedCell = itemsTable.dequeueReusableCell(withIdentifier: "NomenclaturaTableViewCell", for: indexPath)
        
        // not work without guard asks unwrap
        guard let upcastedCell = dequeuedCell as? NomenclaturaTableViewCell
        else {
            return UITableViewCell()
        }
        
        upcastedCell.bindOrderItem(activityData!, amount: 666)
        
        return upcastedCell
    }
    
}
