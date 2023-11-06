//
//  SingleSelectionViewController.swift
//  UITableView
//
//  Created by 김건우 on 11/5/23.
//

import UIKit

class SingleSelectionViewController: UIViewController {

    let list = RandomNumber.generateData()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func showAlert(_ number: Int) {
        let alert = UIAlertController(title: "선택된 숫자", message: "\(number)", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "확인", style: .default)
        alert.addAction(okAction)
        
        present(alert, animated: true)
    }
    
    func hightlightCell(_ number: Int, indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            var contentConfig = cell.defaultContentConfiguration()
            contentConfig.attributedText = NSAttributedString(
                string: "\(number)", attributes: [.foregroundColor: UIColor.black])
            cell.contentConfiguration = contentConfig
        }
    }
    
    func unhighlightCell(_ number: Int, indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            var contentConfig = cell.defaultContentConfiguration()
            contentConfig.attributedText = NSAttributedString(
                string: "\(number)", attributes: [.foregroundColor: UIColor.systemGray3])
            cell.contentConfiguration = contentConfig
        }
    }

}

extension SingleSelectionViewController: UITableViewDelegate {
    
    // ⭐️ 셀이 선택되기 전에 호출되는 델리게이트 메서드
    // 해당 셀릐 선택 유무를 결정할 수 있음.
    // indexPath를 반환하면 선택 가능, nil을 반환하면 선택 불가능
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if indexPath.row == 0 {
            return nil
        }
        return indexPath
    }
    
    // ⭐️ 셀이 선택되고 난 후, 호출되는 델리게이트 메서드
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedNumber = list[indexPath.section].numbers[indexPath.row]
        showAlert(selectedNumber)
        
        hightlightCell(selectedNumber, indexPath: indexPath)
    }
    
    // ⭐️ 셀 선택이 해제되기 전에 호출되는 델리게이트 메서드
    // 해당 셀릐 선택 해제 유무를 결정할 수 있음.
    // indexPath를 반환하면 해제 가능, nil을 반환하면 해제 불가능
    func tableView(_ tableView: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath? {
        return indexPath
    }
    
    // ⭐️ 셀이 해제되고 난 후, 호출되는 델리게이트 메서드
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let selectedNumber = list[indexPath.section].numbers[indexPath.row]
        
        unhighlightCell(selectedNumber, indexPath: indexPath)
    }
    
    // ⭐️ 셀을 강조 가능하도록 할지 결정히는 델리게이트 메서드
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        if indexPath.row == 0 {
            return false
        }
        return true
    }
    
    // ⭐️ 셀이 강조되고 난 후, 호출되는 델리게이트 메서드
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        let selectedNumber = list[indexPath.section].numbers[indexPath.row]
        
        hightlightCell(selectedNumber, indexPath: indexPath)
    }
    
    // ⭐️ 셀이 강조 해제되고 난 후, 호출되는 델리게이트 메서드
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        let selectedNumber = list[indexPath.section].numbers[indexPath.row]
        
        unhighlightCell(selectedNumber, indexPath: indexPath)
    }
    
}

extension SingleSelectionViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list[section].numbers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var contentConfig = cell.defaultContentConfiguration()
        let number = String(list[indexPath.section].numbers[indexPath.row])
        contentConfig.attributedText = NSAttributedString(
            string: number, attributes: [.foregroundColor: UIColor.systemGray3]
        )
        cell.contentConfiguration = contentConfig
        return cell
    }
    
}
