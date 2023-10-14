//
//  ViewController.swift
//  UITableView
//
//  Created by 김건우 on 10/14/23.
//

import UIKit

class ViewController: UIViewController {

    let tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var characters = ["A", "B", "C", "D", "E", "F", "G"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDelegate()
        setupTableView()
        
        view.backgroundColor = UIColor.white
        navigationItem.rightBarButtonItem = editButtonItem
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        tableView.setEditing(!tableView.isEditing, animated: animated)
    }
    
    func setupDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }

    func setupTableView() {
        let safeArea = view.safeAreaLayoutGuide
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.selectionStyle = .none
        cell.textLabel?.text = characters[indexPath.row]
        return cell
    }

}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(characters[indexPath.row])가 선택됨.")
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let likeAction = UIContextualAction(style: .normal, title: "좋아요") { (action, view, success: @escaping (Bool) -> Void) in
            print("좋아요가 선택됨.")
            success(true)
        }
        likeAction.image = UIImage(systemName: "hand.thumbsup")
        likeAction.backgroundColor = UIColor.systemBlue
        
        let shareAction = UIContextualAction(style: .normal, title: "공유") { (action, view, success: @escaping (Bool) -> Void) in
            print("공유가 선택됨.")
            success(true)
        }
        shareAction.backgroundColor = UIColor.systemMint
        shareAction.image = UIImage(systemName: "square.and.arrow.up")
        
        let configuration = UISwipeActionsConfiguration(actions: [shareAction, likeAction])
        return configuration
        
    }
    
//    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            characters.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        characters.swapAt(sourceIndexPath.row, destinationIndexPath.row)
    }
    
}


