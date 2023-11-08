//
//  ReorderingViewController.swift
//  UITableView
//
//  Created by 김건우 on 11/5/23.
//

import UIKit

class ReorderingViewController: UIViewController {

    var shoppingList = [String]()
    var wishList = [String]()
    var productList = ["iMac Pro", "iMac 5K", "Macbook Pro", "iPad Pro", "iPhone X", "Mac mini", "Apple TV", "Apple Watch"]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.setEditing(true, animated: false)
    }
    
    

}

extension ReorderingViewController: UITableViewDelegate {
    
    // ⭐️ 아래 두 메서드는 이렇게 작동합니다.
    // tableView(_:targetIndexPathForMoveFromRowAt:toProposedIndexPath:)
    // tableView(_:targetIndexPathForMoveFromRowAt:toProposedIndexPath:)
    // tableView(_:targetIndexPathForMoveFromRowAt:toProposedIndexPath:)
    // tableView(_:moveRowAt:to:)
    // 셀을 클릭하고 셀과 셀 사이에 이동할 때는 tableView(_:targetIndexPathForMoveFromRowAt:toProposedIndexPath:) 메서드가 반복해서 호출되고,
    // 셀을 드롭하면 tableView(_:moveRowAt:to:)을 호출해 원본 데이터 모델을 업데이트합니다.
    
    // ⭐️ 셀을 선택하고 드롭하면 호출되는 델리게이트 메서드
    // 원본 데이터 모델을 업데이트하고 이동한 셀의 위치를 변경함.
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        var target: String?
        
        switch sourceIndexPath.section {
        case 0:
            target = shoppingList.remove(at: sourceIndexPath.row)
        case 1:
            target = wishList.remove(at: sourceIndexPath.row)
        case 2:
            target = productList.remove(at: sourceIndexPath.row)
        default:
            break
        }
        
        guard let item = target else { return }
        
        switch destinationIndexPath.section {
        case 0:
            shoppingList.insert(item, at: destinationIndexPath.row)
        case 1:
            wishList.insert(item, at: destinationIndexPath.row)
        case 2:
            productList.insert(item, at: destinationIndexPath.row)
        default:
            break
        }
    }
    
    // ⭐️ 셀을 다른 셀 사이로 이동하면 호출되는 델리게이트 메서드
    // 셀의 이동을 제한하거나 사용자가 셀을 특정 위치로 이동하도록 가이드할 수 있음.
    func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        // 'Shopping List'로 셀을 이동시키려고 한다면
        if proposedDestinationIndexPath.section == 0 {
            // 원래 위치해있던 섹션으로 강제 이동 시킴
            return sourceIndexPath
        }
        return proposedDestinationIndexPath
    }
}

extension ReorderingViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return shoppingList.count
        case 1:
            return wishList.count
        case 2:
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
            contentConfig.text = shoppingList[indexPath.row]
        case 1:
            contentConfig.text = wishList[indexPath.row]
        case 2:
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
            return "Shopping List"
        case 1:
            return "Wish List"
        case 2:
            return "Product List"
        default:
            return nil
        }
    }
    
    // ⭐️ 셀이 어떤 편집 동작을 가질지 결정하는 델리게이트 메서드
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    // ⭐️ 셀이 편집 모드일 때 앞에 여백을 둘지 유무를 결정하는 델리게이트 메서드
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    // ⭐️ 셀이 이동 동작을 가질지 결정하는 델리게이트 메서드
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
}
