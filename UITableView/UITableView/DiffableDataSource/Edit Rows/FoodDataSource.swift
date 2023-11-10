//
//  FoodDataSource.swift
//  UITableView
//
//  Created by 김건우 on 11/10/23.
//

import UIKit

// ⭐️ UITableViewDiffableDataSource 클래스는 UITableViewDataSourceDelegate 프로토콜을 준수하고 있음.
class FoodDataSource: UITableViewDiffableDataSource<Sections, ItemsData.ID> {
    
    // ⭐️ 셀이 편집 모드로 전환 허용 유무를 결정하는 델리게이트 메서드
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // ⭐️ 셀에 대한 편집 동작을 처리하는 델리게이트 메서드
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            if let itemID = self.itemIdentifier(for: indexPath) {
                AppData.items.removeAll(where: { $0.id == itemID })
                
                var currentSnapshot = self.snapshot()
                currentSnapshot.deleteItems([itemID])
                self.apply(currentSnapshot)
            }
        }
    }
    
    // ⭐️ 셀이 이동 동작을 가질지 결정하는 델리게이트 메서드
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // ⭐️ 셀을 선택하고 드롭하면 호출되는 델리게이트 메서드
    // 원본 데이터 모델을 업데이트하고 이동한 셀의 위치를 변경함.
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let item = AppData.items[sourceIndexPath.row]
        AppData.items.remove(at: sourceIndexPath.row)
        AppData.items.insert(item, at: destinationIndexPath.row)
        
        if let itemOrigin = self.itemIdentifier(for: sourceIndexPath),
           let itemDestination = self.itemIdentifier(for: destinationIndexPath) {
            var currentSnapshot = self.snapshot()
            // 출발지 IndexPath가 목적지 IndexPath보다 더 클 때
            // (셀을 원래 위치보다 위로 위치할 때)
            if sourceIndexPath.row > destinationIndexPath.row {
                currentSnapshot.moveItem(itemOrigin, beforeItem: itemDestination)
            // 출발지 IndexPath가 목적지 IndexPath보다 더 작을 때
            // (셀을 원래 위치보다 아래로 위치할 때)
            } else {
                currentSnapshot.moveItem(itemOrigin, afterItem: itemDestination)
            }
            self.apply(currentSnapshot)
        }
        
    }
    
}
