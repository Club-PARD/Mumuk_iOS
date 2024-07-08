import UIKit

class SummaryViewController: UIViewController {
    private var summaryImageView: UIImageView!
    private let bottomViewHeight: CGFloat = 122
    private var scrollView: UIScrollView!
    private var contentView: UIView!
    private var label: UILabel!
    private let emojis = ["👶🏻", "👩🏻", "👨🏻", "👵🏻", "👴🏻"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupSummaryView()
        setupSummaryLabel()
        setupCardImage()
        setupBottomView()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("ScrollView contentSize after appearing: \(scrollView.contentSize)")
        print("ScrollView bounds after appearing: \(scrollView.bounds)")
        print("ContentView bounds after appearing: \(contentView.bounds)")
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
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
    
    func setupSummaryLabel() {
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
        
        let attributedString = NSMutableAttributedString(string: "김현중국집님의 그룹 입맛을\n전부 조합해보았어요!")
        
        // Bold 처리
        let boldRange = (attributedString.string as NSString).range(of: "김현중국집님의 그룹 입맛")
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
    
    // 임시 GroupUser 구조체 정의
    struct GroupUser {
        let name: String
        let imageId: Int
        let notToday: String
        let daily: Bool
    }
    
    func setupCardImage() {
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
        cardLabel.text = "김현중국집님의 그룹 입맛"
        
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
            scrollView.topAnchor.constraint(equalTo: cardLabel.bottomAnchor, constant: 10),
            scrollView.leadingAnchor.constraint(equalTo: cardImageView.leadingAnchor, constant: 30),
            scrollView.trailingAnchor.constraint(equalTo: cardImageView.trailingAnchor, constant: -30),
            scrollView.bottomAnchor.constraint(equalTo: cardImageView.bottomAnchor, constant: -20),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor)
        ])
        
        // 더미 데이터 생성 및 친구 뷰 추가
        let names = ["맛있으면우는사람", "행복한미식가", "음식탐험가", "요리의달인", "맛집사냥꾼"]
        let yesterdayFoods = ["김치찌개", "파스타", "삼겹살", "초밥", "짜장면"]
        
        var previousView: UIView?
        
        for (index, name) in names.enumerated() {
            let user = GroupUser(name: name, imageId: index, notToday: yesterdayFoods[index], daily: Bool.random())
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
            
            if index == names.count - 1 {
                friendView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
            }
            
            previousView = friendView
            
            if index < names.count - 1 {
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
        let lastView = contentView.subviews.last!
        NSLayoutConstraint.activate([
            contentView.bottomAnchor.constraint(equalTo: lastView.bottomAnchor, constant: 20),
            contentView.heightAnchor.constraint(greaterThanOrEqualTo: scrollView.heightAnchor)
        ])
    }
        
    func createFriendView(user: GroupUser) -> UIView {
        let friendView = UIView()
        friendView.backgroundColor = .white
        
        // 원형 뷰
        let circleView = UIView()
        circleView.layer.cornerRadius = 35
        circleView.layer.borderWidth = 2
        circleView.layer.borderColor = user.daily ? UIColor(red: 1, green: 0.592, blue: 0.102, alpha: 1).cgColor : UIColor(red: 0.875, green: 0.875, blue: 0.875, alpha: 1).cgColor
        friendView.addSubview(circleView)
        
        // 이모지 레이블
        let emojiLabel = UILabel()
        emojiLabel.text = emojis[user.imageId % emojis.count]
        emojiLabel.font = .systemFont(ofSize: 40)
        emojiLabel.textAlignment = .center
        circleView.addSubview(emojiLabel)
        
        // 이름 레이블
        let nameLabel = UILabel()
        nameLabel.text = user.name
        nameLabel.font = UIFont(name: "Pretendard-Bold", size: 14)
        friendView.addSubview(nameLabel)
        
        // 어제 먹은 음식 레이블
        let yesterdayFoodLabel = UILabel()
        yesterdayFoodLabel.font = UIFont(name: "Pretendard-Light", size: 11)
        let attributedString = NSMutableAttributedString(string: "어제 먹은 음식은 ", attributes: [.foregroundColor: UIColor.black])
        attributedString.append(NSAttributedString(string: user.notToday, attributes: [.foregroundColor: UIColor(red: 1, green: 0.592, blue: 0.102, alpha: 1)]))
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

        // 예시 태그 추가
        let exampleTags = ["🍚 탄수화물", "🥩 육류", "🇰🇷 한식", "🌶️ 빨간맛", "🥘 헤비"]
        for tag in exampleTags {
            let tagView = createTagView(with: tag)
            tagStackView.addArrangedSubview(tagView)
        }

        // 태그 스택뷰의 컨텐츠 크기 설정
        tagStackView.layoutIfNeeded()
        tagScrollView.contentSize = tagStackView.bounds.size
        
        // Auto Layout 설정
        circleView.translatesAutoresizingMaskIntoConstraints = false
        emojiLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        yesterdayFoodLabel.translatesAutoresizingMaskIntoConstraints = false
        tagScrollView.translatesAutoresizingMaskIntoConstraints = false
        tagStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            circleView.leadingAnchor.constraint(equalTo: friendView.leadingAnchor),
            circleView.centerYAnchor.constraint(equalTo: friendView.centerYAnchor),
            circleView.widthAnchor.constraint(equalToConstant: 70),
            circleView.heightAnchor.constraint(equalToConstant: 70),
            
            emojiLabel.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
            emojiLabel.centerYAnchor.constraint(equalTo: circleView.centerYAnchor),
            
            nameLabel.leadingAnchor.constraint(equalTo: circleView.trailingAnchor, constant: 10),
            nameLabel.topAnchor.constraint(equalTo: friendView.topAnchor, constant: 20),
            
            yesterdayFoodLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            yesterdayFoodLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
              ])
        
        return friendView
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
            
            tagView.translatesAutoresizingMaskIntoConstraints = false
            tagLabel.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                tagView.heightAnchor.constraint(equalToConstant: 24),
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
        buttonView.addTarget(self, action: #selector(dismissVC), for: .touchDown)

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
    
    @objc func dismissVC() {
        dismiss(animated: true, completion: nil)
    }
}
