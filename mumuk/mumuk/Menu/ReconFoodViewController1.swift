import UIKit

class ReconFoodViewController1: UIViewController {
    
    var rank1: Rank?
    var rank2: Rank?
    var rank3: Rank?
    var userName: String?
    private var mainLabel: UILabel!
    private var subLabel: UILabel!
    private var reconFoodImageView: UIImageView!
    private var circleLayer = CAShapeLayer()
    private var progressLayer = CAShapeLayer()
    private var gradientLayer = CAGradientLayer()
    private var circularProgressView: UIView!
    private var foodNameLabel: UILabel!
    private var percentageLabel: UILabel!
    private var descriptionLabel: UILabel!
    private var detailLinkButton: UIButton!
    private var secondButton: UIButton!
    private var mainButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        if let rank1 = rank1 {
            setupUI(with: rank1)
        }
    }
    
    private func setupUI(with rank: Rank) {
         setupLabels()
         setupCircularProgressView()
         setupReconFoodImage(with: rank.image_url)
         setupFoodNameLabel(with: rank.foodname)
         setupPercentageLabel(with: rank.group_preference)
         setupDescriptionLabel(with: rank)
         setupDetailLinkButton()
         setupMainButton()
         setupsecondButton()
         
         setProgress(to: CGFloat(rank.group_preference / 100.0), withAnimation: false)
        
        // 데이터를 다 불러온 후 애니메이션 실행
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.animateProgress()
        }
     }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func setupLabels() {
        subLabel = UILabel()
        subLabel.textColor = UIColor(red: 1, green: 0.592, blue: 0.102, alpha: 1)
        subLabel.font = UIFont(name: "Pretendard-Bold", size: 15)
        let subParagraphStyle = NSMutableParagraphStyle()
        subParagraphStyle.lineHeightMultiple = 1.96
        subLabel.textAlignment = .center
        subLabel.attributedText = NSMutableAttributedString(string: "메뉴 추천 완료!", attributes: [NSAttributedString.Key.paragraphStyle: subParagraphStyle])
        view.addSubview(subLabel)
        subLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            subLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 37)
        ])
        
        mainLabel = UILabel()
        mainLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        mainLabel.font = UIFont(name: "Pretendard-Regular", size: 22) // 기본 폰트를 Regular로 변경
        mainLabel.numberOfLines = 0
        mainLabel.lineBreakMode = .byWordWrapping

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.14
        paragraphStyle.alignment = .center // 텍스트 전체를 중앙 정렬

        let attributedString = NSMutableAttributedString(string: "모두가 만족하는 식사가\n될 것 같아요! 🍽️", attributes: [
            .paragraphStyle: paragraphStyle,
            .font: UIFont(name: "Pretendard-Regular", size: 22)!
        ])

        // "모두가 만족하는 식사" 부분만 볼드 처리
        let boldRange = (attributedString.string as NSString).range(of: "모두가 만족하는 식사")
        attributedString.addAttribute(.font, value: UIFont(name: "Pretendard-Bold", size: 22)!, range: boldRange)

        mainLabel.attributedText = attributedString
        view.addSubview(mainLabel)
        mainLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainLabel.topAnchor.constraint(equalTo: subLabel.bottomAnchor, constant: 7),
            mainLabel.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 20),
            mainLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func setupCircularProgressView() {
        circularProgressView = UIView()
        circularProgressView.backgroundColor = .clear
        circularProgressView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(circularProgressView)

        NSLayoutConstraint.activate([
            circularProgressView.widthAnchor.constraint(equalToConstant: 251.07),
            circularProgressView.heightAnchor.constraint(equalToConstant: 251.07),
            circularProgressView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 71),
            circularProgressView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -71),
            circularProgressView.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 52)
        ])

        createCircularPath()
    }
    
    private func setupReconFoodImage(with imageUrl: String) {
        guard let circularProgressView = circularProgressView else {
            print("Error: circularProgressView is nil")
            return
        }

        reconFoodImageView = UIImageView()
        reconFoodImageView.contentMode = .scaleAspectFit
        circularProgressView.addSubview(reconFoodImageView)
        
        reconFoodImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            reconFoodImageView.widthAnchor.constraint(equalToConstant: 91),
            reconFoodImageView.heightAnchor.constraint(equalToConstant: 59),
            reconFoodImageView.topAnchor.constraint(equalTo: circularProgressView.topAnchor, constant: 66),
            reconFoodImageView.centerXAnchor.constraint(equalTo: circularProgressView.centerXAnchor)
        ])
        
        if let url = URL(string: imageUrl) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.reconFoodImageView.image = image
                    }
                }
            }
        }
    }
    
    private func setupFoodNameLabel(with foodName: String) {
        foodNameLabel = UILabel()
        foodNameLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        foodNameLabel.font = UIFont(name: "Pretendard-Light", size: 15)
        foodNameLabel.text = "1등 \(foodName)"
        view.addSubview(foodNameLabel)
         
        foodNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            foodNameLabel.heightAnchor.constraint(equalToConstant: 18),
            foodNameLabel.centerXAnchor.constraint(equalTo: circularProgressView.centerXAnchor),
            foodNameLabel.topAnchor.constraint(equalTo: reconFoodImageView.bottomAnchor, constant: 10)
        ])
    }

    private func setupPercentageLabel(with percentage: Double) {
        percentageLabel = UILabel()
        percentageLabel.textColor = UIColor(red: 1, green: 0.546, blue: 0, alpha: 1)
        percentageLabel.font = UIFont(name: "Pretendard-Black", size: 28)
        percentageLabel.textAlignment = .center
        percentageLabel.text = "\(Int(percentage))%"
        view.addSubview(percentageLabel)
         
        percentageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            percentageLabel.heightAnchor.constraint(equalToConstant: 33),
            percentageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0.66),
            percentageLabel.topAnchor.constraint(equalTo: foodNameLabel.bottomAnchor, constant: 5)
        ])
    }

    private func createCircularPath() {
        
        view.layoutIfNeeded()
        
        let center = CGPoint(x: circularProgressView.bounds.midX, y: circularProgressView.bounds.midY)
        let radius = (min(circularProgressView.bounds.width, circularProgressView.bounds.height) - 30) / 2
        let circularPath = UIBezierPath(arcCenter: center,
                                        radius: radius,
                                        startAngle: 0,
                                        endAngle: CGFloat.pi * 2,
                                        clockwise: true)
        
        circleLayer.path = circularPath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.lineCap = .round
        circleLayer.lineWidth = 30.0
        circleLayer.strokeColor = UIColor(white: 0.9, alpha: 0.3).cgColor
        
        progressLayer.path = circularPath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineCap = .round
        progressLayer.lineWidth = 30.0
        progressLayer.strokeEnd = 0
        progressLayer.strokeColor = UIColor.black.cgColor
        
        gradientLayer.frame = circularProgressView.bounds
        gradientLayer.colors = [
            UIColor(red: 1, green: 0.8, blue: 0.4, alpha: 1).cgColor,
            UIColor(red: 1, green: 0.592, blue: 0.102, alpha: 1).cgColor
        ]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        
        // 그라데이션 레이어를 회전시켜 원형으로 만듭니다
        gradientLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
        
        circularProgressView.layer.addSublayer(circleLayer)
        circularProgressView.layer.addSublayer(gradientLayer)
        
        gradientLayer.mask = progressLayer
    
        if let reconFoodImageView = reconFoodImageView {
            circularProgressView.bringSubviewToFront(reconFoodImageView)
        }
    }
    
    internal func animateProgress() {
          let animation = CABasicAnimation(keyPath: "strokeEnd")
          animation.duration = 1.5
          animation.fromValue = 0
          animation.toValue = progressLayer.strokeEnd
          animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
          progressLayer.add(animation, forKey: "animateProgress")
      }
    
    func setProgress(to progressConstant: CGFloat, withAnimation: Bool) {
        let duration: CFTimeInterval = withAnimation ? 0.3 : 0
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = duration
        animation.fromValue = progressLayer.strokeEnd
        animation.toValue = progressConstant
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        progressLayer.strokeEnd = progressConstant
        progressLayer.add(animation, forKey: "animateProgress")
    }

    private func setupDescriptionLabel(with rank: Rank) {
           descriptionLabel = UILabel()
           descriptionLabel.textColor = UIColor(red: 0.725, green: 0.725, blue: 0.725, alpha: 1)
           descriptionLabel.font = UIFont(name: "Pretendard-Bold", size: 16)
           descriptionLabel.numberOfLines = 0
           descriptionLabel.lineBreakMode = .byWordWrapping
           
           let paragraphStyle = NSMutableParagraphStyle()
           paragraphStyle.lineHeightMultiple = 1.26
           paragraphStyle.alignment = .center
           
            let fullString = "\(userName ?? "그룹")님의 그룹의 선호가\n\(Int(rank.group_preference))% 반영된 최적의 메뉴에요!"
           let attributedString = NSMutableAttributedString(string: fullString, attributes: [
               .paragraphStyle: paragraphStyle,
               .font: UIFont(name: "Pretendard-Bold", size: 16)!,
               .foregroundColor: UIColor(red: 0.725, green: 0.725, blue: 0.725, alpha: 1)
           ])
           
           let percentageRange = (fullString as NSString).range(of: String(format: "%.1f%%", rank.group_preference))
           attributedString.addAttributes([
               .foregroundColor: UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
           ], range: percentageRange)
           
           descriptionLabel.attributedText = attributedString
           
           view.addSubview(descriptionLabel)
           descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
           
           NSLayoutConstraint.activate([
               descriptionLabel.widthAnchor.constraint(equalToConstant: 250),
               descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
               descriptionLabel.topAnchor.constraint(equalTo: circularProgressView.bottomAnchor, constant: 30)
           ])
       }
    
    private func setupDetailLinkButton() {
        detailLinkButton = UIButton(type: .system)
        detailLinkButton.tintColor = UIColor(red: 1, green: 0.592, blue: 0.102, alpha: 1)
        detailLinkButton.titleLabel?.font = UIFont(name: "Pretendard-Bold", size: 13)
        
        let attributedString = NSMutableAttributedString(string: "추천 상세 보기 >")
        attributedString.addAttribute(.underlineStyle,
                                      value: NSUnderlineStyle.single.rawValue,
                                      range: NSRange(location: 0, length: attributedString.length))
        
        detailLinkButton.setAttributedTitle(attributedString, for: .normal)
        
        detailLinkButton.addTarget(self, action: #selector(detailLinkTapped), for: .touchUpInside)
        
        view.addSubview(detailLinkButton)
        detailLinkButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            detailLinkButton.widthAnchor.constraint(equalToConstant: 101.24),
            detailLinkButton.heightAnchor.constraint(equalToConstant: 18),
            detailLinkButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0.12),
            detailLinkButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 15)
        ])
    }

    @objc private func detailLinkTapped() {
        presentRecommendationDetail()
    }
    
    private func setupsecondButton() {
        secondButton = UIButton(type: .custom)
        secondButton.backgroundColor = UIColor(red: 1, green: 0.965, blue: 0.925, alpha: 1)
        secondButton.layer.cornerRadius = 24 // Half of the height to make it fully rounded
        
        secondButton.setTitle("2, 3등 메뉴 보러가기", for: .normal)
        secondButton.setTitleColor(UIColor(red: 1, green: 0.592, blue: 0.102, alpha: 1), for: .normal)
        secondButton.titleLabel?.font = UIFont(name: "Pretendard-Bold", size: 16)
        
        secondButton.addTarget(self, action: #selector(secondButtonTapped), for: .touchUpInside)
        
        view.addSubview(secondButton)
        
        secondButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            secondButton.widthAnchor.constraint(equalToConstant: 328.89),
            secondButton.heightAnchor.constraint(equalToConstant: 48),
            secondButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),            secondButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            secondButton.bottomAnchor.constraint(equalTo: mainButton.topAnchor, constant: -16)
        ])
    }

    @objc private func secondButtonTapped() {
        toReconFoodVC()
    }
    
    private func setupMainButton() {
         mainButton = UIButton(type: .custom)
         mainButton.backgroundColor = UIColor(red: 1, green: 0.592, blue: 0.102, alpha: 1)
         mainButton.layer.cornerRadius = 24 // 높이의 절반으로 설정하여 완전히 둥글게 만듭니다

         mainButton.setTitle("메인으로", for: .normal)
         mainButton.setTitleColor(.white, for: .normal)
         mainButton.titleLabel?.font = UIFont(name: "Pretendard-Bold", size: 16)

         mainButton.addTarget(self, action: #selector(mainButtonTapped), for: .touchUpInside)

         view.addSubview(mainButton)

         mainButton.translatesAutoresizingMaskIntoConstraints = false
         NSLayoutConstraint.activate([
             mainButton.widthAnchor.constraint(equalToConstant: 329),
             mainButton.heightAnchor.constraint(equalToConstant: 48),
             mainButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
             mainButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
             mainButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
         ])
     }

     @objc private func mainButtonTapped() {
         toMain()
     }
    
    private func presentRecommendationDetail() {
        let detailVC = RecommendationDetailViewController1()
        
        detailVC.rank = rank1 // rank1 데이터를 전달
        
        if let sheet = detailVC.sheetPresentationController {
            sheet.detents = [.large()]
            sheet.prefersGrabberVisible = true
        }
        
        present(detailVC, animated: true, completion: nil)
    }
    
    private func toMain() {
        let mainVC = TabbarViewController()
        
        mainVC.modalPresentationStyle = .fullScreen  // 전체 화면으로 설정
        present(mainVC, animated: true, completion: nil)
    }
    
    private func toReconFoodVC() {
        let reconFoodVC2 = ReconFoodViewController2()
        
        reconFoodVC2.rank2 = rank2
        reconFoodVC2.rank3 = rank3
        reconFoodVC2.userName = userName
        
        reconFoodVC2.modalPresentationStyle = .fullScreen  // 전체 화면으로 설정
        present(reconFoodVC2, animated: true, completion: nil)
    }
}
