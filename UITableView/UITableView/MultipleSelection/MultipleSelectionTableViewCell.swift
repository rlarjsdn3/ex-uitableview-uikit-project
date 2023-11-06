//
//  MultipleSelectionTableViewCell.swift
//  UITableView
//
//  Created by 김건우 on 11/6/23.
//

import UIKit

class MultipleSelectionTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    // ⭐️ 선택 상태가 바뀌거나, 셀이 재사용되면 호출되는 메소드
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        accessoryType = selected ? .checkmark : .none
    }
    
    // ⭐️ 강조 상태가 바뀌거나, 셀이 재사용되면 호출되는 메서드
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
    }

}
