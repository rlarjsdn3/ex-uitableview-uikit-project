//
//  SearchTableViewController.swift
//  UITableView
//
//  Created by 김건우 on 11/10/23.
//

import UIKit


class SearchTableViewController: UITableViewController {

    typealias MyDataSource = UITableViewDiffableDataSource<Sections, FoodsData.ID>
    typealias MySnapshot = NSDiffableDataSourceSnapshot<Sections, FoodsData.ID>
    
    var appData: ApplicationData = ApplicationData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        prepareDatasource()
        prepareSnapshot()
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        // ⭐️ 검색 바를 클릭하면 화면을 흐리게 할지 말지 결정함.
        searchController.obscuresBackgroundDuringPresentation = false
        // ⭐️ 검색 바를 클릭하면 네비게이션 바를 숨길지 말지 결정함.
        searchController.hidesNavigationBarDuringPresentation = true
        // ⭐️ 테이블 뷰를 스크롤하면 검색 바를 숨길지 말지 결정함.
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        navigationItem.title = "Search"
        
        let searchBar = searchController.searchBar
        searchBar.delegate = self
        searchBar.placeholder = "Search Product"
        searchBar.showsScopeBar = true
        searchBar.scopeButtonTitles = ["Names", "Calories"]
        searchBar.selectedScopeButtonIndex = 0
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
        snapshot.appendItems(appData.filteredItems.map { $0.id })
        appData.dataSource.apply(snapshot, animatingDifferences: false, completion: nil)
    }

}

extension SearchTableViewController: UISearchResultsUpdating {
    
    // ⭐️ 검색 바에 입력을 할 때마다 호출되는 델리게이트 메서드
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text {
            appData.searchValue = text.trimmingCharacters(in: .whitespaces)
            prepareSnapshot()
        }
    }
    
}

extension SearchTableViewController: UISearchBarDelegate {
    
    // ⭐️ ScopeButton 인덱스 값이 달라질 때마다 호출되는 델리게이트 메서드
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        appData.selectedButton = selectedScope
        prepareSnapshot()
        searchBar.placeholder = selectedScope == 0 ? "Search Product" : "Maximum Calories"
        searchBar.text = ""
    }
    
}
