//
//  ADMMRowsViewController.swift
//  UITableView
//
//  Created by 김건우 on 11/9/23.
//

import UIKit

class EditRowsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var selected: ItemsData!
    var appData: ApplicationData = ApplicationData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        prepareDatasource()
        prepareSnapshot()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    // ⭐️ 세그웨이 이동 전에 호출되는 메서드
    // 주로 이동할 컨트롤러에게 데이터를 전달할 목적으로 구현함.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetailVC" {
            let controller = segue.destination as! DetailViewController
            controller.selected = selected
        }
    }
    
    func prepareDatasource() {
        appData.dataSource = UITableViewDiffableDataSource<Sections, ItemsData.ID>(tableView: tableView) { tableView, indexPath, itemID in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            
            if let item = self.appData.items.first(where: { $0.id == itemID }) {
                var contentConfig = cell.defaultContentConfiguration()
                contentConfig.text = item.name
                cell.contentConfiguration = contentConfig
            }
            cell.accessoryType = .disclosureIndicator
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

extension EditRowsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let itemID = appData.dataSource.itemIdentifier(for: indexPath) {
            if let item = appData.items.first(where: { $0.id == itemID }) {
                selected = item
            }
        }
        performSegue(withIdentifier: "goToDetailVC", sender: self)
    }
    
}
