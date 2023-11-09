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
        contentConfig.secondaryText = "\(item.calories) Calories"
        contentConfig.image = UIImage(named: item.image)
        contentConfig.imageProperties.maximumSize = CGSize(width: 60, height: 60)
        // ⭐️
        contentConfig.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 50, bottom: 0, trailing: 0)
        self.contentConfiguration = contentConfig
    }

}
