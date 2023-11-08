//
//  CheckMarkTableViewCell.swift
//  UITableView
//
//  Created by 김건우 on 11/5/23.
//

import UIKit

class SwitchTableViewCell: UITableViewCell {

    // ⭐️ 초기화 메서드
    // Xib 혹은 스토리보드없이 코드로 셀을 구현하는 경우, 아래 메서드는 호출되지 않음 (대신 init 사용)
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let switchView = UISwitch(frame: .zero)
        accessoryView = switchView
    }

}
