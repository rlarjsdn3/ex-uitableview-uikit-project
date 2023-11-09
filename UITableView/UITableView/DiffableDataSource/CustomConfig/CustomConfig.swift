//
//  CustomConfig.swift
//  UITableView
//
//  Created by 김건우 on 11/9/23.
//

import UIKit

struct CustomConfig: UIContentConfiguration {
    
    var name: String!
    var picture: UIImage!
    
    func makeContentView() -> UIView & UIContentView {
        let content = CustomContentView(configuration: self)
        return content
    }
    
    func updated(for state: UIConfigurationState) -> CustomConfig {
        return self
    }
    
}

class CustomContentView: UIView, UIContentView {
    
    let picture = UIImageView(frame: .zero)
    let name = UILabel(frame: .zero)
    
    // ⭐️ 설정이 바뀌면 바뀐 내용을 셀에 반영해야 함.
    var configuration: UIContentConfiguration {
        didSet {
            newConfiguration()
        }
    }
    
    init(configuration: UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
        
        picture.translatesAutoresizingMaskIntoConstraints = false
        picture.contentMode = .scaleAspectFit
        self.addSubview(picture)
        
        let cp1 = picture.widthAnchor.constraint(equalToConstant: 100)
        let cp2 = picture.heightAnchor.constraint(equalToConstant: 100)
        let cp3 = picture.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        let cp4 = picture.topAnchor.constraint(equalTo: self.topAnchor, constant: 10)
        let cp5 = picture.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        self.addConstraints([cp1, cp2, cp3, cp4, cp5])
        
        name.translatesAutoresizingMaskIntoConstraints = false
        name.numberOfLines = 1
        name.font = UIFont.preferredFont(forTextStyle: .title1)
        self.addSubview(name)
        
        let cn1 = name.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
        let cn2 = name.trailingAnchor.constraint(equalTo: picture.leadingAnchor, constant: 0)
        let cn3 = name.centerYAnchor.constraint(equalTo: picture.centerYAnchor)
        self.addConstraints([cn1, cn2, cn3])
        
        newConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func newConfiguration() {
        if let config = self.configuration as? CustomConfig {
            picture.image = config.picture
            name.text = config.name
        }
    }
    
}
