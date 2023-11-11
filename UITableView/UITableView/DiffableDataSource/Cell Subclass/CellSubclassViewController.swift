//
//  CellSubclassViewController.swift
//  UITableView
//
//  Created by 김건우 on 11/8/23.
//

import UIKit

class CellSubclassViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var appData: ApplicationData = ApplicationData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(FoodCell.self, forCellReuseIdentifier: "foodCell")
        
        prepareDataSource()
        prepareSnapshot()
    }
    
    func prepareDataSource() {
        appData.dataSource = UITableViewDiffableDataSource<Sections, ItemsData.ID>(tableView: tableView) { tableView, indexPath, itemID in
            let cell = tableView.dequeueReusableCell(withIdentifier: "foodCell", for: indexPath) as! FoodCell
            
            if let item = self.appData.items.first(where: { $0.id == itemID }) {
                cell.item = item
            }
            return cell
        }
    }
    
    func prepareSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Sections, FoodsData.ID>()
        snapshot.appendSections([.main])
        snapshot.appendItems(appData.items.map({ $0.id }))
        appData.dataSource.apply(snapshot)
    }

}
