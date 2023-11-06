//
//  SectionIndexViewController.swift
//  UITableView
//
//  Created by 김건우 on 11/5/23.
//

import UIKit

class SectionIndexViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let list = RandomNumber.generateData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorStyle = .none
    }

}

extension SectionIndexViewController: UITableViewDelegate { }

extension SectionIndexViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list[section].numbers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        var contentConfig = cell.defaultContentConfiguration()
        var number = list[indexPath.section].numbers[indexPath.row]
        contentConfig.text = String(number)
        
        var backgroundConfig = cell.defaultBackgroundConfiguration()
        backgroundConfig.backgroundColor = UIColor.secondarySystemBackground
        backgroundConfig.backgroundInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
        backgroundConfig.cornerRadius = 10.0
        
        cell.contentConfiguration = contentConfig
        cell.backgroundConfiguration = backgroundConfig
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return String(list[section].tensDigit)
    }
    
    // ⭐️ 섹션 인덱스의 타이틀을 설정하는 델리게이트 메서드
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
//        return list.map { String($0.tensDigit) }
        return stride(from: 0, to: list.count, by: 2)
            .map { String(list[$0].tensDigit) }
    }
    
    // ⭐️ 섹션 인덱스의 타이틀이 선택되어 이동하기 직전에 호출되는 델리게이트 메서드
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
//        return index
        return index * 2
    }
    
}
