//
//  CustomCellTableViewController.swift
//  UITableView
//
//  Created by 김건우 on 11/5/23.
//

import UIKit

class CustomCellTableViewController: UIViewController {

    let list = [("iPhone 15", "$699"), ("iPhone 15 Plus", "$799"), ("iPhone 15 Pro", "$899"), ("iPhone 15 Pro Max", "$999")]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    }

}

extension CustomCellTableViewController: UITableViewDelegate { }

extension CustomCellTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        cell.mainLabel?.text = list[indexPath.row].0
        cell.secondaryLabel?.text = list[indexPath.row].1
        return cell
    }
    
}
