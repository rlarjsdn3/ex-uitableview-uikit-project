//
//  SectionsTableViewController.swift
//  UITableView
//
//  Created by 김건우 on 11/10/23.
//

import UIKit

class SectionsTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "header")
        
        prepareDatasource()
        prepareSnapshot()
        
        navigationItem.title = "Sections"
    }
    
    func prepareDatasource() {
        appSectionData.dataSource = MySectionDatasource(tableView: tableView) { tableView, indexPath, itemID in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            
            if let item = appSectionData.items.first(where: { $0.id == itemID }) {
                var contentConfig = cell.defaultContentConfiguration()
                contentConfig.text = item.name
                cell.contentConfiguration = contentConfig
            }
            return cell
        }
    }
    
    func prepareSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<AlphabetSections.ID, FoodsData.ID>()
        snapshot.appendSections(appSectionData.sections.map { $0.id })
        for section in appSectionData.sections {
            let itemIDs = appSectionData.items.compactMap { value in
                return value.section == section.name ? value.id : nil
            }
            snapshot.appendItems(itemIDs, toSection: section.id)
        }
        appSectionData.dataSource.apply(snapshot)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header")!
        
        var headerConfig = UIListContentConfiguration.prominentInsetGroupedHeader()
        headerConfig.text = appSectionData.sections[section].name
        headerConfig.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 0)
        header.contentConfiguration = headerConfig
        return header
    }
    
}

