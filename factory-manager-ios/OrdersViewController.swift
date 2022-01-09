//
//  OrdersViewController.swift
//  factory-manager-ios
//
//  Created by soFuckingHot on 07.01.2022.
//

import UIKit

class OrdersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    private let data: [orderModel] = [
            orderModel(number: "xxx1", customer: "OOO xxx1", status: "Well done"),
            orderModel(number: "xxx2", customer: "OOO yyy1", status: "Fuck this shit")
            
    ]
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = self.data[indexPath.row]
        
        let cell = ordersTable.dequeueReusableCell(withIdentifier: "OrdersTableViewCell", for: indexPath)
        guard let upcastedCell = cell as? OrdersTableViewCell else {
            return UITableViewCell()
        }
        
        upcastedCell.bind(data)
        print("good")
        return upcastedCell
    }
    

    @IBOutlet weak var ordersTable: UITableView!
    
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
    
    



    

}
