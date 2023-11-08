//
//  FoodCell.swift
//  UITableView
//
//  Created by 김건우 on 11/8/23.
//

import UIKit

class FoodCell: UITableViewCell {
    
    var item: ItemsData!
    
    // ⭐️ 셀의 상태가 변하거나, 처음 생성되면 호출되는 메서드
    override func updateConfiguration(using state: UICellConfigurationState) {
        var contentConfig = self.defaultContentConfiguration()
        contentConfig.text = item.name
        self.contentConfiguration = contentConfig
    }

}
