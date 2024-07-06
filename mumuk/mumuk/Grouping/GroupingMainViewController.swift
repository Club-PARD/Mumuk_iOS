
//
//  GroupingMainViewController.swift
//  mumuk
//
//  Created by 김현중 on 7/4/24.
//

import UIKit

class GroupingMainViewController: UIViewController {
    var uid: String?
    var name: String?
    private var updateTimer: Timer?
    private var groupData: GroupResponse?
    private var titleLabel: UILabel!
    private var introLabel: UILabel!
    private let shadowedView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 30
        view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 3
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.backgroundColor = .white
        return view
    }()
    private let bottomViewHeight: CGFloat = 122
    
    // 이모지 배열
    private let emojis = ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨", "🐯"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupTitleLabel()
        setupBackButton()
        setupIntroLabel()
        
        // 초기 API 호출
        fetchGroupData()
        
        // 1초마다 API를 호출하는 타이머 설정
        updateTimer = Timer.scheduledTimer(withTimeInterval: 1000.0, repeats: true) { [weak self] _ in
            self?.fetchGroupData()
        }
    }
    
    private func fetchGroupData() {
        if let groupId = uid {
            APIService.fetchGroupData(groupId: groupId) { [weak self] result in
                switch result {
                case .success(let groupResponse):
                    self?.groupData = groupResponse
                    DispatchQueue.main.async {
                        self?.updateUI()
                    }
                case .failure(let error):
                    print("Error fetching group data: \(error)")
                }
            }
        }
    }

    private func updateUI() {
        setupShadowedView()
        setupFriendsLabel()
        setupBottomView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        updateTimer?.invalidate()
        updateTimer = nil
    }
    
    func setupTitleLabel() {
        titleLabel = UILabel()
        titleLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        titleLabel.font = UIFont(name: "Pretendard-SemiBold", size: 20)
        titleLabel.textAlignment = .center
        
        if let name = self.name {
            titleLabel.text = "\(name)님의 그룹"
        } else {
            titleLabel.text = "그룹"
        }
        
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20)
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
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            backButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor)
        ])
    }
    
    func setupIntroLabel() {
        introLabel = UILabel()
        introLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        introLabel.font = UIFont(name: "Pretendard-SemiBold", size: 18)
        introLabel.numberOfLines = 0
        introLabel.lineBreakMode = .byWordWrapping
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.93
        
        introLabel.attributedText = NSMutableAttributedString(
            string: "메뉴 추천 받을 준비가 \n다 되었나요?",
            attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle]
        )
        
        view.addSubview(introLabel)
        introLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            introLabel.widthAnchor.constraint(equalToConstant: 158),
            introLabel.heightAnchor.constraint(equalToConstant: 40),
            introLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            introLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 47)
        ])
    }
    
    func setupShadowedView() {
        // 원형 뷰 추가
        let circleView = UIView()
        circleView.frame = CGRect(x: 0, y: 0, width: 70, height: 70)
        circleView.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        circleView.layer.borderWidth = 2
        circleView.layer.borderColor = UIColor(red: 0.875, green: 0.875, blue: 0.875, alpha: 1).cgColor
        circleView.layer.cornerRadius = 35
        shadowedView.addSubview(circleView)
        circleView.translatesAutoresizingMaskIntoConstraints = false

        // Ready 텍스트가 있는 뷰 추가
        let readyView = UIView()
        readyView.frame = CGRect(x: 0, y: 0, width: 63, height: 23.85)
        readyView.layer.backgroundColor = UIColor(red: 0.875, green: 0.875, blue: 0.875, alpha: 1).cgColor
        readyView.layer.cornerRadius = 11.925
        shadowedView.addSubview(readyView)
        readyView.translatesAutoresizingMaskIntoConstraints = false
        
        // Ready 텍스트 레이블 추가
        let readyLabel = UILabel()
        readyLabel.text = "Ready"
        readyLabel.textColor = .white
        readyLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        readyLabel.textAlignment = .center
        readyView.addSubview(readyLabel)
        readyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // 이모티콘 레이블 추가
        let emojiLabel = UILabel()
        emojiLabel.text = "🐷"
        emojiLabel.font = UIFont.systemFont(ofSize: 40)
        emojiLabel.textAlignment = .center
        circleView.addSubview(emojiLabel)
        emojiLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // 어제 먹은 음식 레이블 추가
        let yesterdayFoodLabel = UILabel()
        yesterdayFoodLabel.font = UIFont(name: "Pretendard-Light", size: 11)

        let yesterdayText = "어제 먹은 음식은 "
        let questionText = "???"
        let attributedString1 = NSMutableAttributedString(string: yesterdayText)
        attributedString1.append(NSAttributedString(string: questionText, attributes: [.foregroundColor: UIColor(red: 1, green: 0.592, blue: 0.102, alpha: 1)]))

        yesterdayFoodLabel.attributedText = attributedString1

        shadowedView.addSubview(yesterdayFoodLabel)
        yesterdayFoodLabel.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(shadowedView)
        shadowedView.translatesAutoresizingMaskIntoConstraints = false
        
        // questionView를 스크롤 뷰로 변경
        let questionScrollView = UIScrollView()
        questionScrollView.showsHorizontalScrollIndicator = false
        shadowedView.addSubview(questionScrollView)
        questionScrollView.translatesAutoresizingMaskIntoConstraints = false
        
        let questionStackView = UIStackView()
        questionStackView.axis = .horizontal
        questionStackView.spacing = 10
        questionScrollView.addSubview(questionStackView)
        questionStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            questionStackView.topAnchor.constraint(equalTo: questionScrollView.topAnchor),
            questionStackView.leadingAnchor.constraint(equalTo: questionScrollView.leadingAnchor),
            questionStackView.trailingAnchor.constraint(equalTo: questionScrollView.trailingAnchor),
            questionStackView.bottomAnchor.constraint(equalTo: questionScrollView.bottomAnchor),
            questionStackView.heightAnchor.constraint(equalTo: questionScrollView.heightAnchor)
        ])

        // ??? 텍스트 레이블 추가
        let questionLabel = UILabel()
        questionLabel.text = "???"
        questionLabel.textColor = UIColor(red: 1, green: 0.592, blue: 0.102, alpha: 1)
        questionLabel.font = UIFont(name: "Pretendard-Regular", size: 12)
        questionLabel.textAlignment = .center
        
        NSLayoutConstraint.activate([
            questionScrollView.leadingAnchor.constraint(equalTo: yesterdayFoodLabel.leadingAnchor),
            questionScrollView.topAnchor.constraint(equalTo: yesterdayFoodLabel.bottomAnchor, constant: 7.5),
            questionScrollView.trailingAnchor.constraint(equalTo: shadowedView.trailingAnchor, constant: -20),
            questionScrollView.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        // MY 레이블 추가
        let myLabel = UILabel()
        myLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        myLabel.font = UIFont(name: "Pretendard-Bold", size: 14)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.2
        
        myLabel.attributedText = NSMutableAttributedString(string: "MY", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        
        shadowedView.addSubview(myLabel)
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // 오늘의 입맛 찾기 레이블 추가
         let findTasteLabel = UILabel()
         findTasteLabel.textColor = UIColor(red: 0.725, green: 0.725, blue: 0.725, alpha: 1)
         findTasteLabel.font = UIFont(name: "Pretendard-Medium", size: 11)
         
         let paragraphStyle2 = NSMutableParagraphStyle()
         paragraphStyle2.lineHeightMultiple = 1.52
         
         findTasteLabel.textAlignment = .center
         let attributedString = NSMutableAttributedString(string: "오늘의 입맛 찾기 >")
         attributedString.addAttributes([
             .underlineStyle: NSUnderlineStyle.single.rawValue,
             .paragraphStyle: paragraphStyle
         ], range: NSRange(location: 0, length: attributedString.length))
         findTasteLabel.attributedText = attributedString
         
         shadowedView.addSubview(findTasteLabel)
         findTasteLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        // leaderUser가 있을 때 updateUserView 호출
        if let leaderUser = groupData?.users.values.first(where: { $0.name == self.name }) {
            updateUserView(user: leaderUser, isLeader: true)
            
            // daily 상태에 따라 findTasteLabel 표시 여부 결정
            if leaderUser.daily {
                findTasteLabel.isHidden = true
            } else {
                findTasteLabel.isHidden = false
            }
        }
         
         // GroupingTextBalloon 이미지와 텍스트 레이블
         let balloonImageView = UIImageView(image: UIImage(named: "GroupingTextBalloon"))
         let balloonTextLabel = UILabel()
         balloonTextLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
         balloonTextLabel.font = UIFont(name: "Pretendard-SemiBold", size: 11)
         balloonTextLabel.textAlignment = .center
         balloonTextLabel.text = "오늘의 입맛 찾기를 완료하면 Ready 상태가 돼요!"
        
        shadowedView.addSubview(balloonTextLabel)
        balloonTextLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            shadowedView.widthAnchor.constraint(equalToConstant: 329),
            shadowedView.heightAnchor.constraint(equalToConstant: 118),
            shadowedView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            shadowedView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            shadowedView.topAnchor.constraint(equalTo: introLabel.bottomAnchor, constant: 29),
            
            circleView.widthAnchor.constraint(equalToConstant: 70),
            circleView.heightAnchor.constraint(equalToConstant: 70),
            circleView.centerXAnchor.constraint(equalTo: shadowedView.centerXAnchor, constant: -95.5),
            circleView.centerYAnchor.constraint(equalTo: shadowedView.centerYAnchor),
            
            emojiLabel.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
            emojiLabel.centerYAnchor.constraint(equalTo: circleView.centerYAnchor),
            
            readyView.widthAnchor.constraint(equalToConstant: 63),
            readyView.heightAnchor.constraint(equalToConstant: 23.85),
            readyView.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
            readyView.topAnchor.constraint(equalTo: circleView.bottomAnchor, constant: -10),
            
            readyLabel.topAnchor.constraint(equalTo: readyView.topAnchor),
            readyLabel.bottomAnchor.constraint(equalTo: readyView.bottomAnchor),
            readyLabel.leadingAnchor.constraint(equalTo: readyView.leadingAnchor),
            readyLabel.trailingAnchor.constraint(equalTo: readyView.trailingAnchor),
            
            myLabel.widthAnchor.constraint(equalToConstant: 77),
            myLabel.heightAnchor.constraint(equalToConstant: 21),
            myLabel.leadingAnchor.constraint(equalTo: circleView.trailingAnchor, constant: 20),
            myLabel.topAnchor.constraint(equalTo: shadowedView.topAnchor, constant: 30),
            
            yesterdayFoodLabel.widthAnchor.constraint(equalToConstant: 92),
            yesterdayFoodLabel.heightAnchor.constraint(equalToConstant: 13),
            yesterdayFoodLabel.leadingAnchor.constraint(equalTo: myLabel.leadingAnchor),
            yesterdayFoodLabel.topAnchor.constraint(equalTo: myLabel.bottomAnchor, constant: 5),
            questionScrollView.leadingAnchor.constraint(equalTo: yesterdayFoodLabel.leadingAnchor),
            questionScrollView.topAnchor.constraint(equalTo: yesterdayFoodLabel.bottomAnchor, constant: 7.5),
            questionScrollView.trailingAnchor.constraint(equalTo: shadowedView.trailingAnchor, constant: -20),
            questionScrollView.heightAnchor.constraint(equalToConstant: 24),
                       
            findTasteLabel.widthAnchor.constraint(equalToConstant: 82),
                findTasteLabel.heightAnchor.constraint(equalToConstant: 11.36),
            findTasteLabel.trailingAnchor.constraint(equalTo: shadowedView.trailingAnchor, constant: -37.5),
                findTasteLabel.centerYAnchor.constraint(equalTo: myLabel.centerYAnchor)
                   ])
                   
        // 버튼 기능 추가
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(findTasteTapped))
            findTasteLabel.isUserInteractionEnabled = true
            findTasteLabel.addGestureRecognizer(tapGesture)

            if let leaderUser = groupData?.users.values.first(where: { $0.name == self.name }) {
                updateUserView(user: leaderUser, isLeader: true)
                
                // daily 상태에 따라 balloon 표시 여부 결정
                if leaderUser.daily {
                    balloonImageView.isHidden = true
                    balloonTextLabel.isHidden = true
                } else {
                    shadowedView.addSubview(balloonImageView)
                    shadowedView.addSubview(balloonTextLabel)
                    balloonImageView.translatesAutoresizingMaskIntoConstraints = false
                    balloonTextLabel.translatesAutoresizingMaskIntoConstraints = false
                    
                    NSLayoutConstraint.activate([
                        balloonImageView.topAnchor.constraint(equalTo: readyView.bottomAnchor, constant: 3),
                        balloonImageView.centerXAnchor.constraint(equalTo: shadowedView.centerXAnchor),
                        balloonImageView.widthAnchor.constraint(equalToConstant: 237),
                        balloonImageView.heightAnchor.constraint(equalToConstant: 30),

                        balloonTextLabel.centerXAnchor.constraint(equalTo: balloonImageView.centerXAnchor),
                        balloonTextLabel.centerYAnchor.constraint(equalTo: balloonImageView.centerYAnchor, constant: 3),
                        balloonTextLabel.widthAnchor.constraint(equalToConstant: 219),
                        balloonTextLabel.heightAnchor.constraint(equalToConstant: 12)
                    ])
                }
            }
        }
               
               func setupFriendsLabel() {
                   let containerView = UIView()
                   view.addSubview(containerView)
                   containerView.translatesAutoresizingMaskIntoConstraints = false
                   
                   let numberLabel = UILabel()
                   let friendUsers = groupData?.users.values.filter { $0.name != self.name } ?? []
                   numberLabel.text = "\(friendUsers.count)"
                   numberLabel.font = UIFont(name: "Pretendard-SemiBold", size: 16)
                   numberLabel.textColor = UIColor(red: 1, green: 0.592, blue: 0.102, alpha: 1)
                   
                   let textLabel = UILabel()
                   textLabel.text = "명의 친구와 함께 먹어요"
                   textLabel.font = UIFont(name: "Pretendard-SemiBold", size: 16)
                   textLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
                   
                   containerView.addSubview(numberLabel)
                   containerView.addSubview(textLabel)
                   
                   numberLabel.translatesAutoresizingMaskIntoConstraints = false
                   textLabel.translatesAutoresizingMaskIntoConstraints = false
                   
                   NSLayoutConstraint.activate([
                       containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
                       containerView.topAnchor.constraint(equalTo: shadowedView.bottomAnchor, constant: 50),
                       containerView.heightAnchor.constraint(equalToConstant: 19),
                       
                       numberLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                       numberLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
                       
                       textLabel.leadingAnchor.constraint(equalTo: numberLabel.trailingAnchor, constant: 1),
                       textLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
                       
                       containerView.trailingAnchor.constraint(equalTo: textLabel.trailingAnchor)
                   ])
                   
                   // 스크롤뷰 주변에 테두리 추가
                   let borderView = UIView()
                   borderView.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
                   borderView.layer.cornerRadius = 25
                   borderView.layer.borderWidth = 1.5
                   borderView.layer.borderColor = UIColor(red: 0.929, green: 0.929, blue: 0.929, alpha: 1).cgColor
                   view.addSubview(borderView)
                   borderView.translatesAutoresizingMaskIntoConstraints = false
                   
                   NSLayoutConstraint.activate([
                       borderView.widthAnchor.constraint(equalToConstant: 330),
                       borderView.heightAnchor.constraint(equalToConstant: 426),
                       borderView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
                       borderView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
                       borderView.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 20)
                   ])
                   
                   // 스크롤뷰 설정
                   let scrollView = UIScrollView()
                   borderView.addSubview(scrollView)
                   scrollView.translatesAutoresizingMaskIntoConstraints = false
                   scrollView.showsVerticalScrollIndicator = false
                   scrollView.showsHorizontalScrollIndicator = false

                   let contentView = UIView()
                   scrollView.addSubview(contentView)
                   contentView.translatesAutoresizingMaskIntoConstraints = false
                   
                   NSLayoutConstraint.activate([
                       scrollView.topAnchor.constraint(equalTo: borderView.topAnchor),
                       scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -(bottomViewHeight + 5)),
                       scrollView.leadingAnchor.constraint(equalTo: borderView.leadingAnchor),
                       scrollView.trailingAnchor.constraint(equalTo: borderView.trailingAnchor),
                       
                       contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                       contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                       contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
                       contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                       contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
                   ])

                   for (index, user) in friendUsers.enumerated() {
                       let friendView = createFriendView(user: user)
                       contentView.addSubview(friendView)
                       friendView.translatesAutoresizingMaskIntoConstraints = false

                       NSLayoutConstraint.activate([
                           friendView.topAnchor.constraint(equalTo: index == 0 ? contentView.topAnchor : contentView.subviews[index * 2 - 1].bottomAnchor, constant: 10),
                           friendView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                           friendView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                           friendView.heightAnchor.constraint(equalToConstant: 118)
                       ])

                       // 마지막 친구가 아닌 경우에만 구분선 추가
                       if index < friendUsers.count - 1 {
                           let separatorView = createSeparatorView()
                           contentView.addSubview(separatorView)
                           
                           NSLayoutConstraint.activate([
                               separatorView.topAnchor.constraint(equalTo: friendView.bottomAnchor, constant: 10),
                               separatorView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                               separatorView.widthAnchor.constraint(equalToConstant: 258),
                               separatorView.heightAnchor.constraint(equalToConstant: 1.5)
                           ])
                       }

                       if index == friendUsers.count - 1 {
                           friendView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
                       }
                   }
               }
               
    func updateUserView(user: GroupUser, isLeader: Bool, in view: UIView? = nil) {
        let containerView: UIView
        if isLeader {
            containerView = shadowedView
        } else {
            guard let friendView = view else { return }
            containerView = friendView
        }

        guard let circleView = containerView.subviews.first(where: { $0 is UIView && $0.layer.cornerRadius == 35 }),
              let readyView = containerView.subviews.first(where: { $0 is UIView && $0.layer.cornerRadius == 11.925 }),
              let nameLabel = containerView.subviews.first(where: { $0 is UILabel && ($0 as? UILabel)?.font == UIFont(name: "Pretendard-Bold", size: 14) }) as? UILabel,
              let yesterdayFoodLabel = containerView.subviews.first(where: { $0 is UILabel && ($0 as? UILabel)?.font == UIFont(name: "Pretendard-Light", size: 11) }) as? UILabel,
              let tagScrollView = containerView.subviews.first(where: { $0 is UIScrollView }) as? UIScrollView
        else {
            print("Error: Unable to find required views")
            return
        }

        if user.daily {
            circleView.layer.borderColor = UIColor(red: 1, green: 0.592, blue: 0.102, alpha: 1).cgColor
            readyView.backgroundColor = UIColor(red: 1, green: 0.592, blue: 0.102, alpha: 1)
        } else {
            circleView.layer.borderColor = UIColor(red: 0.875, green: 0.875, blue: 0.875, alpha: 1).cgColor
            readyView.backgroundColor = UIColor(red: 0.875, green: 0.875, blue: 0.875, alpha: 1)
        }

        nameLabel.text = isLeader ? "MY" : user.name

        let foodText = user.notToday ?? "???"
        let attributedString = NSMutableAttributedString(string: "어제 먹은 음식은 ", attributes: [.foregroundColor: UIColor.black])
        attributedString.append(NSAttributedString(string: foodText, attributes: [.foregroundColor: UIColor(red: 1, green: 0.592, blue: 0.102, alpha: 1)]))
        yesterdayFoodLabel.attributedText = attributedString

        if isLeader {
            if let questionScrollView = containerView.subviews.first(where: { $0 is UIScrollView }) as? UIScrollView {
                updateTags(for: user, in: questionScrollView)
            }
        } else {
            if let tagScrollView = containerView.subviews.first(where: { $0 is UIScrollView }) as? UIScrollView {
                updateTags(for: user, in: tagScrollView)
            }
        }
    }
            
    func updateTags(for user: GroupUser, in scrollView: UIScrollView) {
        var tags: [String] = []

        if user.daily {
            // Daily true인 경우의 태그
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
            if user.todayNoSoup == 1 { tags.append("🍽️ 국물") }
            if user.redFood == 1 { tags.append("🌶️ 빨간맛") }
            if user.notRedFood == 1 { tags.append("🌶️🚫 안 빨간맛") }
            if user.todayRice == 1 { tags.append("🍙 밥") }
            if user.todayBread == 1 { tags.append("🍞 빵") }
            if user.todayNoodle == 1 { tags.append("🍜 면") }
        } else {
            // Daily false인 경우의 태그
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

        // 태그 업데이트 로직
        let stackView = scrollView.subviews.first { $0 is UIStackView } as? UIStackView ?? {
            let sv = UIStackView()
            sv.axis = .horizontal
            sv.spacing = 10
            scrollView.addSubview(sv)
            sv.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                sv.topAnchor.constraint(equalTo: scrollView.topAnchor),
                sv.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                sv.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
                sv.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                sv.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
            ])
            return sv
        }()

        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        for tag in tags {
            let tagView = createTagView(with: tag)
            stackView.addArrangedSubview(tagView)
        }
    }

               func createSeparatorView() -> UIView {
                   let separatorView = UIView()
                   separatorView.backgroundColor = UIColor(red: 0.929, green: 0.929, blue: 0.929, alpha: 1)
                   separatorView.translatesAutoresizingMaskIntoConstraints = false
                   return separatorView
               }
               
               func createFriendView(user: GroupUser) -> UIView {
                   let friendView = UIView()
                   friendView.backgroundColor = .white

                   // 원형 뷰
                   let circleView = UIView()
                   circleView.layer.cornerRadius = 35
                   circleView.layer.borderWidth = 2
                   circleView.layer.borderColor = UIColor(red: 0.875, green: 0.875, blue: 0.875, alpha: 1).cgColor
                   friendView.addSubview(circleView)

                   // 이모지 레이블
                   let emojiLabel = UILabel()
                   emojiLabel.text = getEmoji(for: user.imageId)
                   emojiLabel.font = .systemFont(ofSize: 40)
                   emojiLabel.textAlignment = .center
                   circleView.addSubview(emojiLabel)
                   
                   // Ready 텍스트가 있는 뷰 추가
                   let readyView = UIView()
                   readyView.frame = CGRect(x: 0, y: 0, width: 63, height: 23.85)
                   readyView.layer.backgroundColor = UIColor(red: 0.875, green: 0.875, blue: 0.875, alpha: 1).cgColor
                   readyView.layer.cornerRadius = 11.925 // height의 절반으로 설정하여 완전한 둥근 모서리 만들기
                   friendView.addSubview(readyView)
                   readyView.translatesAutoresizingMaskIntoConstraints = false
                   
                   // Ready 텍스트 레이블 추가
                   let readyLabel = UILabel()
                   readyLabel.text = "Ready"
                   readyLabel.textColor = .white
                          readyLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
                          readyLabel.textAlignment = .center
                          readyView.addSubview(readyLabel)
                          readyLabel.translatesAutoresizingMaskIntoConstraints = false

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
                   // 태그 스크롤뷰
                   let tagScrollView = UIScrollView()
                   tagScrollView.showsHorizontalScrollIndicator = false
                   friendView.addSubview(tagScrollView)

                          let tagStackView = UIStackView()
                          tagStackView.axis = .horizontal
                          tagStackView.spacing = 10
                          tagScrollView.addSubview(tagStackView)

                          // Auto Layout 설정
                          circleView.translatesAutoresizingMaskIntoConstraints = false
                          readyView.translatesAutoresizingMaskIntoConstraints = false
                          readyLabel.translatesAutoresizingMaskIntoConstraints = false
                          emojiLabel.translatesAutoresizingMaskIntoConstraints = false
                          nameLabel.translatesAutoresizingMaskIntoConstraints = false
                          yesterdayFoodLabel.translatesAutoresizingMaskIntoConstraints = false
                          tagScrollView.translatesAutoresizingMaskIntoConstraints = false
                          tagStackView.translatesAutoresizingMaskIntoConstraints = false

                          NSLayoutConstraint.activate([
                              circleView.leadingAnchor.constraint(equalTo: friendView.leadingAnchor, constant: 20),
                              circleView.centerYAnchor.constraint(equalTo: friendView.centerYAnchor),
                              circleView.widthAnchor.constraint(equalToConstant: 70),
                              circleView.heightAnchor.constraint(equalToConstant: 70),
                              
                              readyView.widthAnchor.constraint(equalToConstant: 63),
                              readyView.heightAnchor.constraint(equalToConstant: 23.85),
                              readyView.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
                              readyView.topAnchor.constraint(equalTo: circleView.bottomAnchor, constant: -10),
                              
                              readyLabel.topAnchor.constraint(equalTo: readyView.topAnchor),
                              readyLabel.bottomAnchor.constraint(equalTo: readyView.bottomAnchor),
                              readyLabel.leadingAnchor.constraint(equalTo: readyView.leadingAnchor),
                              readyLabel.trailingAnchor.constraint(equalTo: readyView.trailingAnchor),

                              emojiLabel.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
                              emojiLabel.centerYAnchor.constraint(equalTo: circleView.centerYAnchor),

                              nameLabel.leadingAnchor.constraint(equalTo: circleView.trailingAnchor, constant: 20),
                              nameLabel.topAnchor.constraint(equalTo: friendView.topAnchor, constant: 30),

                              yesterdayFoodLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
                              yesterdayFoodLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),

                              tagScrollView.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
                              tagScrollView.trailingAnchor.constraint(equalTo: friendView.trailingAnchor, constant: -20),
                              tagScrollView.topAnchor.constraint(equalTo: yesterdayFoodLabel.bottomAnchor, constant: 10),
                              tagScrollView.heightAnchor.constraint(equalToConstant: 24),

                              tagStackView.topAnchor.constraint(equalTo: tagScrollView.topAnchor),
                              tagStackView.leadingAnchor.constraint(equalTo: tagScrollView.leadingAnchor),
                              tagStackView.trailingAnchor.constraint(equalTo: tagScrollView.trailingAnchor),
                              tagStackView.bottomAnchor.constraint(equalTo: tagScrollView.bottomAnchor),
                              tagStackView.heightAnchor.constraint(equalTo: tagScrollView.heightAnchor)
                          ])
                          
                   updateUserView(user: user, isLeader: false, in: friendView)
                          return friendView
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
                      
                      func getEmoji(for imageId: Int) -> String {
                          return emojis[imageId % emojis.count]
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
                          buttonLabel.text = "메뉴 추천 START"

                          buttonView.addSubview(buttonLabel)
                          buttonLabel.translatesAutoresizingMaskIntoConstraints = false
                          NSLayoutConstraint.activate([
                              buttonLabel.centerXAnchor.constraint(equalTo: buttonView.centerXAnchor),
                              buttonLabel.centerYAnchor.constraint(equalTo: buttonView.centerYAnchor)
                          ])
                      }
    func checkGroupReadyStatus() -> Bool {
        let leaderReady = groupData?.users.values.first(where: { $0.name == self.name })?.daily ?? false
        let allFriendsReady = groupData?.users.values.filter({ $0.name != self.name }).allSatisfy({ $0.daily }) ?? false
        return leaderReady && allFriendsReady
    }

    func showNotReadyAlert() {
        let alert = UIAlertController(title: nil, message: "아직 Ready가 안된 그룹원들이 있어요! \n 정확한 입맛 적중률 측정을 위해 \n 조금만 더 기다려볼까요?", preferredStyle: .alert)
        
        let recommendAction = UIAlertAction(title: "메뉴 추천", style: .default) { [weak self] _ in
            self?.navigateToNextPage()
        }
        
        let waitAction = UIAlertAction(title: "기다리기", style: .default, handler: nil)
        
        // 메뉴 추천 액션을 먼저 추가하여 왼쪽에 위치하게 함
        alert.addAction(recommendAction)
        alert.addAction(waitAction)
        
        // 기다리기 액션을 preferred로 설정 (사용자가 Return 키를 누를 때 실행되는 액션)
        alert.preferredAction = waitAction
        
        present(alert, animated: true, completion: nil)
    }

    func navigateToNextPage() {
        // 다음 페이지로 이동하는 코드를 여기에 작성하세요.
        // 예: let nextVC = NextViewController()
        //     navigationController?.pushViewController(nextVC, animated: true)
    }
                      
                      @objc func findTasteTapped() {
                          print("오늘의 입맛 찾기가 탭되었습니다.")
                      }
                      
                      @objc func dismissVC() {
                          dismiss(animated: true, completion: nil)
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
        
        if checkGroupReadyStatus() {
            navigateToNextPage()
        } else {
            showNotReadyAlert()
        }
    }
                   }
