
import UIKit

class RecommendationDetailViewController2: UIViewController {
    
    var rank: Rank!
    private var animationHasRun = false
    
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
        updateUIWithRankData()
        
        
        modalPresentationStyle = .custom
        // 트랜지션 델리게이트 설정
        transitioningDelegate = self
    }
    
    private func updateUIWithRankData() {
        guard let rank = rank else { return }
        
        // 음식 이름 업데이트
        if let rankLabel = view.subviews.first(where: { ($0 as? UILabel)?.text?.hasPrefix("1등") == true }) as? UILabel {
            rankLabel.text = "2등 \(rank.foodname)"
        }
        
        // 퍼센트 업데이트
        percentageLabel.text = String(format: "%.1f%%", rank.group_preference)
        
        // 이미지 업데이트
        if let url = URL(string: rank.image_url) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        if let imageView = self.view.subviews.first(where: { $0 is UIImageView }) as? UIImageView {
                            imageView.image = image
                        }
                    }
                }
            }
            updateCategoriesAndProgressBars()
        }
        
        // 카테고리 및 프로그레스바 업데이트
        updateCategoriesAndProgressBars()
    }
    
    private func updateCategoriesAndProgressBars() {
        if animationHasRun {
            return  // 애니메이션이 이미 실행되었다면 함수를 종료
        }
        
        let categories = getCategoriesFromRank()
        
        finalProgressValues = categories.map { CGFloat($0.1 / 100.0) }
        
        for (index, (category, value)) in categories.enumerated() {
            if index < gradientLayers.count {
                if let containerView = gradientLayers[index].superlayer?.superlayer as? UIView,
                   let categoryLabel = containerView.subviews.first(where: { $0 is UILabel }) as? UILabel,
                   let percentageValueLabel = containerView.subviews.last(where: { $0 is UILabel }) as? UILabel {
                    
                    categoryLabel.text = category
                    percentageValueLabel.text = String(format: "%.1f%%", value)
                    
                    print("Setting finalProgressValues[\(index)] to \(finalProgressValues[index])")
                }
            }
        }
        
        setupAndStartAnimation()
    }
    
    private func getCategoriesFromRank() -> [(String, Double)] {
        var categories: [(String, Double)] = []
        
        // 1. 밥 vs 빵 vs 면
        if let rice = rank.rice_preference { categories.append(("밥", rice)) }
        else if let bread = rank.bread_preference { categories.append(("빵", bread)) }
        else if let noodle = rank.noodle_preference { categories.append(("면", noodle)) }
        else { categories.append(("밥/빵/면", 0)) } // 기본값
        
        // 2. 육류 vs 채소 vs 탄수화물
        if let meat = rank.meat_preference { categories.append(("육류", meat)) }
        else if let vegetable = rank.vegetable_preference { categories.append(("채소", vegetable)) }
        else if let carbohydrate = rank.carbohydrate_preference { categories.append(("탄수화물", carbohydrate)) }
        else { categories.append(("육류/채소/탄수화물", 0)) } // 기본값
        
        // 3. 헤비 vs NO헤비
        if let heavy = rank.heavy_preference { categories.append(("헤비", heavy)) }
        else if let light = rank.light_preference { categories.append(("NO헤비", light)) }
        else { categories.append(("헤비/NO헤비", 0)) } // 기본값
        
        // 4. 한식 vs 양식 vs 중식 vs 일식 vs 동남아
        if let korean = rank.koreanFood_group_preference { categories.append(("한식", korean)) }
        else if let western = rank.westernFood_group_preference { categories.append(("양식", western)) }
        else if let chinese = rank.chineseFood_group_preference { categories.append(("중식", chinese)) }
        else if let japanese = rank.japaneseFood_group_preference { categories.append(("일식", japanese)) }
        else if let southeast = rank.southeastAsianFood_group_preference { categories.append(("동남아", southeast)) }
        else { categories.append(("음식 종류", 0)) } // 기본값
        
        // 5. 빨간 맛 vs 안 빨간 맛
        if let red = rank.redFood_preference {
            categories.append(("빨간 맛", red))
        } else if let nonRed = rank.nonRedFood_preference {
            categories.append(("안 빨간 맛", nonRed))
        } else {
            categories.append(("빨간 맛/안 빨간 맛", 0)) // 기본값
        }
        
        // 6. 국물 vs NO국물 (새로 추가)
        if let soup = rank.soup_preference {
            categories.append(("국물", soup))
        } else if let noSoup = rank.noSoup_preference {
            categories.append(("NO국물", noSoup))
        } else {
            categories.append(("국물/NO국물", 0)) // 기본값
        }
        
        return categories
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // 뷰가 완전히 나타난 후 약간의 지연 시간을 두고 애니메이션 설정 및 시작
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            self?.updateCategoriesAndProgressBars()
            print("updateCategoriesAndProgressBars called")
        }
    }
    
    private func setupAndStartAnimation() {
        if animationHasRun {
            return  // 애니메이션이 이미 실행되었다면 함수를 종료
        }
        
        view.layoutIfNeeded()
        updateProgressLayerPaths()
        
        CATransaction.begin()
        CATransaction.setCompletionBlock { [weak self] in
            self?.animationCompleted = true
            self?.animationHasRun = true
            print("Animation setup completed. finalProgressValues: \(self?.finalProgressValues ?? [])")
        }
        
        for index in 0..<min(self.progressLayers.count, self.finalProgressValues.count) {
            self.animateProgress(for: index)
        }
        
        CATransaction.commit()
    }
    
    func startProgressAnimation() {
        for index in 0..<min(self.progressLayers.count, self.finalProgressValues.count) {
            self.animateProgress(for: index)
        }
        animationCompleted = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // 레이아웃 변경 시 프로그레스 레이어의 경로 업데이트
        updateProgressLayerPaths()
        
        // 애니메이션이 완료되었으면 프로그레스 레이어의 상태를 현재 상태로 설정
        if animationCompleted {
            setProgressLayersToFinalValues()
        } else {
            setupInitialProgressLayerStates()
        }
    }
    
    private func setProgressLayersToFinalValues() {
        for (index, progressLayer) in progressLayers.enumerated() {
            progressLayer.strokeEnd = finalProgressValues[index]
        }
    }

    
    private func setupInitialProgressLayerStates() {
        for progressLayer in progressLayers {
            progressLayer.strokeEnd = 0
        }
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
            rankLabel.widthAnchor.constraint(equalToConstant: 80),
            rankLabel.heightAnchor.constraint(equalToConstant: 18),
            rankLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
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
        let categories = getCategoriesFromRank()
        var previousContainerView: UIView?
        
        // finalProgressValues 초기화
        finalProgressValues = Array(repeating: 0, count: categories.count)
        
        for (index, (category, value)) in categories.enumerated() {
            let containerView = UIView()
            view.addSubview(containerView)
            containerView.translatesAutoresizingMaskIntoConstraints = false
            
            // finalProgressValues 설정
            finalProgressValues[index] = CGFloat(value / 100.0)
            
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
            progressLayer.strokeColor = UIColor.black.cgColor
            gradientLayer.mask = progressLayer

            progressLayers.append(progressLayer)
            gradientLayers.append(gradientLayer)

            // 디버깅을 위한 로그
            print("Progress value for index \(index): \(value)")
            
            // Percentage Value Label
            let percentageValueLabel = UILabel()
            percentageValueLabel.textColor = UIColor(red: 1, green: 0.592, blue: 0.102, alpha: 1)
            percentageValueLabel.font = UIFont(name: "Pretendard-Bold", size: 14)
            percentageValueLabel.textAlignment = .right
            let percentage = Int(value)
            percentageValueLabel.text = "\(percentage)%"
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
                backgroundBar.trailingAnchor.constraint(equalTo: percentageValueLabel.leadingAnchor, constant: -10),
                backgroundBar.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
                backgroundBar.heightAnchor.constraint(equalToConstant: 14),
                
                percentageValueLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
                percentageValueLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
                percentageValueLabel.widthAnchor.constraint(equalToConstant: 40)
            ])
            
            if let previousView = previousContainerView {
                containerView.topAnchor.constraint(equalTo: previousView.bottomAnchor, constant: 20).isActive = true
            } else {
                containerView.topAnchor.constraint(equalTo: percentageLabel.bottomAnchor, constant: 48.18).isActive = true
            }
            
            previousContainerView = containerView
        }
        
        // 마지막 containerView 아래에 여백 추가
        if let lastContainerView = previousContainerView {
            NSLayoutConstraint.activate([
                view.safeAreaLayoutGuide.bottomAnchor.constraint(greaterThanOrEqualTo: lastContainerView.bottomAnchor, constant: 20)
            ])
        }
    }
    
    private func updateProgressLayerPaths() {
        for (index, gradientLayer) in gradientLayers.enumerated() {
            guard let backgroundBar = gradientLayer.superlayer else { continue }
            
            let progressLayer = progressLayers[index]
            let progressPath = UIBezierPath()
            progressPath.move(to: CGPoint(x: 7, y: backgroundBar.bounds.height / 2))
            progressPath.addLine(to: CGPoint(x: backgroundBar.bounds.width - 7, y: backgroundBar.bounds.height / 2))
            progressLayer.path = progressPath.cgPath
            
            gradientLayer.frame = backgroundBar.bounds
            progressLayer.frame = backgroundBar.bounds
            
            if animationCompleted {
                progressLayer.strokeEnd = finalProgressValues[index]
            } else {
                progressLayer.strokeEnd = 0
            }
        }
    }


    private func animateProgress(for index: Int) {
        guard index < finalProgressValues.count, index < progressLayers.count else {
            print("Index out of range: \(index)")
            return
        }
        
        let progressLayer = progressLayers[index]
        let finalValue = finalProgressValues[index]
        
        progressLayer.removeAnimation(forKey: "animateProgress")
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = 1.5
        animation.fromValue = 0
        animation.toValue = finalValue
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        
        progressLayer.add(animation, forKey: "animateProgress")
        progressLayer.strokeEnd = finalValue
        
        print("Animating progress for index \(index). From: 0, To: \(finalValue)")
    }
}

// UIViewControllerTransitioningDelegate를 extension으로 구현
extension RecommendationDetailViewController2: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return CustomPresentationController(presentedViewController: presented, presenting: presenting)
    }
}
