import UIKit

class TabbarViewController: UITabBarController, UITabBarControllerDelegate {
    var mainViewController: MainViewController?
    var myViewController: MyViewController?
    var friendViewController: FriendViewController?

    let logoImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "Logo")
        image.tintColor = .white
        image.contentMode = .scaleAspectFit
        image.layer.borderColor = UIColor.white.cgColor
        image.layer.borderWidth = 8.5
        image.layer.cornerRadius = 40
        image.clipsToBounds = true
        image.layer.masksToBounds = true
        image.isUserInteractionEnabled = true
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        setTabBar()
        addLogoToTabBar()
        customizeTabBarAppearance()  // 새로운 메서드 호출
        
        self.delegate = self  // Set the delegate
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(logoTapped))
        logoImage.addGestureRecognizer(tapGesture)
        
        tabBar.itemPositioning = .centered
        tabBar.itemSpacing = 100
        
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOffset = CGSize(width: 0, height: -3)
        tabBar.layer.shadowOpacity = 0.1
        tabBar.layer.shadowRadius = 5
        tabBar.layer.masksToBounds = false
        
        selectedIndex = 1
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        var tabFrame = self.tabBar.frame
        tabFrame.size.height = 105
        tabFrame.origin.y = self.view.frame.size.height - 105
        self.tabBar.frame = tabFrame
        
        if let items = tabBar.items {
            for (index, item) in items.enumerated() {
                if index == 0 {
                    item.titlePositionAdjustment = UIOffset(horizontal: 15, vertical: 2)
                }
                if index == 2 {
                    item.titlePositionAdjustment = UIOffset(horizontal: -15, vertical: 2)
                }
            }
        }
        
        logoImage.center = CGPoint(x: tabBar.center.x, y: tabBar.frame.minY - 30)
    }
    
    private func customizeTabBarAppearance() {
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
        tabBar.clipsToBounds = true
    }
    
    private func addLogoToTabBar() {
        tabBar.addSubview(logoImage)
        
        NSLayoutConstraint.activate([
            logoImage.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor),
            logoImage.centerYAnchor.constraint(equalTo: tabBar.topAnchor, constant: 17),
            logoImage.widthAnchor.constraint(equalToConstant: 80),
            logoImage.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    func setTabBar() {
        let friendVC = FriendViewController()
        self.friendViewController = friendVC
        let vc1 = UINavigationController(rootViewController: friendVC)
        
        let mainVC = MainViewController()
        self.mainViewController = mainVC
        let vc2 = UINavigationController(rootViewController: mainVC)
        
        let myVC = MyViewController()
        self.myViewController = myVC
        let vc3 = UINavigationController(rootViewController: myVC)
        
        self.viewControllers = [vc1, vc2, vc3]
        self.tabBar.unselectedItemTintColor = #colorLiteral(red: 0.6465258002, green: 0.6465258002, blue: 0.6465258002, alpha: 1)
        self.tabBar.tintColor = #colorLiteral(red: 1, green: 0.5921568627, blue: 0.1019607843, alpha: 1)
        self.tabBar.backgroundColor = .white
        
        self.tabBar.layer.cornerRadius = tabBar.frame.height * 0.45
        self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        guard let tabBarItems = self.tabBar.items else { return }
        
        let personConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .regular, scale: .default)
        tabBarItems[0].image = UIImage(systemName: "person", withConfiguration: personConfig)?.withRenderingMode(.alwaysTemplate)
        tabBarItems[1].image = UIImage(systemName: "circle.fill")?.withRenderingMode(.alwaysTemplate)
        tabBarItems[2].image = UIImage(systemName: "person.text.rectangle", withConfiguration: personConfig)?.withRenderingMode(.alwaysTemplate)
        
        tabBarItems[0].title = "친구"
        tabBarItems[1].title = "HOME"
        tabBarItems[2].title = "내 푸로필"
        
        tabBarItems.forEach { item in
            item.setTitleTextAttributes([.font: UIFont.pretendard(.bold, size: 13)], for: .normal)
            item.setTitleTextAttributes([.font: UIFont.pretendard(.bold, size: 13)], for: .selected)
        }
        
        // 메뉴 추천(중앙 탭) 설정
        tabBarItems[1].isEnabled = true
        tabBarItems[1].imageInsets = UIEdgeInsets(top: -1, left: 0, bottom: -40, right: 0)
        tabBarItems[1].titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 3)
    }
    
    @objc func logoTapped() {
        selectedIndex = 1
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if let navController = viewController as? UINavigationController {
            if let friendVC = navController.viewControllers.first as? FriendViewController,
               let mainVC = self.mainViewController {
                friendVC.name = mainVC.name!
                friendVC.fetchMembers()
            } else if let myVC = navController.viewControllers.first as? MyViewController,
                      let mainVC = self.mainViewController {
                // MainViewController에서 MyViewController로 데이터 전달
                myVC.name = mainVC.name!
                
                myVC.uid = mainVC.uid
                myVC.deepProfile()
//                myVC.Profiletag()
            }
        }
    }
}
