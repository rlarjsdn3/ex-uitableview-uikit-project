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
        AppData.dataSource = FoodDataSource(tableView: tableView) { tableView, indexPath, itemID in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            
            if let item = AppData.items.first(where: { $0.id == itemID }) {
                var contentConfig = cell.defaultContentConfiguration()
                contentConfig.text = item.name
                cell.contentConfiguration = contentConfig
            }
            cell.accessoryType = .disclosureIndicator
            return cell
        }
    }
    
    func prepareSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Sections, FoodsData.ID>()
        snapshot.appendSections([.main])
        snapshot.appendItems(AppData.items.map { $0.id })
        AppData.dataSource.apply(snapshot)
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "goToAddVC", sender: self)
    }
    
    @IBAction func editButtonPressed(_ sender: UIBarButtonItem) {
        if tableView.isEditing {
            tableView.setEditing(false, animated: true)
        } else {
            tableView.setEditing(true, animated: true)
        }
    }
    
}

extension EditRowsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let itemID = AppData.dataSource.itemIdentifier(for: indexPath) {
            if let item = AppData.items.first(where: { $0.id == itemID }) {
                selected = item
            }
        }
        performSegue(withIdentifier: "goToDetailVC", sender: self)
    }
    
    // ✏️ 이 메서드는 FoodDataSource에 구현되어 있는 tableView(UITableView, commit:, forRowAt:) 메서드를 대체함.
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let button = UIContextualAction(style: .normal, title: "Remove") { action, view, completion in
            if let itemID = AppData.dataSource.itemIdentifier(for: indexPath) {
                AppData.items.removeAll(where: { $0.id == itemID })
                
                var currentSnapshot = AppData.dataSource.snapshot()
                currentSnapshot.deleteItems([itemID])
                AppData.dataSource.apply(currentSnapshot)
            }
            completion(true)
        }
        button.backgroundColor = UIColor.systemBlue
        
        var config = UISwipeActionsConfiguration(actions: [button])
        config.performsFirstActionWithFullSwipe = false
        return config
    }
    
}
