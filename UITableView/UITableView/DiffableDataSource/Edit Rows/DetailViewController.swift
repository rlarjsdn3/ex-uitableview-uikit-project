//
//  DetailViewController.swift
//  UITableView
//
//  Created by 김건우 on 11/9/23.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var titleItem: UILabel!
    @IBOutlet weak var imageItem: UIImageView!
    @IBOutlet weak var nutritionItem: UITextView!
    var selected: ItemsData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if selected != nil {
            titleItem.text = selected.name
            imageItem.image = UIImage(named: selected.image)
            nutritionItem.text = "Calories: \(selected.calories)"
        }
        navigationItem.title = "Detail"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToEditItemVC" {
            let controller = segue.destination as! EditItemViewController
            controller.selected = selected
        }
    }
    
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        if selected != nil {
            // 원본 데이터에서 아이템을 삭제하고
            AppData.items.removeAll(where: { $0.id == selected.id })
            
            // 스냅샷에도 이를 반영하고, 데이터 소스에 적용함.
            var currentSnapshot = AppData.dataSource.snapshot()
            currentSnapshot.deleteItems([selected.id])
            AppData.dataSource.apply(currentSnapshot)
            
            navigationController?.popViewController(animated: true)
        }
    }

    @IBAction func editItemButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "goToEditItemVC", sender: self)
    }
    
}
