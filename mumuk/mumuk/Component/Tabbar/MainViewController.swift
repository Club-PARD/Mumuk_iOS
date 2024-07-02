import UIKit

class MainViewController: UIViewController {
    let uid = "1111123" // 테스트용 임의의 UID
    var timer: Timer?
    var name: String?

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "mumuk")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let firstLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = UIFont(name: "Pretendard-Regular", size: 20)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.26
        label.attributedText = NSMutableAttributedString(string: "오늘은 누구와 함께", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        return label
    }()
    
    let secondLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = UIFont(name: "Pretendard-Regular", size: 20)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.26
        label.attributedText = NSMutableAttributedString(string: "행복한 식사를 해볼까요?", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        return label
    }()
    
    let emojiImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "emoji")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    let shadowView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 30
        view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 3
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        return view
    }()

    let whiteView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 30
        return view
    }()

    let foodPreferenceLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 1, green: 0.592, blue: 0.102, alpha: 1)
        label.font = UIFont(name: "Pretendard-Bold", size: 13)
        label.text = "오늘의 음식 취향은?"
        return label
    }()

    let dailyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "Pretendard-Bold", size: 22)
        label.text = "데일리"
        return label
    }()

    let foodScrumLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "Pretendard-Bold", size: 22)
        label.text = "푸드 스크럼"
        return label
    }()

    let preferenceButton: UIButton = {
        let button = UIButton()
        button.setTitle("선호도 입력하러 가기 >", for: .normal)
        button.setTitleColor(UIColor(red: 1, green: 0.592, blue: 0.102, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "Pretendard-Regular", size: 13)
        button.layer.cornerRadius = 17
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 1, green: 0.592, blue: 0.102, alpha: 1).cgColor
        return button
    }()

    let textBalloonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "textballoon")
        imageView.contentMode = .scaleToFill
        return imageView
    }()

    let foodScrumCompleteLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "Pretendard-SemiBold", size: 10)
        label.text = "푸드 스크럼 하셨나요? 😋"
        label.textAlignment = .center
        return label
    }()

    let secondShadowView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 329, height: 298)
        view.clipsToBounds = false
        return view
    }()

    let secondShapeView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 30
        return view
    }()

    let tastyMeetingLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 1, green: 0.592, blue: 0.102, alpha: 1)
        label.font = UIFont(name: "Pretendard-Bold", size: 13)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.29
        label.attributedText = NSMutableAttributedString(string: "맛있는 모임을 만들어 볼까요?", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        return label
    }()

    let eatTogetherLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "Pretendard-Bold", size: 22)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.14
        label.attributedText = NSMutableAttributedString(string: "함께 먹기", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        return label
    }()
    
    let groupBeforeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "groupBefore"), for: .normal)
        button.setImage(UIImage(named: "groupBefore"), for: .disabled)
        button.adjustsImageWhenHighlighted = false
        button.adjustsImageWhenDisabled = false
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    let createButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "create"), for: .normal)
        button.contentMode = .scaleAspectFit
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        setupButtonActions()
        fetchUserData() // 초기 데이터 로드
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.fetchUserData()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchUserData()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
        timer = nil
    }

    private func setupUI() {
        view.addSubview(imageView)
        view.addSubview(firstLabel)
        view.addSubview(secondLabel)
        view.addSubview(emojiImageView)
        view.addSubview(shadowView)
        shadowView.addSubview(whiteView)
        whiteView.addSubview(foodPreferenceLabel)
        whiteView.addSubview(dailyLabel)
        whiteView.addSubview(foodScrumLabel)
        whiteView.addSubview(preferenceButton)
        whiteView.addSubview(textBalloonImageView)
        textBalloonImageView.addSubview(foodScrumCompleteLabel)
        view.addSubview(secondShadowView)
        secondShadowView.addSubview(secondShapeView)
        view.addSubview(tastyMeetingLabel)
        view.addSubview(eatTogetherLabel)
        secondShadowView.addSubview(groupBeforeButton)
        secondShadowView.addSubview(createButton)
        setupConstraints()
        setupShadow()
    }

    private func setupConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        firstLabel.translatesAutoresizingMaskIntoConstraints = false
        secondLabel.translatesAutoresizingMaskIntoConstraints = false
        emojiImageView.translatesAutoresizingMaskIntoConstraints = false
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        whiteView.translatesAutoresizingMaskIntoConstraints = false
        foodPreferenceLabel.translatesAutoresizingMaskIntoConstraints = false
        dailyLabel.translatesAutoresizingMaskIntoConstraints = false
        foodScrumLabel.translatesAutoresizingMaskIntoConstraints = false
        preferenceButton.translatesAutoresizingMaskIntoConstraints = false
        textBalloonImageView.translatesAutoresizingMaskIntoConstraints = false
        foodScrumCompleteLabel.translatesAutoresizingMaskIntoConstraints = false
        secondShadowView.translatesAutoresizingMaskIntoConstraints = false
        secondShapeView.translatesAutoresizingMaskIntoConstraints = false
        tastyMeetingLabel.translatesAutoresizingMaskIntoConstraints = false
        eatTogetherLabel.translatesAutoresizingMaskIntoConstraints = false
        groupBeforeButton.translatesAutoresizingMaskIntoConstraints = false
        createButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 103),
            imageView.heightAnchor.constraint(equalToConstant: 20),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 66),
            
            firstLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            firstLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 25),
            firstLabel.widthAnchor.constraint(equalToConstant: 149),
            firstLabel.heightAnchor.constraint(equalToConstant: 24),
            
            secondLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            secondLabel.topAnchor.constraint(equalTo: firstLabel.bottomAnchor, constant: 11),
            secondLabel.widthAnchor.constraint(equalToConstant: 195),
            secondLabel.heightAnchor.constraint(equalToConstant: 25),
            
            emojiImageView.widthAnchor.constraint(equalToConstant: 81),
            emojiImageView.heightAnchor.constraint(equalToConstant: 80),
            emojiImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            emojiImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 91),

            shadowView.topAnchor.constraint(equalTo: secondLabel.bottomAnchor, constant: 30),
            shadowView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            shadowView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            shadowView.widthAnchor.constraint(equalToConstant: 329),
            shadowView.heightAnchor.constraint(equalToConstant: 169),

            whiteView.topAnchor.constraint(equalTo: shadowView.topAnchor),
            whiteView.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor),
            whiteView.trailingAnchor.constraint(equalTo: shadowView.trailingAnchor),
            whiteView.bottomAnchor.constraint(equalTo: shadowView.bottomAnchor),

            foodPreferenceLabel.topAnchor.constraint(equalTo: whiteView.topAnchor, constant: 22),
            foodPreferenceLabel.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor, constant: 20),

            dailyLabel.topAnchor.constraint(equalTo: foodPreferenceLabel.bottomAnchor, constant: 1),
            dailyLabel.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor, constant: 20),

            foodScrumLabel.topAnchor.constraint(equalTo: dailyLabel.bottomAnchor, constant: 1),
            foodScrumLabel.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor, constant: 20),

            preferenceButton.bottomAnchor.constraint(equalTo: whiteView.bottomAnchor, constant: -22),
            preferenceButton.trailingAnchor.constraint(equalTo: whiteView.trailingAnchor, constant: -20),
            preferenceButton.widthAnchor.constraint(equalToConstant: 140),
            preferenceButton.heightAnchor.constraint(equalToConstant: 34),

            textBalloonImageView.bottomAnchor.constraint(equalTo: preferenceButton.topAnchor, constant: -2),
            textBalloonImageView.trailingAnchor.constraint(equalTo: whiteView.trailingAnchor, constant: -14.65),
            textBalloonImageView.widthAnchor.constraint(equalToConstant: 124),
            textBalloonImageView.heightAnchor.constraint(equalToConstant: 32),

            foodScrumCompleteLabel.centerXAnchor.constraint(equalTo: textBalloonImageView.centerXAnchor),
            foodScrumCompleteLabel.centerYAnchor.constraint(equalTo: textBalloonImageView.centerYAnchor, constant: -3),
            foodScrumCompleteLabel.widthAnchor.constraint(equalTo: textBalloonImageView.widthAnchor, constant: -10),
            foodScrumCompleteLabel.heightAnchor.constraint(equalToConstant: 20),
            
            secondShadowView.widthAnchor.constraint(equalToConstant: 329),
            secondShadowView.heightAnchor.constraint(equalToConstant: 270),
            secondShadowView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            secondShadowView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            secondShadowView.topAnchor.constraint(equalTo: view.topAnchor, constant: 391),

            secondShapeView.topAnchor.constraint(equalTo: secondShadowView.topAnchor),
            secondShapeView.leadingAnchor.constraint(equalTo: secondShadowView.leadingAnchor),
            secondShapeView.trailingAnchor.constraint(equalTo: secondShadowView.trailingAnchor),
            secondShapeView.bottomAnchor.constraint(equalTo: secondShadowView.bottomAnchor),

            tastyMeetingLabel.widthAnchor.constraint(equalToConstant: 155),
            tastyMeetingLabel.heightAnchor.constraint(equalToConstant: 20),
            tastyMeetingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 53),
            tastyMeetingLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 411),

            eatTogetherLabel.widthAnchor.constraint(equalToConstant: 83.38),
            eatTogetherLabel.heightAnchor.constraint(equalToConstant: 30),
            eatTogetherLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 53),
            eatTogetherLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 432),
            
            groupBeforeButton.widthAnchor.constraint(equalToConstant: 135.51),
            groupBeforeButton.heightAnchor.constraint(equalToConstant: 118),
            groupBeforeButton.trailingAnchor.constraint(equalTo: secondShadowView.trailingAnchor),
            groupBeforeButton.bottomAnchor.constraint(equalTo: secondShadowView.bottomAnchor),
            
            createButton.widthAnchor.constraint(equalToConstant: 45),
            createButton.heightAnchor.constraint(equalToConstant: 45),
            createButton.trailingAnchor.constraint(equalTo: secondShadowView.trailingAnchor, constant: -20),
            createButton.topAnchor.constraint(equalTo: secondShadowView.topAnchor, constant: 73)
        ])
    }
    
    private func setupButtonActions() {
        preferenceButton.addTarget(self, action: #selector(buttonTouchDown), for: .touchDown)
        preferenceButton.addTarget(self, action: #selector(buttonTouchUpInside), for: [.touchUpInside, .touchUpOutside])
        groupBeforeButton.addTarget(self, action: #selector(groupButtonTapped), for: .touchUpInside)
        createButton.addTarget(self, action: #selector(createButtonTapped), for: .touchUpInside)  // 추가
    }

    @objc private func createButtonTapped() {
        let friendGroupingVC = FriendGroupingViewController()
        friendGroupingVC.uid = self.uid  // uid 전달
        friendGroupingVC.name = self.name  // name 전달
        friendGroupingVC.modalPresentationStyle = .fullScreen  // 전체 화면으로 설정
        present(friendGroupingVC, animated: true, completion: nil)
    }

    @objc private func buttonTouchDown() {
        preferenceButton.backgroundColor = .lightGray
    }

    @objc private func buttonTouchUpInside() {
        preferenceButton.backgroundColor = .clear
    }

    @objc private func groupButtonTapped() {
        if groupBeforeButton.isEnabled {
            fetchUserData()
        }
    }

    private func setupShadow() {
        secondShadowView.layoutIfNeeded()
        
        let customPath = createCustomPath()
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = customPath.cgPath
        secondShapeView.layer.mask = shapeLayer
        
        secondShadowView.layer.shadowPath = customPath.cgPath
        secondShadowView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        secondShadowView.layer.shadowOpacity = 0.5
        secondShadowView.layer.shadowRadius = 3
        secondShadowView.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        secondShadowView.layer.masksToBounds = false
    }
    
    private func createCustomPath() -> UIBezierPath {
        let path = UIBezierPath()
        let cornerRadius: CGFloat = 30
        let width = secondShadowView.bounds.width
        let height = secondShadowView.bounds.height
        let cutoutWidth = width / 2  // 가로 절반
        let cutoutHeight = height / 2  // 세로 절반

        path.move(to: CGPoint(x: cornerRadius, y: 0))
        path.addLine(to: CGPoint(x: width - cornerRadius, y: 0))
        path.addArc(withCenter: CGPoint(x: width - cornerRadius, y: cornerRadius), radius: cornerRadius, startAngle: CGFloat(-Double.pi/2), endAngle: 0, clockwise: true)
        path.addLine(to: CGPoint(x: width, y: height - cutoutHeight - cornerRadius))
        path.addArc(withCenter: CGPoint(x: width - cornerRadius, y: height - cutoutHeight - cornerRadius), radius: cornerRadius, startAngle: 0, endAngle: CGFloat(Double.pi/2), clockwise: true)
        path.addLine(to: CGPoint(x: width - cutoutWidth + cornerRadius, y: height - cutoutHeight))
        path.addArc(withCenter: CGPoint(x: width - cutoutWidth + cornerRadius, y: height - cutoutHeight + cornerRadius), radius: cornerRadius, startAngle: CGFloat(-Double.pi/2), endAngle: CGFloat(-Double.pi), clockwise: false)
        path.addLine(to: CGPoint(x: width - cutoutWidth, y: height - cornerRadius))
        path.addArc(withCenter: CGPoint(x: width - cutoutWidth - cornerRadius, y: height - cornerRadius), radius: cornerRadius, startAngle: 0, endAngle: CGFloat(Double.pi/2), clockwise: true)
        path.addLine(to: CGPoint(x: cornerRadius, y: height))
        path.addArc(withCenter: CGPoint(x: cornerRadius, y: height - cornerRadius), radius: cornerRadius, startAngle: CGFloat(Double.pi/2), endAngle: CGFloat(Double.pi), clockwise: true)
        path.addLine(to: CGPoint(x: 0, y: cornerRadius))
        path.addArc(withCenter: CGPoint(x: cornerRadius, y: cornerRadius), radius: cornerRadius, startAngle: CGFloat(Double.pi), endAngle: CGFloat(-Double.pi/2), clockwise: true)
        
        path.close()
        return path
    }
    
    private func fetchUserData() {
        guard let url = URL(string: "http://172.30.1.21:8080/user/users?uid=\(uid)") else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            do {
                let users = try JSONDecoder().decode([User].self, from: data)
                if let user = users.first {
                    DispatchQueue.main.async {
                        self?.name = user.name
                        self?.updateGroupButton(isGrouped: user.grouped)
                    }
                }
            } catch {
                print("Decoding error: \(error.localizedDescription)")
            }
        }.resume()
    }

    private func updateGroupButton(isGrouped: Bool) {
        let imageName = isGrouped ? "groupAfter" : "groupBefore"
        groupBeforeButton.setImage(UIImage(named: imageName), for: .normal)
        groupBeforeButton.setImage(UIImage(named: imageName), for: .disabled)
        groupBeforeButton.isEnabled = isGrouped
        groupBeforeButton.adjustsImageWhenHighlighted = isGrouped
    }
}

struct User: Codable {
    let uid: String
    let name: String
    let imageId: Int
    let grouped: Bool
    let daily: Bool
}
