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
        
        if selected != nil {
            titleItem.text = selected.name
            imageItem.image = UIImage(named: selected.image)
            nutritionItem.text = "Calories: \(selected.calories)"
        }
        navigationItem.title = "Detail"
    }

}
