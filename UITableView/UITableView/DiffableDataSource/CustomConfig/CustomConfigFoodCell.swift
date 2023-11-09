//
//  CustomConfigFoodCell.swift
//  UITableView
//
//  Created by 김건우 on 11/9/23.
//

import UIKit

class CustomConfigFoodCell: UITableViewCell {
    
    var item: ItemsData!
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        var config = CustomConfig().updated(for: state)
        config.name = item.name
        config.picture = UIImage(named: item.image)
        self.contentConfiguration = config
    }

}
