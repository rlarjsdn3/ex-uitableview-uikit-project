//
//  PrefetchingViewController.swift
//  UITableView
//
//  Created by 김건우 on 11/5/23.
//

import UIKit

class PrefetchingViewController: UIViewController {

    var list = Landscape.generateData()
    var downloadTasks = [URLSessionTask]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        
        tableView.separatorStyle = .none
    }

}

extension PrefetchingViewController: UITableViewDelegate { }

extension PrefetchingViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ImageTableViewCell
        
        if let image = list[indexPath.row].image {
            cell.imageCell.image = image
        } else {
            cell.imageCell.image = nil
            downloadImage(at: indexPath.row)
        }
        cell.label.text = "#\(indexPath.row + 1)"
        return cell
    }
    
}

extension PrefetchingViewController: UITableViewDataSourcePrefetching { 
    
    // ⭐️ 셀을 사전 로드하게 도와주는 델리게이트 메서드
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            downloadImage(at: indexPath.row)
        }
    }
    
    // ⭐️ 셀이 사전 로드를 취소한다면 호출되는 델리게이트 메서드
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            cancelDownload(at: indexPath.row)
        }
    }
    
}

extension PrefetchingViewController {
    
    func downloadImage(at index: Int) {
        // 다운로드된 이미지가 있는지 확인
        guard list[index].image == nil else {
            return
        }
        
        let targetUrl = list[index].url
        // 동일한 이미지를 불러오는 작업이 존재하는지 확인 / 중복 다운로드 방지
        guard !downloadTasks.contains(where: { $0.originalRequest?.url == targetUrl }) else {
            return
        }
        
        print(#function, index)
        
        let task = URLSession.shared.dataTask(with: targetUrl) { [weak self] (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            if let data = data, let image = UIImage(data: data), let strongSelf = self {
                strongSelf.list[index].image = image
                let reloadTargetIndexPath = IndexPath(row: index, section: 0)
                DispatchQueue.main.async {
                    if strongSelf.tableView.indexPathsForVisibleRows?.contains(reloadTargetIndexPath) == true {
                        strongSelf.tableView.reloadRows(at: [reloadTargetIndexPath], with: .automatic)
                    }
                }
                
                strongSelf.completeTask()
            }
        }
        task.resume()
        downloadTasks.append(task)
    }
    
    
    func completeTask() {
        downloadTasks = downloadTasks.filter { $0.state != .completed }
    }
    
    
    func cancelDownload(at index: Int) {
        let targetUrl = list[index].url
        guard let taskIndex = downloadTasks.firstIndex(where: { $0.originalRequest?.url == targetUrl }) else {
            return
        }
        let task = downloadTasks[taskIndex]
        task.cancel()
        downloadTasks.remove(at: taskIndex)
    }
    
}
