import UIKit

class RecommendationDetailViewController3: UIViewController {
    
    var rank3: Rank?
    
    private var titleLabel: UILabel!
    private var descriptionLabel: UILabel!
    private var categoryLabel: UILabel!
    private var percentageLabel: UILabel!
    private var progressLayers: [CAShapeLayer] = []
    private var gradientLayers: [CAGradientLayer] = []
    private var animationCompleted = false
    private var finalProgressValues: [CGFloat] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupTitleLabel()
        setupDescriptionLabel()
        setupFoodImageView()
        setupAdditionalUIElements()
        
        
        modalPresentationStyle = .custom
        // 트랜지션 델리게이트 설정
        transitioningDelegate = self
        finalProgressValues = Array(repeating: 0, count: 6) // 카테고리 수에 맞춰 조정
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // 뷰가 완전히 나타난 후 약간의 지연 시간을 두고 애니메이션 설정 및 시작
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            self?.setupAndStartAnimation()
        }
    }
    
    private func setupAndStartAnimation() {
        view.layoutIfNeeded() // 강제로 레이아웃 업데이트
        updateProgressLayerPaths() // 프로그레스 레이어 경로 재설정
        
        // 프로그레스바 레이아웃 확인 및 로그 출력
        for (index, gradientLayer) in gradientLayers.enumerated() {
            print("Gradient Layer \(index) frame: \(gradientLayer.frame)")
            print("Progress Layer \(index) frame: \(progressLayers[index].frame)")
        }
        
        // 애니메이션 시작
        startProgressAnimation()
    }
    
    func startProgressAnimation() {
        for index in 0..<self.progressLayers.count {
            self.animateProgress(for: index)
        }
        animationCompleted = true
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateProgressLayerPaths()
        setupInitialProgressLayerStates()
    }
    private func setupInitialProgressLayerStates() {
        for progressLayer in progressLayers {
            progressLayer.strokeEnd = 0
        }
    }
    
    private func animateProgress(for index: Int) {
           guard let maskLayer = gradientLayers[index].mask as? CAShapeLayer else { return }
           
           maskLayer.removeAnimation(forKey: "animateProgress")
           
           let animation = CABasicAnimation(keyPath: "strokeEnd")
           animation.duration = 1.5
           animation.fromValue = 0
           let randomPercentage = CGFloat.random(in: 0...1)
           animation.toValue = randomPercentage
           animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
           animation.fillMode = .forwards
           animation.isRemovedOnCompletion = false
           
           maskLayer.add(animation, forKey: "animateProgress")
           maskLayer.strokeEnd = randomPercentage
           finalProgressValues[index] = randomPercentage
       }

    
    private func setupTitleLabel() {
        titleLabel = UILabel()
        titleLabel.frame = CGRect(x: 0, y: 0, width: 197, height: 35)
        titleLabel.textColor = UIColor(red: 1, green: 0.592, blue: 0.102, alpha: 1)
        titleLabel.font = UIFont(name: "Pretendard-Bold", size: 15)
        let titleParagraphStyle = NSMutableParagraphStyle()
        titleParagraphStyle.lineHeightMultiple = 1.96
        titleLabel.textAlignment = .center
        titleLabel.attributedText = NSMutableAttributedString(string: "추천 이유를 퍼센트로 보여드려요!", attributes: [NSAttributedString.Key.paragraphStyle: titleParagraphStyle])
        
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalToConstant: 197),
            titleLabel.heightAnchor.constraint(equalToConstant: 35),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 43.17)
        ])
    }
    
    private func setupDescriptionLabel() {
        descriptionLabel = UILabel()
        descriptionLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        descriptionLabel.font = UIFont(name: "Pretendard-Bold", size: 22)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.textAlignment = .center // 텍스트 전체를 중앙 정렬

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.14
        paragraphStyle.alignment = .center

        let line1 = NSAttributedString(string: "모두의 입맛이 고려된\n", attributes: [.paragraphStyle: paragraphStyle])
        let line2 = NSAttributedString(string: "최적의 메뉴에요!", attributes: [.paragraphStyle: paragraphStyle])

        let attributedString = NSMutableAttributedString()
        attributedString.append(line1)
        attributedString.append(line2)

        descriptionLabel.attributedText = attributedString
        view.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 7)
        ])
    }
    
    private func setupFoodImageView() {
        let foodImageView = UIImageView(image: UIImage(named: "reconFood"))
        foodImageView.contentMode = .scaleAspectFit
        view.addSubview(foodImageView)
        
        foodImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            foodImageView.widthAnchor.constraint(equalToConstant: 178.33),
            foodImageView.heightAnchor.constraint(equalToConstant: 115.68),
            foodImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            foodImageView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 36)
        ])
        
        setupRankLabel(belowImageView: foodImageView)
    }

    private func setupRankLabel(belowImageView imageView: UIImageView) {
         let rankLabel = UILabel()
         rankLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
         rankLabel.font = UIFont(name: "Pretendard-Light", size: 15)
         rankLabel.text = "1등 스파게티"
         
         view.addSubview(rankLabel)
         rankLabel.translatesAutoresizingMaskIntoConstraints = false
         
         NSLayoutConstraint.activate([
             rankLabel.widthAnchor.constraint(equalToConstant: 75),
             rankLabel.heightAnchor.constraint(equalToConstant: 18),
             rankLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor  ),
             rankLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 26.8)
         ])
         
         setupPercentageLabel(belowLabel: rankLabel)
     }
     
     private func setupPercentageLabel(belowLabel label: UILabel) {
         percentageLabel = UILabel()
         percentageLabel.frame = CGRect(x: 0, y: 0, width: 96, height: 36)
         percentageLabel.textColor = UIColor(red: 1, green: 0.592, blue: 0.102, alpha: 1)
         percentageLabel.font = UIFont(name: "Pretendard-Black", size: 30)
         percentageLabel.textAlignment = .center
         percentageLabel.text = "92.7%"
         
         view.addSubview(percentageLabel)
         percentageLabel.translatesAutoresizingMaskIntoConstraints = false
         
         NSLayoutConstraint.activate([
             percentageLabel.widthAnchor.constraint(equalToConstant: 96),
             percentageLabel.heightAnchor.constraint(equalToConstant: 36),
             percentageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
             percentageLabel.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 4)
         ])
     }
    
    private func setupAdditionalUIElements() {
        let categories = ["면", "육류", "양식", "헤비", "NO국물", "안 빨간 맛"]
        var previousCategoryLabel: UILabel?

        for (index, category) in categories.enumerated() {
            let containerView = UIView()
            view.addSubview(containerView)
            containerView.translatesAutoresizingMaskIntoConstraints = false

            // Category Label
            let categoryLabel = UILabel()
            categoryLabel.textColor = UIColor(red: 0.58, green: 0.58, blue: 0.58, alpha: 1)
            categoryLabel.font = UIFont(name: "Pretendard-Bold", size: 14)
            categoryLabel.text = category
            containerView.addSubview(categoryLabel)
            categoryLabel.translatesAutoresizingMaskIntoConstraints = false

            // Progress Bar
            let backgroundBar = UIView()
            backgroundBar.backgroundColor = UIColor(red: 0.976, green: 0.969, blue: 0.957, alpha: 1)
            backgroundBar.layer.cornerRadius = 7
            containerView.addSubview(backgroundBar)
            backgroundBar.translatesAutoresizingMaskIntoConstraints = false

            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [
                UIColor(red: 1, green: 0.8, blue: 0.4, alpha: 1).cgColor,
                UIColor(red: 1, green: 0.592, blue: 0.102, alpha: 1).cgColor
            ]
            gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
            gradientLayer.cornerRadius = 7
            backgroundBar.layer.addSublayer(gradientLayer)

            let progressLayer = CAShapeLayer()
            progressLayer.lineWidth = 14
            progressLayer.lineCap = .round
            progressLayer.fillColor = nil
            progressLayer.strokeColor = UIColor.white.cgColor // 변경: 흰색으로 설정
            backgroundBar.layer.addSublayer(progressLayer)

            progressLayers.append(progressLayer)
            gradientLayers.append(gradientLayer)

            // Percentage Value Label
            let percentageValueLabel = UILabel()
            percentageValueLabel.textColor = UIColor(red: 1, green: 0.592, blue: 0.102, alpha: 1)
            percentageValueLabel.font = UIFont(name: "Pretendard-Bold", size: 14)
            percentageValueLabel.textAlignment = .right
            let randomPercentage = Int.random(in: 0...100)
            percentageValueLabel.text = "\(randomPercentage)%"
            containerView.addSubview(percentageValueLabel)
            percentageValueLabel.translatesAutoresizingMaskIntoConstraints = false

            // Layout constraints
            NSLayoutConstraint.activate([
                containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 27.5),
                containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -27.5),
                containerView.heightAnchor.constraint(equalToConstant: 33),

                categoryLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                categoryLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
                categoryLabel.widthAnchor.constraint(equalToConstant: 70),

                backgroundBar.leadingAnchor.constraint(equalTo: categoryLabel.trailingAnchor, constant: 10),
                backgroundBar.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
                backgroundBar.heightAnchor.constraint(equalToConstant: 14),

                percentageValueLabel.leadingAnchor.constraint(equalTo: backgroundBar.trailingAnchor, constant: 10),
                percentageValueLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
                percentageValueLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
                percentageValueLabel.widthAnchor.constraint(equalToConstant: 40)
            ])

            if let previousCategoryLabel = previousCategoryLabel {
                containerView.topAnchor.constraint(equalTo: previousCategoryLabel.bottomAnchor, constant: 20).isActive = true
            } else {
                containerView.topAnchor.constraint(equalTo: percentageLabel.bottomAnchor, constant: 48.18).isActive = true
            }

            previousCategoryLabel = categoryLabel
        }
    }
 
    private func updateProgressLayerPaths() {
        for (index, gradientLayer) in gradientLayers.enumerated() {
            guard let backgroundBar = gradientLayer.superlayer as? CALayer else { continue }
            
            let progressLayer = progressLayers[index]
            let progressPath = UIBezierPath()
            progressPath.move(to: CGPoint(x: 7, y: backgroundBar.bounds.height / 2))
            progressPath.addLine(to: CGPoint(x: backgroundBar.bounds.width - 7, y: backgroundBar.bounds.height / 2))
            progressLayer.path = progressPath.cgPath
            
            // 그라디언트 레이어와 프로그레스 레이어의 프레임을 정확히 설정
            gradientLayer.frame = backgroundBar.bounds
            progressLayer.frame = backgroundBar.bounds
            
            // 마스크 레이어 설정
                        let maskLayer = CAShapeLayer()
                        maskLayer.path = progressPath.cgPath
                        maskLayer.strokeColor = UIColor.white.cgColor
                        maskLayer.fillColor = UIColor.clear.cgColor
                        maskLayer.lineWidth = 14
                        maskLayer.lineCap = .round
                        
                        gradientLayer.mask = maskLayer
                        
                        // 애니메이션이 완료된 경우 마지막 상태 유지
                        if animationCompleted {
                            maskLayer.strokeEnd = finalProgressValues[index]
                        } else {
                            maskLayer.strokeEnd = 0
                        }
                    }
    }
}

// UIViewControllerTransitioningDelegate를 extension으로 구현
extension RecommendationDetailViewController3: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return CustomPresentationController(presentedViewController: presented, presenting: presenting)
    }
}
