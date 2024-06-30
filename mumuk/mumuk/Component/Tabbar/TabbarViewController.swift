import UIKit

class TabbarViewController: UITabBarController {
    
    let logoImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "Logo")
        image.tintColor = .white
        image.contentMode = .scaleAspectFit
        image.layer.borderColor = UIColor.white.cgColor
        image.layer.borderWidth = 12.5
        image.layer.cornerRadius = 50
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
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(logoTapped))
        logoImage.addGestureRecognizer(tapGesture)
        
        tabBar.itemPositioning = .centered
        tabBar.itemSpacing = 100
        
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOffset = CGSize(width: 0, height: -3)
        tabBar.layer.shadowOpacity = 0.1
        tabBar.layer.shadowRadius = 5
        tabBar.layer.masksToBounds = false
        
        // vc2를 기본 선택 탭으로 설정
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
                if index != 1 {
                    item.imageInsets = UIEdgeInsets(top: -19, left: 0, bottom: 19, right: 0)
                    item.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 5)
                }
            }
        }
        
        logoImage.center = CGPoint(x: tabBar.center.x, y: tabBar.frame.minY - 34)
    }
    
    private func addLogoToTabBar() {
        tabBar.addSubview(logoImage)
        
        NSLayoutConstraint.activate([
            logoImage.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor),
            logoImage.centerYAnchor.constraint(equalTo: tabBar.topAnchor, constant: 12),
            logoImage.widthAnchor.constraint(equalToConstant: 100),
            logoImage.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func setTabBar() {
        let vc1 = UINavigationController(rootViewController: FriendViewController())
        let vc2 = UINavigationController(rootViewController: MainViewController())
        let vc3 = UINavigationController(rootViewController: MyViewController())
        
        self.viewControllers = [vc1, vc2, vc3]
        self.tabBar.unselectedItemTintColor = #colorLiteral(red: 0.6465258002, green: 0.6465258002, blue: 0.6465258002, alpha: 1)
        self.tabBar.tintColor = #colorLiteral(red: 1, green: 0.5921568627, blue: 0.1019607843, alpha: 1)
        self.tabBar.backgroundColor = .white
        
        self.tabBar.layer.cornerRadius = tabBar.frame.height * 0.45
        self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        guard let tabBarItems = self.tabBar.items else { return }
        
        // 이미지 크기 조정
        let personConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .regular, scale: .default)
        tabBarItems[0].image = UIImage(systemName: "person", withConfiguration: personConfig)?.withRenderingMode(.alwaysTemplate)
        tabBarItems[1].image = UIImage(systemName: "circle.fill")?.withRenderingMode(.alwaysTemplate)
        tabBarItems[2].image = UIImage(systemName: "person.text.rectangle", withConfiguration: personConfig)?.withRenderingMode(.alwaysTemplate)
        
        tabBarItems[0].title = "친구 목록"
        tabBarItems[1].title = "메뉴 추천"
        tabBarItems[2].title = "MY"
        
        tabBarItems.forEach { item in
            item.setTitleTextAttributes([.font: UIFont.pretendard(.bold, size: 13)], for: .normal)
            item.setTitleTextAttributes([.font: UIFont.pretendard(.bold, size: 13)], for: .selected)
            item.imageInsets = UIEdgeInsets(top: -4, left: 0, bottom: 4, right: 0)
            item.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -4)
        }
        
        tabBarItems[1].isEnabled = true
        tabBarItems[1].imageInsets = UIEdgeInsets(top: -4, left: 0, bottom: -36, right: 0)
        tabBarItems[1].titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 5)
    }
    
    @objc func logoTapped() {
        selectedIndex = 1
    }
}
