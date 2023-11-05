//
//  EstimatedHeightViewController.swift
//  UITableView
//
//  Created by 김건우 on 11/5/23.
//

import UIKit

class SelfSizingViewController: UIViewController {

    let list = [
        "I've always been attracted to the more revolutionary changes. I don't know why. Because they're harder. They're much more stressful emotionally. And you usually go through a period where everybody tells you that you’ve completely failed.",
        "It's really hard to design products by focus groups. A lot of times, people don't know what they want until you show it to them.",
        "Be a yardstick of quality. Some people aren't used to an environment where excellence is expected."
    ]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }

}

extension SelfSizingViewController: UITableViewDelegate {
    
    // ⭐️ 아래 두 메서드 모두 구현해야 성능이 좋아질 수 있음.
    
    // ⭐️ 셀의 높이 값을 지정하는 델리게이트 메서드
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    // ⭐️ 셀의 예상 높이 값을 지정하는 델리게이트 메서드
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

extension SelfSizingViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var contentConfig = cell.defaultContentConfiguration()
        contentConfig.text = list[indexPath.row]
        cell.contentConfiguration = contentConfig
        return cell
    }
    
}
