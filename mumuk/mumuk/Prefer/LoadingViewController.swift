//
//  LoadingViewController.swift
//  mumuk
//
//  Created by 김민준 on 7/2/24.
//

import UIKit

class LoadingViewController : UIViewController {
    
    var uid : String?
    var name : String? 
    
    let textLabel : UILabel = {
        let label = UILabel()
        label.text = "선호도를 반영한\n DAILY FOOROFILE이\n 완성되고 있어요"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 25, weight: .regular)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(textLabel)
        
        
        
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 327),
            textLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 63.2),
        
        
        ])
    }
}
