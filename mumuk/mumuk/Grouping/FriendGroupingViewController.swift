import UIKit

class FriendGroupingViewController: UIViewController, UISearchBarDelegate {
    
    var uid: String?
    var name: String?
    private var buttonView: UIButton!
    
    private let searchBar = UISearchBar()
    private var friendLabel: UILabel!
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let bottomViewHeight: CGFloat = 122
    
    private var allFriends: [(imageId: Int, name: String, uid: String)] = []
    private var filteredFriends: [(imageId: Int, name: String, uid: String)] = []
    private var checkedFriends: [String: Bool] = [:]
    
    private var checkedFriendsScrollView: UIScrollView!
    private var checkedFriendsStack: UIStackView!
    private var checkedFriendsViewHeight: CGFloat = 87 // 체크된 친구들 뷰의 높이
    private var checkedFriendsViewTopConstraint: NSLayoutConstraint!
    private var titleLabel: UILabel!
    private var scrollViewBottomConstraint: NSLayoutConstraint!
    
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
            backButton.widthAnchor.constraint(equalToConstant: 30),
            backButton.heightAnchor.constraint(equalToConstant: 37),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 23),
            backButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor)
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
            searchBar.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 25)
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
        fetchFriends { [weak self] friends in
            DispatchQueue.main.async {
                self?.allFriends = friends.map { (imageId: $0.imageId, name: $0.name, uid: $0.uid) }
                self?.filteredFriends = self?.allFriends ?? []
                self?.updateFriendsView()
            }
        }
    }

    func fetchFriends(completion: @escaping ([Friend]) -> Void) {
        guard let url = URL(string: "https://mumuk.store/friend/\(name ?? "")") else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                print("No data received")
                return
            }

            do {
                let friends = try JSONDecoder().decode([Friend].self, from: data)
                completion(friends)
            } catch {
                print("Decoding error: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    struct Friend: Codable {
        let uid: String
        let name: String
        let imageId: Int
        let grouped: Bool
        let daily: Bool
    }
    
    func setupFriendsScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollViewBottomConstraint = scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -bottomViewHeight)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: friendLabel.bottomAnchor, constant: 25),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollViewBottomConstraint,
            
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
            let containerView = createFriendView(imageId: friend.imageId, name: friend.name)
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

    
    func createFriendView(imageId: Int, name: String) -> UIView {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 22
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: getImageName(for: imageId))
        imageView.accessibilityIdentifier = "\(imageId)"
        
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = name
        nameLabel.font = UIFont(name: "Pretendard-Bold", size: 16)
        nameLabel.textColor = .black
        
        let checkBox = createCheckBox()
        updateCheckBoxAppearance(checkBox, isChecked: checkedFriends[name] ?? false)
        
        containerView.addSubview(imageView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(checkBox)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            imageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 44),
            imageView.heightAnchor.constraint(equalToConstant: 44),
            
            nameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 13),
            nameLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            checkBox.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            checkBox.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            checkBox.widthAnchor.constraint(equalToConstant: 21),
            checkBox.heightAnchor.constraint(equalToConstant: 21)
        ])
        
        return containerView
    }


    func getImageName(for imageId: Int) -> String {
        return Model.ModelData.first { $0.number == imageId }?.image ?? "default"
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
                
                buttonView = UIButton(type: .custom)
                buttonView.frame = CGRect(x: 0, y: 0, width: 146, height: 56.75)
                buttonView.layer.backgroundColor = UIColor(red: 1, green: 0.592, blue: 0.102, alpha: 1).cgColor
                buttonView.layer.cornerRadius = buttonView.frame.height / 2
                buttonView.addTarget(self, action: #selector(buttonTouchDown), for: .touchDown)
                buttonView.addTarget(self, action: #selector(buttonTouchUp), for: [.touchUpInside, .touchUpOutside])
                buttonView.addTarget(self, action: #selector(createGroupButtonTapped), for: .touchUpInside)

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
                
                buttonView.addTarget(self, action: #selector(createGroupButtonTapped), for: .touchUpInside)
                updateCreateGroupButtonState()
            }
    func updateCreateGroupButtonState() {
        let isEnabled = !checkedFriends.filter { $0.value }.isEmpty
        buttonView.isEnabled = isEnabled
        buttonView.alpha = isEnabled ? 1.0 : 0.5
    }
    
    @objc func createGroupButtonTapped() {
        if !checkedFriends.filter({ $0.value }).isEmpty {
            // 선택된 친구들의 uid를 가져옵니다.
            let selectedFriendUids = allFriends.filter { friend in
                checkedFriends[friend.name] == true
            }.map { $0.uid }
            
            // 사용자 자신의 uid를 배열의 첫 번째 요소로 추가합니다.
            var userUids = [self.uid ?? ""]
            userUids.append(contentsOf: selectedFriendUids)
            
            // API 요청을 위한 데이터를 준비합니다.
            let requestData: [String: [String]] = ["userUids": userUids]
            
            // API 요청을 보냅니다.
            createGroup(with: requestData) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success:
                        print("그룹이 성공적으로 생성되었습니다.")
                        // 성공 시 다음 화면으로 이동
                        let groupingMainVC = GroupingMainViewController()
                        groupingMainVC.uid = self.uid
                        groupingMainVC.name = self.name
                        groupingMainVC.modalPresentationStyle = .fullScreen
                        self.present(groupingMainVC, animated: true, completion: nil)
                    case .failure(let error):
                        print("그룹 생성 실패: \(error.localizedDescription)")
                        // 실패 시 사용자에게 알림
                        self.showAlert(message: "그룹 생성에 실패했습니다. 다시 시도해주세요.")
                    }
                }
            }
        }
    }

    func createGroup(with data: [String: [String]], completion: @escaping (Result<Void, Error>) -> Void) {
        guard let url = URL(string: "https://mumuk.store/group") else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: data, options: [])
        } catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Server error"])))
                return
            }
            
            completion(.success(()))
        }.resume()
    }

    func showAlert(message: String) {
        let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
            
    @objc func buttonTouchDown(_ sender: UIButton) {
        if sender.isEnabled {
            UIView.animate(withDuration: 0.1) {
                sender.backgroundColor = UIColor(red: 0.8, green: 0.474, blue: 0.082, alpha: 1)
            }
        }
    }

    @objc func buttonTouchUp(_ sender: UIButton) {
        if sender.isEnabled {
            UIView.animate(withDuration: 0.1) {
                sender.backgroundColor = UIColor(red: 1, green: 0.592, blue: 0.102, alpha: 1)
            }
        }
    }
            
            @objc func dismissVC() {
                dismiss(animated: true, completion: nil)
            }
            
    @objc func checkBoxTapped(_ sender: UIButton) {
        guard let containerView = sender.superview,
              let nameLabel = containerView.subviews.first(where: { $0 is UILabel && $0 != sender }) as? UILabel,
              let name = nameLabel.text,
              let imageView = containerView.subviews.first(where: { $0 is UIImageView && $0 != sender && $0 != nameLabel }),
              let imageIdString = imageView.accessibilityIdentifier,
              let imageId = Int(imageIdString) else {
            return
        }
        
        let isChecked = !(checkedFriends[name] ?? false)
        checkedFriends[name] = isChecked
        updateCheckBoxAppearance(sender, isChecked: isChecked)
        
        if isChecked {
            addCheckedFriend(imageId: imageId, name: name)
        } else {
            removeCheckedFriend(name: name)
        }
        
        updateFriendsView()
        updateCreateGroupButtonState()
    }

        func updateCheckBoxAppearance(_ checkBox: UIButton, isChecked: Bool) {
                let selectedColor = UIColor(red: 1, green: 0.592, blue: 0.102, alpha: 1)
                checkBox.backgroundColor = isChecked ? selectedColor : .white
                checkBox.layer.borderColor = isChecked ? selectedColor.cgColor : UIColor(red: 0.875, green: 0.878, blue: 0.878, alpha: 1).cgColor
                checkBox.subviews.first(where: { $0 is UILabel })?.isHidden = !isChecked
            }
            
    func addCheckedFriend(imageId: Int, name: String) {
        let friendView = createCheckedFriendView(imageId: imageId, name: name)
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
            
            let desiredSpacing: CGFloat = 2
            self.checkedFriendsViewTopConstraint.constant = desiredSpacing
            
            let totalOffset = self.checkedFriendsViewHeight + desiredSpacing
            
            // 스크롤뷰와 다른 요소들을 함께 이동시킵니다
            self.searchBar.transform = CGAffineTransform(translationX: 0, y: totalOffset)
            self.friendLabel.transform = CGAffineTransform(translationX: 0, y: totalOffset)
            self.scrollView.transform = CGAffineTransform(translationX: 0, y: totalOffset)
            
            // 스크롤뷰의 bottom 제약 조건을 조정합니다
            self.scrollViewBottomConstraint.constant = -(self.bottomViewHeight + totalOffset)
            
            self.view.layoutIfNeeded()
        }
    }
    
    func hideCheckedFriendsView() {
        UIView.animate(withDuration: 0.3) {
            self.checkedFriendsScrollView.isHidden = true
            
            // 모든 변환을 초기화합니다
            self.searchBar.transform = .identity
            self.friendLabel.transform = .identity
            self.scrollView.transform = .identity
            
            // 스크롤뷰의 bottom 제약 조건을 원래대로 되돌립니다
            self.scrollViewBottomConstraint.constant = -self.bottomViewHeight
            
            let desiredSpacing: CGFloat = 20
            self.checkedFriendsViewTopConstraint.constant = desiredSpacing
            
            self.view.layoutIfNeeded()
        }
    }
            
    func createCheckedFriendView(imageId: Int, name: String) -> UIView {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 25 // 원형 뷰의 반지름
        imageView.layer.backgroundColor = UIColor(red: 0.918, green: 0.914, blue: 0.914, alpha: 1).cgColor
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: getImageName(for: imageId))
        
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
        
        containerView.addSubview(imageView)
        containerView.addSubview(closeButton)
        containerView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            containerView.widthAnchor.constraint(equalToConstant: 50), // 컨테이너 뷰의 너비
            containerView.heightAnchor.constraint(equalToConstant: checkedFriendsViewHeight),
            
            imageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: 5),
            imageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 50),
            imageView.heightAnchor.constraint(equalToConstant: 50),
            
            closeButton.topAnchor.constraint(equalTo: imageView.topAnchor),
            closeButton.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            closeButton.widthAnchor.constraint(equalToConstant: 16),
            closeButton.heightAnchor.constraint(equalToConstant: 16),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4),
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
        updateCreateGroupButtonState()
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
