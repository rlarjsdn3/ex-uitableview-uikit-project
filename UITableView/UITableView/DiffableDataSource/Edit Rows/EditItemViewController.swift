//
//  EditItemViewController.swift
//  UITableView
//
//  Created by 김건우 on 11/10/23.
//

import UIKit

class EditItemViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    var selected: ItemsData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if selected != nil {
            textField.text = selected.name
            textField.becomeFirstResponder()
        }
    }
    
    @IBAction func editButtonPressed(_ sender: Any) {
        var text = textField.text!
        text = text.trimmingCharacters(in: .whitespaces)
        
        if text != "" {
            let lower = text.lowercased()
            let final = lower.capitalized
            selected.name = final
            
            var currentSnapshot = AppData.dataSource.snapshot()
            currentSnapshot.reloadItems([selected.id])
            AppData.dataSource.apply(currentSnapshot)
            
            navigationController?.popViewController(animated: true)
        }
    }
    
}
