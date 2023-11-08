//
//  Landscape.swift
//  UITableView
//
//  Created by 김건우 on 11/8/23.
//

import UIKit

class Landscape {
    let urlString: String
    var url: URL {
        guard let url = URL(string: urlString) else {
            fatalError("invalid URL")
        }
        return url
    }
    var image: UIImage?
    
    init(urlString: String) {
        self.urlString = urlString
    }
    
    static func generateData() -> [Landscape] {
        return (1...36).map { Landscape(urlString: "https://kxcodingblob.blob.core.windows.net/mastering-ios/\($0).jpg") }
    }
}
