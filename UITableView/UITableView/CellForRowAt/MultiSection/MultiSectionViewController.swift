//
//  MultiSectionViewController.swift
//  UITableView
//
//  Created by 김건우 on 11/5/23.
//

import UIKit

class MultiSectionViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let list = PhotosSettingSection.generateData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        // ❗️ style 프로퍼티는 읽기 전용임(init(frame:, style:)를 대신 사용)
//        tableView.style = .grouped
        tableView.backgroundColor = UIColor.secondarySystemBackground
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    @objc func toggleHiddenAlbum(_ sender: UISwitch) {
        print(#function)
    }
    
    @objc func toggleAutoPlayVideos(_ sender: UISwitch) {
        print(#function)
    }
    
    @objc func toggleSummarizePhotos(_ sender: UISwitch) {
        print(#function)
    }
    
    @objc func toggleShowHolidayEvent(_ sender: UISwitch) {
        print(#function)
    }

}

extension MultiSectionViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 0 {
            performSegue(withIdentifier: "goToMain", sender: self)
        }
    }
    
}

extension MultiSectionViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let target = list[indexPath.section].items[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: target.type.rawValue, for: indexPath)
        var contentConfig = cell.defaultContentConfiguration()
        var backgroundConfig = cell.defaultBackgroundConfiguration()
        contentConfig.text = target.title
        backgroundConfig.backgroundColor = UIColor.systemBackground
        
        switch target.type {
        case .action:
            contentConfig.attributedText = NSAttributedString(
                string: target.title,
                attributes: [
                    .foregroundColor: UIColor.systemBlue
                ])
        case .checkmark:
            cell.accessoryType = target.on ? .checkmark : .none
        case .disclosure:
            cell.accessoryType = .disclosureIndicator
            contentConfig.image = UIImage(systemName: target.imageName ?? "")
        case .switch:
            if let switchView = cell.accessoryView as? UISwitch {
                switchView.isOn = target.on
                
                if indexPath.section == 1 && indexPath.row == 0 {
                    switchView.addTarget(self, action: #selector(toggleHiddenAlbum(_:)), for: .valueChanged)
                }
                if indexPath.section == 2 && indexPath.row == 0 {
                    switchView.addTarget(self, action: #selector(toggleAutoPlayVideos(_:)), for: .valueChanged)
                }
                if indexPath.section == 2 && indexPath.row == 1 {
                    switchView.addTarget(self, action: #selector(toggleSummarizePhotos(_:)), for: .valueChanged)
                }
                if indexPath.section == 3 && indexPath.row == 1 {
                    switchView.addTarget(self, action: #selector(toggleShowHolidayEvent(_:)), for: .valueChanged)
                }
            }
        }
        
        cell.contentConfiguration = contentConfig
        return cell
    }
    
    // ⭐️ 각 센셩에 헤더 타이틀을 붙여주는 델리게이트 메서드
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return list[section].header
    }
    
    // ⭐️ 각 섹션에 푸터 타이틀을 붙여주는 델리게이트 메서드
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return list[section].footer
    }
    
}
