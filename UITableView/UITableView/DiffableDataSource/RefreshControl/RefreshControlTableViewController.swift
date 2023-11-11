//
//  RefreshControlTableViewController.swift
//  UITableView
//
//  Created by 김건우 on 11/10/23.
//

import UIKit

class RefreshControlTableViewController: UITableViewController {

    typealias MyDataSource = UITableViewDiffableDataSource<Sections, FoodsData.ID>
    typealias MySnapshot = NSDiffableDataSourceSnapshot<Sections, FoodsData.ID>
    
    var refresh: UIRefreshControl!
    var appData: ApplicationData = ApplicationData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        prepareDatasource()
        prepareSnapshot()
        
        refresh = UIRefreshControl()
        refresh.addAction(UIAction(handler: { [unowned self] action in
            self.refreshTable()
        }), for: .valueChanged)
        
        let text = AttributedString("Refreshing Table")
        refresh.attributedTitle = NSAttributedString(text)
        tableView.refreshControl = refresh
        
        navigationItem.title = "Refresh Control"
    }
    
    func prepareDatasource() {
        appData.dataSource = MyDataSource(tableView: tableView){ tableView, indexPath, itemID in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            
            if let item = self.appData.items.first(where: { $0.id == itemID }) {
                var contentConfig = cell.defaultContentConfiguration()
                contentConfig.text = item.name
                cell.contentConfiguration = contentConfig
            }
            return cell
        }
    }
    
    func prepareSnapshot() {
        var snapshot = MySnapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(appData.items.map { $0.id })
        appData.dataSource.apply(snapshot)
    }
    
    func refreshTable() {
        self.prepareSnapshot()
        refresh.endRefreshing()
    }

}
