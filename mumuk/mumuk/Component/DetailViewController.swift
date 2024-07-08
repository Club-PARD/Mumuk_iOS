//
//  FriendDetailComponent.swift
//  mumuk
//
//  Created by 유재혁 on 7/1/24.
//

//모달 띄워보려고
//class FriendDetailComponent: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .systemYellow
//        // Do any additional setup after loading the view.
//    }
//
//}




//
//  DetailViewController.swift
//  mumuk
//
//  Created by 유재혁 on 7/1/24.
//

import UIKit

class DetailViewController: UIViewController {

        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .systemYellow
            // Do any additional setup after loading the view.
        }
    
    @objc private func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}
