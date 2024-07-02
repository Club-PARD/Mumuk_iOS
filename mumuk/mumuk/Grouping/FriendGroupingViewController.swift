import UIKit

class FriendGroupingViewController: UIViewController, UISearchBarDelegate {
    
    var uid: String?
    var name: String?
    
    private let searchBar = UISearchBar()
    private var friendLabel: UILabel!
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let bottomViewHeight: CGFloat = 122
    
    private var allFriends: [(emoji: String, name: String)] = []
    private var filteredFriends: [(emoji: String, name: String)] = []
    private var checkedFriends: [String: Bool] = [:]
    
    private var checkedFriendsScrollView: UIScrollView!
    private var checkedFriendsStack: UIStackView!
    private var checkedFriendsViewHeight: CGFloat = 70 // 체크된 친구들 뷰의 높이
    private var checkedFriendsViewTopConstraint: NSLayoutConstraint!
    private var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupTitleLabel()
        setupBackButton()
        setupCheckedFriendsView()
        setupSearchBar()
        // 초기 레이아웃 설정
        let desiredSpacing: CGFloat = 20 // 원하는 간격으로 조정
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: desiredSpacing)
        ])
        
        setupFriendLabel()
        setupFriends()
        setupFriendsScrollView()
        setupBottomView()
    
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    func setupTitleLabel() {
         titleLabel = UILabel()
         titleLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
         titleLabel.font = UIFont(name: "Pretendard-SemiBold", size: 20)
         titleLabel.textAlignment = .center
         titleLabel.text = "함께 먹을 친구 찾기"
         
         view.addSubview(titleLabel)
         titleLabel.translatesAutoresizingMaskIntoConstraints = false
         NSLayoutConstraint.activate([
             titleLabel.widthAnchor.constraint(equalToConstant: 153),
             titleLabel.heightAnchor.constraint(equalToConstant: 24),
             titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
             titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 67)
         ])
     }
    
    func setupBackButton() {
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "back"), for: .normal)
        backButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
        view.addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backButton.widthAnchor.constraint(equalToConstant: 10),
            backButton.heightAnchor.constraint(equalToConstant: 22),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 31.79),
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 68)
        ])
    }
    
    func setupCheckedFriendsView() {
        checkedFriendsScrollView = UIScrollView()
        checkedFriendsScrollView.showsHorizontalScrollIndicator = false
        view.addSubview(checkedFriendsScrollView)
        
        checkedFriendsScrollView.translatesAutoresizingMaskIntoConstraints = false
        checkedFriendsViewTopConstraint = checkedFriendsScrollView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20)
        NSLayoutConstraint.activate([
            checkedFriendsViewTopConstraint,
            checkedFriendsScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            checkedFriendsScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            checkedFriendsScrollView.heightAnchor.constraint(equalToConstant: checkedFriendsViewHeight)
        ])

        checkedFriendsStack = UIStackView()
        checkedFriendsStack.axis = .horizontal
        checkedFriendsStack.spacing = 20 // 원형 뷰 간의 간격 설정
        checkedFriendsStack.alignment = .center // 세로 중앙 정렬
        checkedFriendsScrollView.addSubview(checkedFriendsStack)

        checkedFriendsStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            checkedFriendsStack.topAnchor.constraint(equalTo: checkedFriendsScrollView.topAnchor),
            checkedFriendsStack.leadingAnchor.constraint(equalTo: checkedFriendsScrollView.leadingAnchor, constant: 20),
            checkedFriendsStack.trailingAnchor.constraint(equalTo: checkedFriendsScrollView.trailingAnchor, constant: -20),
            checkedFriendsStack.bottomAnchor.constraint(equalTo: checkedFriendsScrollView.bottomAnchor)
        ])
        
        checkedFriendsScrollView.isHidden = true
    }
    
    func setupSearchBar() {
        searchBar.placeholder = "닉네임 검색"
        searchBar.backgroundColor = .clear
        searchBar.backgroundImage = UIImage()
        searchBar.layer.backgroundColor = UIColor(red: 0.961, green: 0.957, blue: 0.957, alpha: 1).cgColor
        searchBar.layer.cornerRadius = 20
        searchBar.clipsToBounds = true
        
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        searchBar.searchTextField.backgroundColor = .clear
        
        let textColor = UIColor(red: 0.571, green: 0.571, blue: 0.571, alpha: 1)
        searchBar.searchTextField.textColor = textColor
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "닉네임 검색", attributes: [NSAttributedString.Key.foregroundColor: textColor])
        
        if let searchIconView = searchBar.searchTextField.leftView as? UIImageView {
            searchIconView.tintColor = textColor
        }
        
        searchBar.returnKeyType = .done
        searchBar.delegate = self
        
        view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.widthAnchor.constraint(equalToConstant: 330),
            searchBar.heightAnchor.constraint(equalToConstant: 36),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 121.01)
        ])
    }
    
    func setupFriendLabel() {
        friendLabel = UILabel()
        friendLabel.textColor = UIColor(red: 0.706, green: 0.706, blue: 0.706, alpha: 1)
        friendLabel.font = UIFont(name: "Pretendard-Bold", size: 13)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.29
        
        friendLabel.textAlignment = .center
        friendLabel.attributedText = NSMutableAttributedString(string: "친구", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        
        view.addSubview(friendLabel)
        friendLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            friendLabel.widthAnchor.constraint(equalToConstant: 23),
            friendLabel.heightAnchor.constraint(equalToConstant: 20),
            friendLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            friendLabel.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 25)
        ])
    }
    
    func setupFriends() {
        let emojis = ["👶🏻", "👩🏻", "👨🏻", "👵🏻", "👴🏻", "🧑🏻", "🧒🏻", "👦🏻", "👧🏻", "🧓🏻", "👱🏻", "👱🏻‍♀️", "👨🏻‍🦰", "👩🏻‍🦰", "👨🏻‍🦱"]
        let names = ["맛있으면우는사람", "행복한미식가", "음식탐험가", "요리의달인", "맛집사냥꾼", "식도락여행자", "건강한먹보", "달콤한입맛", "매운맛마니아", "미식의여왕", "음식평론가", "요리연구가", "맛집블로거", "식재료전문가", "음식사진작가"]
        
        allFriends = Array(zip(emojis, names))
        filteredFriends = allFriends
    }
    
    func setupFriendsScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: friendLabel.bottomAnchor, constant: 25),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -bottomViewHeight),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        updateFriendsView()
    }
    
    func updateFriendsView() {
        contentView.subviews.forEach { $0.removeFromSuperview() }
        
        for (index, friend) in filteredFriends.enumerated() {
            let containerView = createFriendView(emoji: friend.emoji, name: friend.name)
            contentView.addSubview(containerView)
            
            NSLayoutConstraint.activate([
                containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
                containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
                containerView.heightAnchor.constraint(equalToConstant: 60)
            ])
            
            if index == 0 {
                containerView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
            } else {
                containerView.topAnchor.constraint(equalTo: contentView.subviews[index-1].bottomAnchor, constant: 15).isActive = true
            }
            
            if index == filteredFriends.count - 1 {
                containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
            }
        }
    }
    
    func createFriendView(emoji: String, name: String) -> UIView {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        let emojiView = UIView()
        emojiView.translatesAutoresizingMaskIntoConstraints = false
        emojiView.layer.backgroundColor = UIColor(red: 0.918, green: 0.914, blue: 0.914, alpha: 1).cgColor
        emojiView.layer.cornerRadius = 22
        
        let emojiLabel = UILabel()
        emojiLabel.translatesAutoresizingMaskIntoConstraints = false
        emojiLabel.text = emoji
        emojiLabel.font = UIFont.systemFont(ofSize: 25)
        emojiLabel.textAlignment = .center
        
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = name
        nameLabel.font = UIFont(name: "Pretendard-Bold", size: 16)
        nameLabel.textColor = .black
        
        let checkBox = createCheckBox()
        updateCheckBoxAppearance(checkBox, isChecked: checkedFriends[name] ?? false)
        
        containerView.addSubview(emojiView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(checkBox)
        emojiView.addSubview(emojiLabel)
        
        NSLayoutConstraint.activate([
            emojiView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            emojiView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            emojiView.widthAnchor.constraint(equalToConstant: 44),
            emojiView.heightAnchor.constraint(equalToConstant: 44),
            
            emojiLabel.centerXAnchor.constraint(equalTo: emojiView.centerXAnchor),
            emojiLabel.centerYAnchor.constraint(equalTo: emojiView.centerYAnchor),
            
            nameLabel.leadingAnchor.constraint(equalTo: emojiView.trailingAnchor, constant: 13),
            nameLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            checkBox.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            checkBox.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            checkBox.widthAnchor.constraint(equalToConstant: 21),
            checkBox.heightAnchor.constraint(equalToConstant: 21)
        ])
        
        return containerView
    }
    
    func createCheckBox() -> UIButton {
        let checkBox = UIButton(type: .custom)
        checkBox.translatesAutoresizingMaskIntoConstraints = false
        checkBox.layer.borderWidth = 1.2
        checkBox.layer.borderColor = UIColor(red: 0.875, green: 0.878, blue: 0.878, alpha: 1).cgColor
        checkBox.layer.cornerRadius = 10.5
        checkBox.backgroundColor = .white
        checkBox.addTarget(self, action: #selector(checkBoxTapped), for: .touchUpInside)
                
                let checkmarkLabel = UILabel()
                checkmarkLabel.text = "✓"
                checkmarkLabel.textColor = .white
                checkmarkLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
                checkmarkLabel.textAlignment = .center
                checkmarkLabel.isHidden = true
                
                checkBox.addSubview(checkmarkLabel)
                checkmarkLabel.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    checkmarkLabel.centerXAnchor.constraint(equalTo: checkBox.centerXAnchor),
                    checkmarkLabel.centerYAnchor.constraint(equalTo: checkBox.centerYAnchor)
                ])
                
                return checkBox
            }
            
            func setupBottomView() {
                let bottomView = UIView()
                bottomView.frame = CGRect(x: 0, y: 0, width: 393, height: bottomViewHeight)
                
                let shadows = UIView()
                shadows.frame = bottomView.frame
                shadows.clipsToBounds = false
                bottomView.addSubview(shadows)
                
                let shadowPath0 = UIBezierPath(roundedRect: shadows.bounds, cornerRadius: 0)
                let layer0 = CALayer()
                layer0.shadowPath = shadowPath0.cgPath
                layer0.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
                layer0.shadowOpacity = 1
                layer0.shadowRadius = 4
                layer0.shadowOffset = CGSize(width: 0, height: 4)
                layer0.bounds = shadows.bounds
                layer0.position = shadows.center
                shadows.layer.addSublayer(layer0)
                
                let shapes = UIView()
                shapes.frame = bottomView.frame
                shapes.clipsToBounds = true
                bottomView.addSubview(shapes)
                
                let layer1 = CALayer()
                layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
                layer1.bounds = shapes.bounds
                layer1.position = shapes.center
                shapes.layer.addSublayer(layer1)
                
                view.addSubview(bottomView)
                bottomView.translatesAutoresizingMaskIntoConstraints = false
                
                NSLayoutConstraint.activate([
                    bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    bottomView.heightAnchor.constraint(equalToConstant: bottomViewHeight),
                    bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
                ])
                
                let buttonView = UIButton(type: .custom)
                buttonView.frame = CGRect(x: 0, y: 0, width: 146, height: 56.75)
                buttonView.layer.backgroundColor = UIColor(red: 1, green: 0.592, blue: 0.102, alpha: 1).cgColor
                buttonView.layer.cornerRadius = buttonView.frame.height / 2
                buttonView.addTarget(self, action: #selector(buttonTouchDown), for: .touchDown)
                buttonView.addTarget(self, action: #selector(buttonTouchUp), for: [.touchUpInside, .touchUpOutside])

                view.addSubview(buttonView)
                buttonView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    buttonView.widthAnchor.constraint(equalToConstant: 146),
                    buttonView.heightAnchor.constraint(equalToConstant: 56.75),
                    buttonView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -0.19),
                    buttonView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -35)
                ])

                let buttonLabel = UILabel()
                buttonLabel.frame = CGRect(x: 0, y: 0, width: 73, height: 19)
                buttonLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
                buttonLabel.font = UIFont(name: "Pretendard-Bold", size: 16)
                buttonLabel.text = "그룹 만들기"

                buttonView.addSubview(buttonLabel)
                buttonLabel.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    buttonLabel.centerXAnchor.constraint(equalTo: buttonView.centerXAnchor),
                    buttonLabel.centerYAnchor.constraint(equalTo: buttonView.centerYAnchor)
                ])
            }
            
            @objc func buttonTouchDown(_ sender: UIButton) {
                UIView.animate(withDuration: 0.1) {
                    sender.backgroundColor = UIColor(red: 0.8, green: 0.474, blue: 0.082, alpha: 1)
                }
            }

            @objc func buttonTouchUp(_ sender: UIButton) {
                UIView.animate(withDuration: 0.1) {
                    sender.backgroundColor = UIColor(red: 1, green: 0.592, blue: 0.102, alpha: 1)
                }
            }
            
            @objc func dismissVC() {
                dismiss(animated: true, completion: nil)
            }
            
    @objc func checkBoxTapped(_ sender: UIButton) {
        guard let containerView = sender.superview,
              let nameLabel = containerView.subviews.first(where: { $0 is UILabel && $0 != sender }) as? UILabel,
              let name = nameLabel.text,
              let emojiView = containerView.subviews.first(where: { $0 is UIView && $0 != sender && $0 != nameLabel }),
              let emojiLabel = emojiView.subviews.first as? UILabel,
              let emoji = emojiLabel.text else {
            return
        }
        
        let isChecked = !(checkedFriends[name] ?? false)
        checkedFriends[name] = isChecked
        updateCheckBoxAppearance(sender, isChecked: isChecked)
        
        if isChecked {
            addCheckedFriend(emoji: emoji, name: name)
        } else {
            removeCheckedFriend(name: name)
        }
        
        updateFriendsView()
    }

        func updateCheckBoxAppearance(_ checkBox: UIButton, isChecked: Bool) {
                let selectedColor = UIColor(red: 1, green: 0.592, blue: 0.102, alpha: 1)
                checkBox.backgroundColor = isChecked ? selectedColor : .white
                checkBox.layer.borderColor = isChecked ? selectedColor.cgColor : UIColor(red: 0.875, green: 0.878, blue: 0.878, alpha: 1).cgColor
                checkBox.subviews.first(where: { $0 is UILabel })?.isHidden = !isChecked
            }
            
    func addCheckedFriend(emoji: String, name: String) {
        let friendView = createCheckedFriendView(emoji: emoji, name: name)
        checkedFriendsStack.addArrangedSubview(friendView)
        
        if checkedFriendsStack.arrangedSubviews.count == 1 || checkedFriendsScrollView.isHidden {
            showCheckedFriendsView()
        }
    }
            
    func removeCheckedFriend(name: String) {
        if let viewToRemove = checkedFriendsStack.arrangedSubviews.first(where: { ($0.subviews.last as? UILabel)?.text == name }) {
            UIView.animate(withDuration: 0.3, animations: {
                viewToRemove.alpha = 0
            }) { _ in
                self.checkedFriendsStack.removeArrangedSubview(viewToRemove)
                viewToRemove.removeFromSuperview()
                
                if self.checkedFriendsStack.arrangedSubviews.isEmpty {
                    self.hideCheckedFriendsView()
                }
            }
        }
    }
            
    func showCheckedFriendsView() {
        UIView.animate(withDuration: 0.3) {
            self.checkedFriendsScrollView.isHidden = false
            
            // 타이틀 라벨로부터 2단위 아래로 위치하도록 설정
            let desiredSpacing: CGFloat = 2
            self.checkedFriendsViewTopConstraint.constant = desiredSpacing
            
            // 다른 뷰들의 위치 조정
            let totalOffset = self.checkedFriendsViewHeight + desiredSpacing
            self.searchBar.transform = CGAffineTransform(translationX: 0, y: totalOffset)
            self.friendLabel.transform = CGAffineTransform(translationX: 0, y: totalOffset)
            self.scrollView.transform = CGAffineTransform(translationX: 0, y: totalOffset)
            
            self.view.layoutIfNeeded()
        }
    }
    
    func hideCheckedFriendsView() {
        UIView.animate(withDuration: 0.3) {
            self.checkedFriendsScrollView.isHidden = true
            
            // 모든 변환을 초기화
            self.searchBar.transform = .identity
            self.friendLabel.transform = .identity
            self.scrollView.transform = .identity
            
            // 원래의 간격으로 돌아가기
            let desiredSpacing: CGFloat = 20 // setupSearchBar()에서 설정한 원래 간격
            self.checkedFriendsViewTopConstraint.constant = desiredSpacing
            
            self.view.layoutIfNeeded()
        }
    }
            
    func createCheckedFriendView(emoji: String, name: String) -> UIView {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        let circleView = UIView()
        circleView.translatesAutoresizingMaskIntoConstraints = false
        circleView.layer.cornerRadius = 25 // 원형 뷰의 반지름
        circleView.layer.backgroundColor = UIColor(red: 0.918, green: 0.914, blue: 0.914, alpha: 1).cgColor
        
        let emojiLabel = UILabel()
        emojiLabel.translatesAutoresizingMaskIntoConstraints = false
        emojiLabel.text = emoji
        emojiLabel.font = UIFont.systemFont(ofSize: 25)
        emojiLabel.textAlignment = .center
        
        let closeButton = UIButton(type: .system)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.setTitle("X", for: .normal)
        closeButton.setTitleColor(.white, for: .normal)
        closeButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 10)
        closeButton.backgroundColor = UIColor(red: 0.518, green: 0.514, blue: 0.518, alpha: 1)
        closeButton.layer.cornerRadius = 8
        closeButton.addTarget(self, action: #selector(closeButtonTapped(_:)), for: .touchUpInside)
        
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = name
        nameLabel.font = UIFont(name: "Pretendard-Bold", size: 10)
        nameLabel.textColor = UIColor(red: 0.518, green: 0.514, blue: 0.518, alpha: 1)
        nameLabel.textAlignment = .center
        
        containerView.addSubview(circleView)
        containerView.addSubview(closeButton)
        containerView.addSubview(nameLabel)
        circleView.addSubview(emojiLabel)
        
        NSLayoutConstraint.activate([
            containerView.widthAnchor.constraint(equalToConstant: 50), // 컨테이너 뷰의 너비
            containerView.heightAnchor.constraint(equalToConstant: checkedFriendsViewHeight),
            
            circleView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: -10), // 세로 중앙에서 약간 위로
            circleView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            circleView.widthAnchor.constraint(equalToConstant: 50),
            circleView.heightAnchor.constraint(equalToConstant: 50),
            
            emojiLabel.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
            emojiLabel.centerYAnchor.constraint(equalTo: circleView.centerYAnchor),
            
            closeButton.topAnchor.constraint(equalTo: circleView.topAnchor),
            closeButton.trailingAnchor.constraint(equalTo: circleView.trailingAnchor),
            closeButton.widthAnchor.constraint(equalToConstant: 16),
            closeButton.heightAnchor.constraint(equalToConstant: 16),
            
            nameLabel.topAnchor.constraint(equalTo: circleView.bottomAnchor, constant: 4),
            nameLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
        return containerView
    }
            
    @objc func closeButtonTapped(_ sender: UIButton) {
        guard let containerView = sender.superview,
              let nameLabel = containerView.subviews.last as? UILabel,
              let name = nameLabel.text else {
            return
        }

        checkedFriends[name] = false
        removeCheckedFriend(name: name)
        updateFriendsView()
    }
            
            // MARK: - Keyboard Dismissal
            
            @objc func dismissKeyboard() {
                view.endEditing(true)
            }
            
            // MARK: - UISearchBarDelegate
            
            func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
                if searchText.isEmpty {
                    filteredFriends = allFriends
                } else {
                    filteredFriends = allFriends.filter { $0.name.lowercased().contains(searchText.lowercased()) }
                }
                updateFriendsView()
            }
            
            func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
                searchBar.resignFirstResponder()
            }
        }
