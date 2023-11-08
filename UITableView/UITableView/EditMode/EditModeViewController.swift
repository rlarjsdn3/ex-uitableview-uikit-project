//
//  EditModeViewController.swift
//  UITableView
//
//  Created by 김건우 on 11/5/23.
//

import UIKit

class EditModeViewController: UIViewController {

    var selectedList = [String]()
    var productList = ["iMac Pro", "iMac 5K", "Macbook Pro", "iPad Pro", "iPhone X", "Mac mini", "Apple TV", "Apple Watch"]
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func EditButtonPressed(_ sender: UIBarButtonItem) {
        // ⭐️ 테이블 뷰를 편집 모드로 전환하는 메서드
        tableView.setEditing(!tableView.isEditing, animated: true)
    }

}

extension EditModeViewController: UITableViewDelegate {
    
    // ⭐️ 셀이 편집 모드로 전환 허용 유무를 결정하는 델리게이트 메서드
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // ⭐️ 셀에 대한 편집 동작을 처리하는 델리게이트 메서드
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            let target = selectedList[indexPath.row]
            let insertIndexPath = IndexPath(row: productList.count, section: 1)
            
            // ⭐️
            // 테이블 뷰에 셀을 추가하거나 삭제할 때,
            // 원본 데이터의 수와 셀의 수를 확인하고, 그 수가 서로 다르다면 오류가 발생함!
            
            // 그러므로, 원본 데이터를 먼저 삭제하고, 테이블 뷰의 셀을 편집해야 함.
            
            productList.append(target)
            selectedList.remove(at: indexPath.row)
            
//            tableView.beginUpdates()
            tableView.performBatchUpdates {
                tableView.insertRows(at: [insertIndexPath], with: .automatic)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
//            tableView.endUpdates()
        case .insert:
            let target = productList[indexPath.row]
            let insertIndexPath = IndexPath(row: selectedList.count, section: 0)
            
            selectedList.append(target)
            productList.remove(at: indexPath.row)
            
            tableView.performBatchUpdates {
                tableView.insertRows(at: [insertIndexPath], with: .automatic)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        default:
            break
        }
    }
    
    // ⭐️ 편집 모드가 시작되기 전에 호출되는 델리게이트 메서드
    func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
        print(#function)
    }
    
    // ⭐️ 편집 모드가 종료된 후에 호출되는 델리게이트 메서드
    func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
        print(#function)
    }
    
}

extension EditModeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return selectedList.count
        case 1:
            return productList.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var contentConfig = cell.defaultContentConfiguration()
        
        switch indexPath.section {
        case 0:
            contentConfig.text = selectedList[indexPath.row]
        case 1:
            contentConfig.text = productList[indexPath.row]
        default:
            break
        }
        cell.contentConfiguration = contentConfig
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Wish List"
        case 1:
            return "Product List"
        default:
            return nil
        }
    }
    
    // ⭐️ 셀이 어떤 편집 동작을 가질지 결정하는 델리게이트 메서드
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        switch indexPath.section {
        case 0:
            return .delete
        case 1:
            return .insert
        default:
            return .none
        }
    }
    
    // ⭐️ 스와이프 삭제 버튼의 타이틀을 변경하는 델리게이트 메서드
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "삭제⭐️"
    }
    
}
