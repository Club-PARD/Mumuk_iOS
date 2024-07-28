import UIKit

class SummaryViewController: UIViewController {
    var groupId: String?
    var name: String?
    var groupUserData: GroupResponse?
    private var summaryImageView: UIImageView!
    private let bottomViewHeight: CGFloat = 122
    private var scrollView: UIScrollView!
    private var contentView: UIView!
    private var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        fetchGroupLeaderName { [weak self] groupName in
            DispatchQueue.main.async {
                self?.setupSummaryView()
                self?.setupBackButton()
                self?.setupSummaryLabel(with: groupName)
                self?.setupCardImage(with: groupName)
                self?.setupBottomView()
            }
        }
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
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50)
        ])
    }
    
    @objc func dismissVC() {
        dismiss(animated: true, completion: nil)
    }
    
    private func getImage(for imageId: Int) -> UIImage {
        let modelData = Model.ModelData
        let index = imageId % modelData.count
        return UIImage(named: modelData[index].image) ?? UIImage(named: "default")!
    }
    
    func fetchGroupLeaderName(completion: @escaping (String) -> Void) {
        guard let groupId = groupId else {
            completion("그룹장")
            return
        }
        let urlString = "http://172.30.1.10:8080/user/users?uid=\(groupId)"
        
        guard let url = URL(string: urlString) else {
            completion("그룹장")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching group leader name: \(error)")
                completion("그룹장")
                return
            }
            
            guard let data = data else {
                completion("그룹장")
                return
            }
            
            do {
                let users = try JSONDecoder().decode([User].self, from: data)
                if let user = users.first {
                    completion(user.name)
                } else {
                    completion("그룹장")
                }
            } catch {
                print("Error decoding user data: \(error)")
                completion("그룹장")
            }
        }.resume()
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("ScrollView contentSize after appearing: \(scrollView.contentSize)")
        print("ScrollView bounds after appearing: \(scrollView.bounds)")
        print("ContentView bounds after appearing: \(contentView.bounds)")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // scrollView와 contentView가 nil인지 확인
        guard let scrollView = scrollView, let contentView = contentView else {
            return
        }
        
        scrollView.layoutIfNeeded()
        contentView.layoutIfNeeded()
        
        // 스크롤뷰의 컨텐츠 크기를 설정합니다.
        scrollView.contentSize = contentView.bounds.size
        
        print("ScrollView contentSize: \(scrollView.contentSize)")
        print("ScrollView bounds: \(scrollView.bounds)")
        print("ContentView bounds: \(contentView.bounds)")
    }

    
    func setupSummaryView() {
        // Summary 이미지 추가
        summaryImageView = UIImageView(image: UIImage(named: "Summary"))
        summaryImageView.contentMode = .scaleAspectFit
        view.addSubview(summaryImageView)
        
        summaryImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            summaryImageView.widthAnchor.constraint(equalToConstant: 100),
            summaryImageView.heightAnchor.constraint(equalToConstant: 107),
            summaryImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            summaryImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 75),
            summaryImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    func setupSummaryLabel(with groupName: String) {
        label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 200, height: 44)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = UIFont(name: "Pretendard-Regular", size: 18)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.02
        paragraphStyle.alignment = .center
        
        let attributedString = NSMutableAttributedString(string: "\(groupName)님의 그룹 입맛을\n전부 조합해보았어요!")
        
        // Bold 처리
        let boldRange = (attributedString.string as NSString).range(of: "\(groupName)님의 그룹 입맛")
        attributedString.addAttribute(.font, value: UIFont(name: "Pretendard-Bold", size: 18)!, range: boldRange)
        
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
        
        label.attributedText = attributedString
        
        self.view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.widthAnchor.constraint(equalToConstant: 200),
            label.heightAnchor.constraint(equalToConstant: 44),
            label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            label.topAnchor.constraint(equalTo: self.summaryImageView.bottomAnchor, constant: 25)
        ])
    }
    
    func setupCardImage(with groupName: String) {
        let cardImageView = UIImageView(image: UIImage(named: "Card"))
        cardImageView.contentMode = .scaleAspectFit
        view.addSubview(cardImageView)
        
        cardImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cardImageView.widthAnchor.constraint(equalToConstant: 304),
            cardImageView.heightAnchor.constraint(equalToConstant: 400),
            cardImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cardImageView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 31)
        ])
        
        // Add new label on top of the card image
        let cardLabel = UILabel()
        cardLabel.textColor = UIColor(red: 0.58, green: 0.58, blue: 0.58, alpha: 1)
        cardLabel.font = UIFont(name: "Pretendard-SemiBold", size: 14)
        cardLabel.textAlignment = .center
        
        cardLabel.text = "\(groupName)님의 그룹 입맛"
        
        view.addSubview(cardLabel)
        cardLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cardLabel.centerXAnchor.constraint(equalTo: cardImageView.centerXAnchor),
            cardLabel.topAnchor.constraint(equalTo: cardImageView.topAnchor, constant: 7)
        ])
        
        // 스크롤뷰 설정
        scrollView = UIScrollView()
        view.addSubview(scrollView)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView = UIView()
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: cardLabel.bottomAnchor, constant: 23),
            scrollView.leadingAnchor.constraint(equalTo: cardImageView.leadingAnchor, constant: 30),
            scrollView.trailingAnchor.constraint(equalTo: cardImageView.trailingAnchor, constant: -30),
            scrollView.bottomAnchor.constraint(equalTo: cardImageView.bottomAnchor, constant: -20),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor)
        ])
        
        // 친구 목록 업데이트
        updateFriendViews()
    }
    
    func updateFriendViews() {
        guard let groupUserData = groupUserData else { return }
        
        var previousView: UIView?
        
        for (index, user) in groupUserData.users.values.enumerated() {
            let friendView = createFriendView(user: user)
            contentView.addSubview(friendView)
            friendView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                friendView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                friendView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                friendView.heightAnchor.constraint(equalToConstant: 118)
            ])
            
            if let previousView = previousView {
                friendView.topAnchor.constraint(equalTo: previousView.bottomAnchor, constant: 20).isActive = true
            } else {
                friendView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
            }
            
            previousView = friendView
            
            if index < groupUserData.users.count - 1 {
                let separatorView = createSeparatorView()
                contentView.addSubview(separatorView)
                
                NSLayoutConstraint.activate([
                    separatorView.topAnchor.constraint(equalTo: friendView.bottomAnchor, constant: 10),
                    separatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                    separatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                    separatorView.heightAnchor.constraint(equalToConstant: 1.5)
                ])
                
                previousView = separatorView
            }
        }
        
        // contentView의 높이를 설정합니다.
        if let lastView = contentView.subviews.last {
            NSLayoutConstraint.activate([
                contentView.bottomAnchor.constraint(equalTo: lastView.bottomAnchor, constant: 20)
            ])
        }
        
        // 스크롤뷰의 contentSize를 설정합니다.
        let contentHeight = contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        scrollView.contentSize = CGSize(width: scrollView.bounds.width, height: contentHeight)
        
        // 스크롤뷰의 높이 제약 조건을 추가합니다.
        scrollView.heightAnchor.constraint(greaterThanOrEqualToConstant: contentHeight).isActive = true
    }
    
    func createFriendView(user: GroupUser) -> UIView {
        let friendView = UIView()
        friendView.backgroundColor = .white
        
        // 원형 뷰
        let circleView = UIView()
        circleView.layer.cornerRadius = 35
        circleView.layer.borderWidth = 2
        circleView.layer.borderColor = user.daily ? UIColor(red: 1, green: 0.592, blue: 0.102, alpha: 1).cgColor : UIColor(red: 0.875, green: 0.875, blue: 0.875, alpha: 1).cgColor
        circleView.clipsToBounds = true
        friendView.addSubview(circleView)
        
        let imageView = UIImageView(image: getImage(for: user.imageId))
        imageView.contentMode = .scaleAspectFill
        circleView.addSubview(imageView)

        // 이미지 뷰에 대한 제약 조건 설정
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: circleView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: circleView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: circleView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: circleView.bottomAnchor)
        ])
        
        // 이름 레이블
        let nameLabel = UILabel()
        nameLabel.text = user.name
        nameLabel.font = UIFont(name: "Pretendard-Bold", size: 14)
        friendView.addSubview(nameLabel)
        
        // 어제 먹은 음식 레이블
        let yesterdayFoodLabel = UILabel()
        yesterdayFoodLabel.font = UIFont(name: "Pretendard-Light", size: 11)
        let attributedString = NSMutableAttributedString(string: "어제 먹은 음식은 ", attributes: [.foregroundColor: UIColor.black])
        attributedString.append(NSAttributedString(string: user.notToday ?? "???", attributes: [.foregroundColor: UIColor(red: 1, green: 0.592, blue: 0.102, alpha: 1)]))
        yesterdayFoodLabel.attributedText = attributedString
        friendView.addSubview(yesterdayFoodLabel)
        
        // 태그 스크롤뷰
        let tagScrollView = UIScrollView()
        tagScrollView.showsHorizontalScrollIndicator = false
        friendView.addSubview(tagScrollView)

        let tagStackView = UIStackView()
        tagStackView.axis = .horizontal
        tagStackView.spacing = 10
        tagScrollView.addSubview(tagStackView)

        tagScrollView.translatesAutoresizingMaskIntoConstraints = false
        tagStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tagScrollView.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            tagScrollView.trailingAnchor.constraint(equalTo: friendView.trailingAnchor),
            tagScrollView.topAnchor.constraint(equalTo: yesterdayFoodLabel.bottomAnchor, constant: 10),
            tagScrollView.heightAnchor.constraint(equalToConstant: 24),

            tagStackView.topAnchor.constraint(equalTo: tagScrollView.topAnchor),
            tagStackView.leadingAnchor.constraint(equalTo: tagScrollView.leadingAnchor),
            tagStackView.trailingAnchor.constraint(equalTo: tagScrollView.trailingAnchor),
            tagStackView.heightAnchor.constraint(equalTo: tagScrollView.heightAnchor)
        ])

        // 태그 추가
        let tags = generateTags(for: user)
        for tag in tags {
            let tagView = createTagView(with: tag)
            tagStackView.addArrangedSubview(tagView)
        }

        // 태그 스택뷰의 컨텐츠 크기 설정
        tagStackView.layoutIfNeeded()
        tagScrollView.contentSize = tagStackView.bounds.size
        
        // Auto Layout 설정
        circleView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        yesterdayFoodLabel.translatesAutoresizingMaskIntoConstraints = false
        tagScrollView.translatesAutoresizingMaskIntoConstraints = false
        tagStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            circleView.leadingAnchor.constraint(equalTo: friendView.leadingAnchor),
            circleView.centerYAnchor.constraint(equalTo: friendView.centerYAnchor),
            circleView.widthAnchor.constraint(equalToConstant: 70),
            circleView.heightAnchor.constraint(equalToConstant: 70),
            
            nameLabel.leadingAnchor.constraint(equalTo: circleView.trailingAnchor, constant: 10),
            nameLabel.topAnchor.constraint(equalTo: friendView.topAnchor, constant: 20),
            
            yesterdayFoodLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            yesterdayFoodLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            
            tagScrollView.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            tagScrollView.trailingAnchor.constraint(equalTo: friendView.trailingAnchor, constant: -20),
            tagScrollView.topAnchor.constraint(equalTo: yesterdayFoodLabel.bottomAnchor, constant: 10),
            tagScrollView.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        return friendView
    }

    func generateTags(for user: GroupUser) -> [String] {
        var tags: [String] = []

        if user.daily {
            if user.todayKoreanFood == 1 { tags.append("🇰🇷 한식") }
            if user.todayJapaneseFood == 1 { tags.append("🇯🇵 일식") }
            if user.todayChineseFood == 1 { tags.append("🇨🇳 중식") }
            if user.todayWesternFood == 1 { tags.append("🇮🇹 양식") }
            if user.todaySoutheastAsianFood == 1 { tags.append("🇹🇭 동남아") }
            if user.todayElseFood == 1 { tags.append("🇮🇳 기타") }
            if user.todayMeat == 1 { tags.append("🥩 육류") }
            if user.todaySeafood == 1 { tags.append("🐟 해산물") }
            if user.todayCarbohydrate == 1 { tags.append("🍚 탄수화물") }
            if user.todayVegetable == 1 { tags.append("🥬 채소") }
            if user.todayHeavy == 1 { tags.append("🥘 헤비") }
            if user.todayLight == 1 { tags.append("🥗 라이트") }
            if user.todaySoup == 1 { tags.append("🥣 국물") }
            if user.todayNoSoup == 1 { tags.append("🍽️ NO국물") }
            if user.redFood == 1 { tags.append("🌶️ 빨간맛") }
            if user.notRedFood == 1 { tags.append("🌶️🚫 안 빨간맛") }
            if user.todayRice == 1 { tags.append("🍙 밥") }
            if user.todayBread == 1 { tags.append("🍞 빵") }
            if user.todayNoodle == 1 { tags.append("🍜 면") }
        } else {
            if let foodType = user.foodTypes ?? user.foodType {
                switch foodType {
                case "다이어트": tags.append("💪🏻 다이어트")
                case "할랄": tags.append("🐷🚫 할랄")
                case "비건": tags.append("🥦 비건")
                default: tags.append("🚫 특이사항없음")
                }
            }
            tags.append(user.spicyType ? "🔥 맵고수" : "🍼 맵찔이")
        }

        return tags
    }
    
    func createSeparatorView() -> UIView {
        let separatorView = UIView()
        separatorView.backgroundColor = UIColor(red: 0.929, green: 0.929, blue: 0.929, alpha: 1)
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        return separatorView
    }
    
    func createTagView(with tag: String) -> UIView {
        let tagView = UIView()
        tagView.backgroundColor = .white
        tagView.layer.cornerRadius = 8
        tagView.layer.borderWidth = 1
        tagView.layer.borderColor = UIColor(red: 1, green: 0.592, blue: 0.102, alpha: 1).cgColor
        
        let tagLabel = UILabel()
        tagLabel.text = tag
        tagLabel.textColor = UIColor(red: 1, green: 0.592, blue: 0.102, alpha: 1)
        tagLabel.font = UIFont(name: "Pretendard-Regular", size: 12)
        tagView.addSubview(tagLabel)
        
        tagLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tagLabel.topAnchor.constraint(equalTo: tagView.topAnchor, constant: 4),
            tagLabel.bottomAnchor.constraint(equalTo: tagView.bottomAnchor, constant: -4),
            tagLabel.leadingAnchor.constraint(equalTo: tagView.leadingAnchor, constant: 8),
            tagLabel.trailingAnchor.constraint(equalTo: tagView.trailingAnchor, constant: -8)
        ])
        
        return tagView
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
        layer0.shadowOpacity = 0.5
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
        buttonView.addTarget(self, action: #selector(buttonTouchDown(_:)), for: .touchDown)
        buttonView.addTarget(self, action: #selector(buttonTouchUp(_:)), for: [.touchUpInside, .touchUpOutside])
        
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
        buttonLabel.text = "메뉴 추천 START"
        
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
    
    @objc private func buttonTouchUp(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.backgroundColor = UIColor(red: 1, green: 0.592, blue: 0.102, alpha: 1)
        }
        fetchRecommendationData()
    }
    
    private func fetchRecommendationData() {
        guard let groupId = groupId else { return }
        let urlString = "http://172.30.1.10:8080/food/recommend/\(groupId)"
        print("Request URL: \(urlString)")
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }
            
            guard let self = self, let data = data else {
                print("No data received")
                return
            }
            
            do {
                let responseBody = try JSONDecoder().decode(ResponseBody.self, from: data)
                self.fetchUserName(groupId: responseBody.groupId) { userName in
                    DispatchQueue.main.async {
                        self.navigateToLoadingView(with: responseBody, userName: userName)
                    }
                }
            } catch {
                print("Error decoding response: \(error)")
            }
        }.resume()
    }

    private func navigateToLoadingView(with responseBody: ResponseBody, userName: String) {
        let loadingVC = LoadingViewController()
        loadingVC.rank1 = responseBody.rank1
        loadingVC.rank2 = responseBody.rank2
        loadingVC.rank3 = responseBody.rank3
        loadingVC.userName = userName
        
        loadingVC.modalPresentationStyle = .fullScreen
        present(loadingVC, animated: true, completion: nil)
    }
    
    private func fetchUserName(groupId: String, completion: @escaping (String) -> Void) {
        let urlString = "http://172.30.1.10:8080/user/users?uid=\(groupId)"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            completion("")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching user data: \(error)")
                completion("")
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion("")
                return
            }
            
            do {
                let users = try JSONDecoder().decode([User].self, from: data)
                if let user = users.first {
                    completion(user.name)
                } else {
                    completion("")
                }
            } catch {
                print("Error decoding user data: \(error)")
                completion("")
            }
        }.resume()
    }
    
    private func navigateToNextPage(with responseBody: ResponseBody, userName: String) {
        let reconFoodVC = ReconFoodViewController1()
        reconFoodVC.rank1 = responseBody.rank1
        reconFoodVC.rank2 = responseBody.rank2
        reconFoodVC.rank3 = responseBody.rank3
        reconFoodVC.userName = userName
        
        reconFoodVC.modalPresentationStyle = .fullScreen  // 전체 화면으로 설정
        present(reconFoodVC, animated: true, completion: nil)
    }
}
