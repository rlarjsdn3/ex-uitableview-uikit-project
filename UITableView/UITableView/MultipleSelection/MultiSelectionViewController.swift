//
//  MultiSelectionViewController.swift
//  UITableView
//
//  Created by 김건우 on 11/5/23.
//

import UIKit

class MultipleSelectionViewController: UIViewController {

    let list = RandomNumber.generateData()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        // ⭐️ 다중 셀 선택을 가능핟도록 함.
        tableView.allowsMultipleSelection = true
    }
    
    @IBAction func showReport(_ sender: UIBarButtonItem) {
        if let indexPathList = tableView.indexPathsForSelectedRows {
            let selectedNumbers = indexPathList.map {
                String(list[$0.section].numbers[$0.row])
            }.joined(separator: ", ")
            showAlert(selectedNumbers)
        }
    }
    
    func showAlert(_ string: String) {
        let alert = UIAlertController(title: "선택된 숫자", message: "\(string)", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "확인", style: .default)
        alert.addAction(okAction)
        
        present(alert, animated: true)
    }

}

extension MultipleSelectionViewController: UITableViewDelegate { }

extension MultipleSelectionViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list[section].numbers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var contentConfig = cell.defaultContentConfiguration()
        let number = String(list[indexPath.section].numbers[indexPath.row])
        contentConfig.text = "\(number)"
        cell.contentConfiguration = contentConfig
        return cell
    }
    
}
