//
//  BasicViewController.swift
//  UITableView
//
//  Created by 김건우 on 11/5/23.
//

import UIKit

class BasicViewController: UIViewController {

    let list = [("iPhone 15", "$699"), ("iPhone 15 Plus", "$799"), ("iPhone 15 Pro", "$899"), ("iPhone 15 Pro Max", "$999")]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }

}

extension BasicViewController: UITableViewDelegate {
    
    // ⭐️ 셀이 선택되고 난 후, 호출되는 델리게이트 메서드
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension BasicViewController: UITableViewDataSource {
    
    // ⭐️ 셀의 개수를 반환하는 델리게이트 메서드
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    // ⭐️ 셀을 만들어서 반환하는 델리게이트 메서드
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        var configuration = cell.defaultContentConfiguration()
        configuration.text = list[indexPath.row].0
        configuration.secondaryText = list[indexPath.row].1
        
        cell.contentConfiguration = configuration
        return cell
    }
    
}
