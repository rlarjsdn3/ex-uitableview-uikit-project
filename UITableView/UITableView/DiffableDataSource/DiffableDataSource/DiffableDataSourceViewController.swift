//
//  DiffableDataSourceViewController.swift
//  UITableView
//
//  Created by 김건우 on 11/8/23.
//

import UIKit

class DiffableDataSourceViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var appData: ApplicationData = ApplicationData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        prepareDataSource()
        prepareSnapshot()
    }
    
    func prepareDataSource() {
        // ⭐️ 이 클래스는 원본 데이터와 함께 셀을 구성함.
        // 각 제네릭 타입은 Hashable 프로토콜을 준수하는 섹션과 아이템을 나타내는 타입이어야 함.
        appData.dataSource = UITableViewDiffableDataSource<Sections, ItemsData.ID>(tableView: tableView) { tableView, indexPath, itemID in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            
            if let item = self.appData.items.first(where: { $0.id == itemID }) {
                var contentConfig =  cell.defaultContentConfiguration()
                contentConfig.text = item.name
                contentConfig.textProperties.color = UIColor.systemBlue
                contentConfig.secondaryText = "\(item.calories) Calories"
                contentConfig.secondaryTextProperties.color = UIColor.systemGray
                contentConfig.image = UIImage(named: item.image)
                contentConfig.imageProperties.maximumSize = CGSize(width: 40, height: 40)
                cell.contentConfiguration = contentConfig
            }
            return cell
        }
    }
    
    func prepareSnapshot() {
        // ⭐️ 이 클래스는 현재 UI의 상태를 의미함.
        // 스냅샷을 통해 셀 추가, 삭제 및 이동 연산을 수행한 결과를 DataSource에 Apply를 하면 변경 사항이 적용됨.
        var snapshot = NSDiffableDataSourceSnapshot<Sections, ItemsData.ID>()
        snapshot.appendSections([.main])
        snapshot.appendItems(appData.items.map({ $0.id }))
        appData.dataSource.apply(snapshot)
    }

}
