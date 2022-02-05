//
//  OrderDetailViewController.swift
//  factory-manager-ios
//
//  Created by soFuckingHot on 14.01.2022.
//

import UIKit

class OrderDetailViewController: UIViewController {

    var model: OrderModel?
    var mappingCloth: [MappingClothModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.mappingTable.reloadData()
            }
        }
    }
    
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
    
    @IBOutlet weak var mappingView: UIView!
    @IBOutlet weak var mappingTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title =  "Заказ номер \(model?.id ?? 0)"
        
        self.itemsTable.delegate = self
        self.itemsTable.dataSource = self
        self.itemsTable.register(UINib(nibName: "NomenclaturaTableViewCell", bundle: nil), forCellReuseIdentifier: "NomenclaturaTableViewCell")
        self.mappingTable.register(UINib(nibName: "MapViewCell", bundle: nil), forCellReuseIdentifier: "MapViewCell")
        self.mappingTable.delegate = self
        self.mappingTable.dataSource = self
        
        segmentView.addTarget(self, action: #selector(segmentControlChangeHandler(_:)), for: .valueChanged)
        self.fetch()
        self.mappingTable.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bind(model!)
        print("=====================")
        print(model?.products)
        DispatchQueue.main.async {
            NetworkManager.getClothMapping(orderId: self.model!.id!, complition: { mapResponse in
                self.mappingCloth = mapResponse
            })
            self.mappingTable.reloadData()
        }
        
    }
    
    private func fetch(_ segmentIndex: Int = 0) {
        var firstHidden = true
        var secondHidden = true
        var thridHide = true
        if segmentIndex == 0 {
            firstHidden = false
        } else if segmentIndex == 1 {
            secondHidden = false
        } else {
            thridHide = false
            self.mappingTable.reloadData()
        }
        
        self.infoViewOutlet.isHidden = firstHidden
        self.itemsViewOutlet.isHidden = secondHidden
        self.mappingView.isHidden = thridHide
        
        self.mappingTable.reloadData()
        self.itemsTable.reloadData()
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
        if segmentView.selectedSegmentIndex == 1 {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let detailsView = NomenclaturaDetailsViewController(nibName: "NomenclaturaDetailsViewController", bundle: nil)
        
        detailsView.localModal = model?.products[indexPath.row].product
        print(model?.products)
        
        
        navigationController?.pushViewController(detailsView, animated: true)
        } else if segmentView.selectedSegmentIndex == 2 {
            //  push view with image
            let view = OrderMapViewController(nibName: "OrderMapViewController", bundle: nil)
            view.imagePath = (mappingCloth[indexPath.row].map)
            
            print(mappingCloth[indexPath.row].map)
            navigationController?.pushViewController(view, animated: true)
        }
    }
}

extension OrderDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segmentView.selectedSegmentIndex == 1 {
            return model?.products.count ?? 0
        } else if segmentView.selectedSegmentIndex == 2 {
            print(mappingCloth.count)
            return mappingCloth.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if segmentView.selectedSegmentIndex == 1 {
        let activityData = self.model?.products[indexPath.row].product
        
        let dequeuedCell = itemsTable.dequeueReusableCell(withIdentifier: "NomenclaturaTableViewCell", for: indexPath)
        
        // not work without guard asks unwrap
        guard let upcastedCell = dequeuedCell as? NomenclaturaTableViewCell
        else {
            return UITableViewCell()
        }
        
        upcastedCell.bindOrderItem(activityData!, amount: 666)
        
        return upcastedCell
        } else {
            let data = self.mappingCloth[indexPath.row]
            
            let cell = mappingTable.dequeueReusableCell(withIdentifier: "MapViewCell", for: indexPath)
            guard let upCell = cell as? MapViewCell else { return UITableViewCell() }
            
            upCell.bind(article: data.article, rulon: data.batchNumber)
            
            return upCell
        }
    }
    
}
