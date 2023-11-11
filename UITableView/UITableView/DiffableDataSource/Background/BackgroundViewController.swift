//
//  BackgroundViewController.swift
//  UITableView
//
//  Created by 김건우 on 11/8/23.
//

import UIKit

class BackgroundViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var appData: ApplicationData = ApplicationData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView.rowHeight = 80.0
        tableView.separatorStyle = .none
        
        prepareDataSource()
        prepareSnapshot()
    }
    
    func prepareDataSource() {
        appData.dataSource = UITableViewDiffableDataSource<Sections, FoodsData.ID>(tableView: tableView) { tableView, indexPath, itemID in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            
            if let item = self.appData.items.first(where: { $0.id == itemID }) {
                var contentConfig = cell.defaultContentConfiguration()
                contentConfig.text = item.name
                contentConfig.image = UIImage(named: item.image)
                contentConfig.imageProperties.maximumSize = CGSize(width: 60, height: 60)
                cell.contentConfiguration = contentConfig
                
                var backgroundConfig = UIBackgroundConfiguration.listPlainCell()
                backgroundConfig.backgroundColor = .systemGray6
                backgroundConfig.backgroundInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
                backgroundConfig.cornerRadius = 10
                cell.backgroundConfiguration = backgroundConfig
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
