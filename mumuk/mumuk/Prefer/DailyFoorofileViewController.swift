//
//  DailyFoorofileViewController.swift
//  mumuk
//
//  Created by 김민준 on 7/3/24.
//

import UIKit

class DailyFoorofileViewController : UIViewController {
    
    let mainLabel : UILabel = {
        let label =  UILabel()
        
        label.text = "오늘의 FOOROFILE\n 이 생성되었어요!"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 25, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setUI()
    
    }
    
    func setUI(){
        view.addSubview(mainLabel)
        
        
        
        NSLayoutConstraint.activate([
            mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 42.1),
            
        
        
        ])
        
        
    }
    
    
    
    
}
