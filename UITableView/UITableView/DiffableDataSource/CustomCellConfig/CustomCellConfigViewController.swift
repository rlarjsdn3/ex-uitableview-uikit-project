//
//  CustomCellConfigViewController.swift
//  UITableView
//
//  Created by 김건우 on 11/8/23.
//

import UIKit

class CustomCellConfigViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var appData: ApplicationData = ApplicationData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(CustomFoodCell.self, forCellReuseIdentifier: "customFoodCell")
        
        prepareDataSource()
        prepareSnapshot()
    }
    
    func prepareDataSource() {
        appData.dataSource = UITableViewDiffableDataSource<Sections, FoodsData.ID>(tableView: tableView) { tableView, indexPath, itemID in
            let cell = tableView.dequeueReusableCell(withIdentifier: "customFoodCell", for: indexPath) as! CustomFoodCell
            
            if let item = self.appData.items.first(where: { $0.id == itemID }) {
                cell.item = item
                cell.appData = self.appData
            }
            return cell
        }
    }
    
    func prepareSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Sections, FoodsData.ID>()
        snapshot.appendSections([.main])
        snapshot.appendItems(appData.items.map { $0.id })
        appData.dataSource.apply(snapshot)
    }

}
