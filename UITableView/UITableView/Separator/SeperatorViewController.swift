//
//  SeperatorViewController.swift
//  UITableView
//
//  Created by 김건우 on 11/5/23.
//

import UIKit

class SeperatorViewController: UIViewController {

    let list = [("iPhone 15", "$699"), ("iPhone 15 Plus", "$799"), ("iPhone 15 Pro", "$899"), ("iPhone 15 Pro Max", "$999")]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        setupTableViewSeparator()
    }
    
    func setupTableViewSeparator() {
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .systemBlue
        // ⭐️ 구분선의 여백 간격을 설정
        // 이때, 위아래 여백은 무시됨.
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 100)
        // ⭐️ 구분선의 여백을 계산하는 위치를 설정
        // fromCellEdges: 셀의 가장자리를 기준으로 계산
        // fromAutomaticInsets: 시스템에 의해 자동으로 설정된 기준으로 계산
        tableView.separatorInsetReference = .fromCellEdges
    }

}

extension SeperatorViewController: UITableViewDelegate { }

extension SeperatorViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // 개별 셀에서는 SeparatorInset만 설정 가능함.
        if indexPath.row == 2 {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 100, bottom: 0, right: 200)
        } else {
            // 이 코드가 없으면
            // 재사용 메카니즘으로 인해 앞서 설정한 구분선 여백이 다시 나타날 수 있음.
            cell.separatorInset = tableView.separatorInset
        }
        
        var contentConfig = cell.defaultContentConfiguration()
        contentConfig.text = list[indexPath.row % list.count].0
        contentConfig.secondaryText = list[indexPath.row % list.count].1
        cell.contentConfiguration = contentConfig
        return cell
    }
    
}
