//
//  CustomFoodCell.swift
//  UITableView
//
//  Created by 김건우 on 11/9/23.
//

import UIKit

class CustomFoodCell: UITableViewCell {
    
    private var customView: UIListContentView!
    private var customButton: UIButton!
    var item: ItemsData!
    var appData: ApplicationData!
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        createView()
        
        if let configuration = self.customView.configuration as? UIListContentConfiguration {
            var contentConfig = configuration.updated(for: state)
            contentConfig.text = item.name
            contentConfig.secondaryText = "Calories: \(item.calories)"
            contentConfig.image = UIImage(named: item.image)
            contentConfig.imageProperties.maximumSize = CGSize(width: 60, height: 60)
            
            self.customView.configuration = contentConfig
        }
    }
    
    // ⭐️ UIListContentView를 ContentView에 제약을 걸어 휴지통 버튼이 들어갈 별도 공간을 만드는 예제
    // 이렇게 하면 기본 형식을 유지하면서, 내가 원하는 뷰를 추가해 셀을 꾸밀 수 있음.
    func createView() {
        // (재사용 메커니즘에 의해) 이미 뷰가 만들어져 있으면, 다시 만들지 않기 위해 별도 체크를 함.
        guard contentView.viewWithTag(999) == nil else { return }
        
        customView = UIListContentView(configuration: .subtitleCell())
        customView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(customView)
        
        customView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8).isActive = true
        customView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16).isActive = true
        customView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8).isActive = true
        
        customButton = UIButton(configuration: .plain(), primaryAction: UIAction(image: UIImage(systemName: "trash"), handler: { [unowned self] action in
            self.eraseItem()
        }))
        customButton.translatesAutoresizingMaskIntoConstraints = false
        customButton.tag = 999
        self.contentView.addSubview(customButton)
        
        customButton.leadingAnchor.constraint(equalTo: customView.trailingAnchor, constant: 8).isActive = true
        customButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16).isActive = true
        customButton.centerYAnchor.constraint(equalTo: customView.centerYAnchor).isActive = true
        customButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        customButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func eraseItem() {
        appData.items.removeAll(where: { $0.id == item.id })
        
        var currentSnapshot = appData.dataSource.snapshot()
        currentSnapshot.deleteItems([item.id])
        appData.dataSource.apply(currentSnapshot)
    }
    
}
