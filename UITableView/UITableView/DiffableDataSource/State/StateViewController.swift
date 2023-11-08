//
//  StateViewController.swift
//  UITableView
//
//  Created by 김건우 on 11/8/23.
//

import UIKit

class StateViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var appData: ApplicationData = ApplicationData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView.rowHeight = 80
        tableView.separatorStyle = .none
        
        prepareDataSource()
        prepareSnapshot()
    }
    
    func prepareDataSource() {
        appData.dataSource = UITableViewDiffableDataSource<Sections, ItemsData.ID>(tableView: tableView) { tableView, indexPath, itemID in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            
            if let item = self.appData.items.first(where: { $0.id == itemID }) {
                var contentConfig = cell.defaultContentConfiguration()
                contentConfig.text = item.name
                contentConfig.image = UIImage(named: item.image)
                contentConfig.imageProperties.maximumSize = CGSize(width: 60, height: 60)
                cell.contentConfiguration = contentConfig
                
                // ⭐️ 이 클로저는 셀의 상태가 변하거나, 처음 생성되면 호출됨.
                // 첫 번쨰 매개변수는 cell의 참조이고, 두 번쨰 매개변수는 셀의 현재 상태를 알려주는 UICellConfigurationState 값임
                cell.configurationUpdateHandler = { cell, state in
                    // ⭐️ update(for:): 전달된 상태에 따른 셀의 모습을 반환함.
                    var backgroundConfig = UIBackgroundConfiguration.listPlainCell().updated(for: state)
                    backgroundConfig.backgroundInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
                    backgroundConfig.cornerRadius = 10
                    
                    if state.isSelected {
                        backgroundConfig.backgroundColor = UIColor.systemBlue
                    } else {
                        backgroundConfig.backgroundColor = UIColor.systemGray6
                    }
                    cell.backgroundConfiguration = backgroundConfig
                }
            }
            return cell
        }
    }
    
    func prepareSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Sections, ItemsData.ID>()
        snapshot.appendSections([.main])
        snapshot.appendItems(appData.items.map({ $0.id }))
        appData.dataSource.apply(snapshot)
    }

}
