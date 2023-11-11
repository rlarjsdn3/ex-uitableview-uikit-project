//
//  AddItemViewController.swift
//  UITableView
//
//  Created by 김건우 on 11/10/23.
//

import UIKit

class AddItemViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func saveItem(_ sender: UIButton) {
        var text = textField.text!
        text = text.trimmingCharacters(in: .whitespaces)
        
        if text != "" {
            let lower = text.lowercased()
            // ⭐️ 문장의 각 단어를 대문자로 만듦.
            let final = lower.capitalized
            
            // 새로운 아이템을 원본 데이터에 추가하고
            let itemData = ItemsData(final, "noimage", 0, false)
            AppData.items.append(itemData)
            
            // 이렇게 만들어진 새로운 스냅샷을 데이터 소스에 적용함.
            var snapshot = NSDiffableDataSourceSnapshot<Sections, FoodsData.ID>()
            snapshot.appendSections([.main])
            snapshot.appendItems(AppData.items.map { $0.id })
            AppData.dataSource.apply(snapshot)
            
            //var currentSnapshot = AppData.dataSource.snapshot()
            //surrentSnapshot.appendItems([itemData.id])
            //AppData.dataSource.apply(currentSnapshot)
            
            // ⭐️ 사실 스냅샷에 바로 새로운 아이템을 추가해도 되지만, AppData는 데이터를 알파벳 정렬을 하고 있기 때문에,
            // AppData에 직접 데이터를 추가해 알파벳 정렬을 먼저 수행한 다음, 그렇게 만들어진 데이터로 새로운 스냅샷을 만들어 데이터 소스에 적용함.
            // (스냅샷에 바로 새로운 아이템을 추가하면 알파벳 정렬이 되지 않음 - ApplicationData.swift 파일 참고)
            
            navigationController?.popViewController(animated: true)
        }
    }
    
}
