//
//  TabbarViewController.swift
//  mumuk
//
//  Created by 유재혁 on 6/29/24.
//

import UIKit

//class CustomTabBar: UITabBar {
//    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        
//        guard let items = self.items else { return }
//        
//        for item in items {
//            if let itemView = item.value(forKey: "view") as? UIView {
//                if let imageView = itemView.subviews.compactMap({ $0 as? UIImageView }).first {
//                    imageView.frame.origin.y = 10 // Adjust the image's y position as needed
//                }
//                if let label = itemView.subviews.compactMap({ $0 as? UILabel }).first {
//                    label.frame.origin.y = itemView.bounds.height - label.bounds.height - 40 // Adjust the label's y position as needed
//                }
//            }
//        }
//    }
//}






class TabbarViewController: UITabBarController/*, UITabBarControllerDelegate */{
    
    let image: UIImageView = {
        let image1 = UIImageView()
        image1.translatesAutoresizingMaskIntoConstraints = false
        image1.image = UIImage(named: "Logo")
        image1.tintColor = .white
        image1.contentMode = .scaleAspectFit
        image1.layer.borderColor = UIColor.white.cgColor
        image1.layer.borderWidth = 8.5 // Adjust the border width as needed
        image1.layer.cornerRadius = 40.0 // Adjust the corner radius as needed
        image1.clipsToBounds = true
        image1.layer.masksToBounds = true
        return image1
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        // Custom TabBar 적용
//        let customTabBar = CustomTabBar()
//        setValue(customTabBar, forKey: "tabBar")
//        
//        self.delegate = self // Set delegate to self
        
        view.backgroundColor = .red
        setTabBar()
        setUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        var tabFrame = self.tabBar.frame
        tabFrame.size.height = 120
        tabFrame.origin.y = self.view.frame.size.height - 120
        self.tabBar.frame = tabFrame
        
        // 탭바 아이템의 이미지 및 텍스트 위치 조정
        if let items = tabBar.items {
            for item in items {
                item.imageInsets = UIEdgeInsets(top: -100, left: 0, bottom: 100, right: 0) // 이미지 위치 조정
                item.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -30) // 텍스트 위치 조정
            }
        }
    }
    
    private func setUI() {
        view.addSubview(image)
        
        image.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            image.topAnchor.constraint(equalTo: view.topAnchor, constant: 700),
            image.widthAnchor.constraint(equalToConstant: 80),
            image.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    func setTabBar() {
        let vc1 = UINavigationController(rootViewController: FriendViewController())
        let vc2 = UINavigationController(rootViewController: MainViewController())
        let vc3 = UINavigationController(rootViewController: MyViewController())
        
        self.viewControllers = [vc1, vc2, vc3]
        self.tabBar.unselectedItemTintColor = #colorLiteral(red: 0.6465258002, green: 0.6465258002, blue: 0.6465258002, alpha: 1)
        self.tabBar.tintColor = #colorLiteral(red: 1, green: 0.5921568627, blue: 0.1019607843, alpha: 1)     //눌렸을 때 색상
        self.tabBar.backgroundColor = .white
        
        self.tabBar.layer.cornerRadius = tabBar.frame.height * 0.45
        self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        guard let tabBarItems = self.tabBar.items else {return}
        tabBarItems[0].image = UIImage(systemName: "person")?.withRenderingMode(.alwaysOriginal)
        tabBarItems[2].image = UIImage(systemName: "person.text.rectangle")?.withRenderingMode(.alwaysOriginal)
        tabBarItems[0].title = "친구 목록"
        tabBarItems[1].title = "메뉴 추천"
        tabBarItems[2].title = "MY"
    }
    
//    // UITabBarControllerDelegate method
//    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
//        guard let items = self.tabBar.items else { return }
//        
//        for item in items {
//            if let itemView = item.value(forKey: "view") as? UIView {
//                if let imageView = itemView.subviews.compactMap({ $0 as? UIImageView }).first {
//                    imageView.frame.origin.y = 10 // Adjust the image's y position as needed
//                }
//                if let label = itemView.subviews.compactMap({ $0 as? UILabel }).first {
//                    label.frame.origin.y = itemView.bounds.height - label.bounds.height - 5 // Adjust the label's y position as needed
//                }
//            }
//        }
//        
//        // 강제로 레이아웃을 다시 계산하여 선택 상태에서도 동일하게 유지되도록 합니다.
//        self.tabBar.setNeedsLayout()
//    }
}