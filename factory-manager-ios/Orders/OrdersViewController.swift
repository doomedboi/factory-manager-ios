//
//  OrdersViewController.swift
//  factory-manager-ios
//
//  Created by soFuckingHot on 07.01.2022.
//

import UIKit
import CoreData

class OrdersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var ordersTable: UITableView!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return data?.count ?? 0
    }
    
    private var data: [OrderModel]? {
        didSet {
            DispatchQueue.main.async {
                self.ordersTable.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = ordersTable.dequeueReusableCell(withIdentifier: "OrdersTableViewCell", for: indexPath)
        guard let upcastedCell = cell as? OrdersTableViewCell else {
            return UITableViewCell()
        }
        
        upcastedCell.bind(data![indexPath.row])
        print("good")
        return upcastedCell
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Orders"
        tableInit()
    }
    
    private func tableInit() {
        ordersTable.dataSource = self
        ordersTable.delegate = self
        ordersTable.register(UINib(nibName: "OrdersTableViewCell", bundle: nil), forCellReuseIdentifier: "OrdersTableViewCell")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            NetworkManager.order() { responseObject in
                self.data = responseObject
            }
        }
    }
    
    



    

}
