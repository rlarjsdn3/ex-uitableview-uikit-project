//
//  CustomConfigViewController.swift
//  UITableView
//
//  Created by 김건우 on 11/9/23.
//

import UIKit

class CustomConfigViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var appData: ApplicationData = ApplicationData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(CustomConfigFoodCell.self, forCellReuseIdentifier: "foodCell")
        
        prepareDataSource()
        prepareSnapshot()
    }
    
    func prepareDataSource() {
        appData.dataSource = UITableViewDiffableDataSource<Sections, ItemsData.ID>(tableView: tableView) { tableView, indexPath, itemID in
            let cell = tableView.dequeueReusableCell(withIdentifier: "foodCell", for: indexPath) as! CustomConfigFoodCell
            
            if let item = self.appData.items.first(where: { $0.id == itemID }) {
                cell.item = item
            }
            return cell
        }
    }
    
    func prepareSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Sections, ItemsData.ID>()
        snapshot.appendSections([.main])
        snapshot.appendItems(appData.items.map { $0.id })
        appData.dataSource.apply(snapshot)
    }

}