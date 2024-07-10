import UIKit

class ReconFoodViewController2: UIViewController, UIScrollViewDelegate {
    var rank2: Rank?
    var rank3: Rank?
    var userName: String?
    private var scrollView: UIScrollView!
    private var pageControl: UIPageControl!
    private var cardView: UIView!
    
    // 각 메뉴 카드에 대한 뷰와 컴포넌트들
    private var menuViews: [UIView] = []
    private var reconFoodImageViews: [UIImageView] = []
    private var circularProgressViews: [UIView] = []
    private var foodNameLabels: [UILabel] = []
    private var percentageLabels: [UILabel] = []
    private var descriptionLabels: [UILabel] = []
    private var detailLinkButtons: [UIButton] = []
    private var circleLayers: [CAShapeLayer] = []
    private var progressLayers: [CAShapeLayer] = []
    private var gradientLayers: [CAGradientLayer] = []
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateProgress()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupMessageLabel()
        setupAdditionalMessageLabel()
        setupCardView()
        setupScrollView()
        setupPageControl()
        setupMenuPages()
        setupBackButton()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.contentSize = CGSize(width: cardView.bounds.width * 2, height: cardView.bounds.height)
        for (index, menuView) in menuViews.enumerated() {
            menuView.frame = CGRect(x: CGFloat(index) * cardView.bounds.width, y: 0, width: cardView.bounds.width, height: cardView.bounds.height)
            let circularProgressView = circularProgressViews[index]
            circularProgressView.frame = CGRect(x: 0, y: 52, width: 251.07, height: 251.07)
            createCircularPath(for: circularProgressView, index: index)
        }
    }
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 1, green: 0.592, blue: 0.102, alpha: 1)
        label.font = UIFont(name: "Pretendard-Bold", size: 15)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.96
        label.textAlignment = .center
        label.attributedText = NSMutableAttributedString(string: "뭘 좋아할지 몰라서 다 준비했어", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        return label
    }()
    
    private let additionalMessageLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = UIFont(name: "Pretendard-Bold", size: 19)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.06
        label.textAlignment = .center
        label.text = "1등 메뉴가 마음에 들지 않으시나요?\n두 개의 메뉴가 더 있어요!"
        return label
    }()
    
    private func setupMessageLabel() {
        view.addSubview(messageLabel)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            messageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            messageLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40)
        ])
    }
    
    private func setupAdditionalMessageLabel() {
        view.addSubview(additionalMessageLabel)
        additionalMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            additionalMessageLabel.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 4),
            additionalMessageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            additionalMessageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            additionalMessageLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 60)
        ])
    }
    
    private func setupCardView() {
        cardView = UIView()
        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 20
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.1
        cardView.layer.shadowOffset = CGSize(width: 0, height: 4)
        cardView.layer.shadowRadius = 10
        
        view.addSubview(cardView)
        cardView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cardView.widthAnchor.constraint(equalToConstant: 297),
            cardView.heightAnchor.constraint(equalToConstant: 454),
            cardView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cardView.topAnchor.constraint(equalTo: additionalMessageLabel.bottomAnchor, constant: 25)
        ])
    }
    
    private func setupScrollView() {
        scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        cardView.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: cardView.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor)
        ])
    }
    
    private func setupPageControl() {
        pageControl = UIPageControl()
        pageControl.numberOfPages = 2
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
        pageControl.currentPageIndicatorTintColor = UIColor(red: 1.0, green: 0.59, blue: 0.10, alpha: 1.0)
        view.addSubview(pageControl)
        
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageControl.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 20),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupMenuPages() {
        let ranks = [rank2, rank3]
        for i in 0..<2 {
            let menuView = UIView()
            menuView.backgroundColor = .clear
            scrollView.addSubview(menuView)
            menuViews.append(menuView)
            
            setupMenuPageContents(for: menuView, with: ranks[i], index: i)
        }
    }
    
    private func setupMenuPageContents(for menuView: UIView, with rank: Rank?, index: Int) {
        let circularProgressView = UIView()
        circularProgressView.backgroundColor = .clear
        menuView.addSubview(circularProgressView)
        circularProgressViews.append(circularProgressView)
        
        circularProgressView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            circularProgressView.widthAnchor.constraint(equalToConstant: 251.07),
            circularProgressView.heightAnchor.constraint(equalToConstant: 251.07),
            circularProgressView.centerXAnchor.constraint(equalTo: menuView.centerXAnchor),
            circularProgressView.topAnchor.constraint(equalTo: menuView.topAnchor, constant: 52)
        ])

        let circleLayer = CAShapeLayer()
        let progressLayer = CAShapeLayer()
        let gradientLayer = CAGradientLayer()
        
        circleLayers.append(circleLayer)
        progressLayers.append(progressLayer)
        gradientLayers.append(gradientLayer)
        
        circularProgressView.layer.addSublayer(circleLayer)
        circularProgressView.layer.addSublayer(gradientLayer)
        gradientLayer.mask = progressLayer

        createCircularPath(for: circularProgressView, index: index)

        // ReconFoodImageView 설정
        let reconFoodImageView = UIImageView()
        reconFoodImageView.contentMode = .scaleAspectFit
        circularProgressView.addSubview(reconFoodImageView)
        reconFoodImageViews.append(reconFoodImageView)
        
        reconFoodImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            reconFoodImageView.widthAnchor.constraint(equalToConstant: 91),
            reconFoodImageView.heightAnchor.constraint(equalToConstant: 59),
            reconFoodImageView.centerXAnchor.constraint(equalTo: circularProgressView.centerXAnchor),
            reconFoodImageView.centerYAnchor.constraint(equalTo: circularProgressView.centerYAnchor, constant: -30)
        ])
        
        if let imageUrl = rank?.image_url, let url = URL(string: imageUrl) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        reconFoodImageView.image = image
                    }
                }
            }
        }

        // FoodNameLabel 설정
        let foodNameLabel = UILabel()
        foodNameLabel.text = index == 0 ? "2등 \(rank?.foodname ?? "메뉴")" : "3등 \(rank?.foodname ?? "메뉴")"
        foodNameLabel.font = UIFont(name: "Pretendard-Light", size: 15)
        foodNameLabel.textColor = .black
        circularProgressView.addSubview(foodNameLabel)
        foodNameLabels.append(foodNameLabel)
        
        foodNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            foodNameLabel.centerXAnchor.constraint(equalTo: circularProgressView.centerXAnchor),
            foodNameLabel.topAnchor.constraint(equalTo: reconFoodImageView.bottomAnchor, constant: 10)
        ])
        
        // PercentageLabel 설정
        let percentageLabel = UILabel()
        percentageLabel.text = "\(Int(rank?.group_preference ?? 0))%"
        percentageLabel.font = UIFont(name: "Pretendard-Black", size: 28)
        percentageLabel.textColor = UIColor(red: 1, green: 0.546, blue: 0, alpha: 1)
        circularProgressView.addSubview(percentageLabel)
        percentageLabels.append(percentageLabel)
        
        percentageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            percentageLabel.centerXAnchor.constraint(equalTo: circularProgressView.centerXAnchor),
            percentageLabel.topAnchor.constraint(equalTo: foodNameLabel.bottomAnchor, constant: 5)
        ])

        // DescriptionLabel 설정
        let descriptionLabel = UILabel()
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center
        descriptionLabel.font = UIFont(name: "Pretendard-Bold", size: 16)
        descriptionLabel.textColor = UIColor(red: 0.725, green: 0.725, blue: 0.725, alpha: 1)
        descriptionLabel.text = "\(userName ?? "그룹")님의 그룹의 선호가\n\(Int(rank?.group_preference ?? 0))% 반영된 메뉴에요!"
        menuView.addSubview(descriptionLabel)
        descriptionLabels.append(descriptionLabel)
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.centerXAnchor.constraint(equalTo: menuView.centerXAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: circularProgressView.bottomAnchor, constant: 30),
            descriptionLabel.widthAnchor.constraint(equalToConstant: 250)
        ])
        
        // DetailLinkButton 설정
        let detailLinkButton = UIButton(type: .system)
        detailLinkButton.setTitle("추천 상세 보기 >", for: .normal)
        detailLinkButton.titleLabel?.font = UIFont(name: "Pretendard-Bold", size: 13)
        detailLinkButton.setTitleColor(UIColor(red: 1, green: 0.592, blue: 0.102, alpha: 1), for: .normal)
        detailLinkButton.tag = index // 버튼에 인덱스 태그 추가
        detailLinkButton.addTarget(self, action: #selector(detailLinkButtonTapped(_:)), for: .touchUpInside)
        menuView.addSubview(detailLinkButton)
        detailLinkButtons.append(detailLinkButton)
        
        detailLinkButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            detailLinkButton.centerXAnchor.constraint(equalTo: menuView.centerXAnchor),
            detailLinkButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 15)
        ])
    }
    
    @objc private func detailLinkButtonTapped(_ sender: UIButton) {
        presentRecommendationDetail(for: sender.tag)
    }
    
    private func presentRecommendationDetail(for index: Int) {
        let detailVC: UIViewController

        if index == 0 {
            let detailVC1 = RecommendationDetailViewController2()
            detailVC1.rank = rank2
            detailVC = detailVC1
        } else {
            let detailVC2 = RecommendationDetailViewController3()
            detailVC2.rank = rank3
            detailVC = detailVC2
        }

        if let sheet = detailVC.sheetPresentationController {
            sheet.detents = [.large()]
            sheet.prefersGrabberVisible = true
        }

        present(detailVC, animated: true, completion: nil)
    }

     
    private func createCircularPath(for view: UIView, index: Int) {
        let circleLayer = circleLayers[index]
        let progressLayer = progressLayers[index]
        let gradientLayer = gradientLayers[index]
        
        circleLayer.frame = view.bounds
        progressLayer.frame = view.bounds
        gradientLayer.frame = view.bounds
        
        let center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        let radius = (min(view.bounds.width, view.bounds.height) - 30) / 2
        let circularPath = UIBezierPath(arcCenter: center,
                                        radius: radius,
                                        startAngle: 0,
                                        endAngle: 2 * CGFloat.pi,
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
        
        gradientLayer.colors = [
            UIColor(red: 1, green: 0.8, blue: 0.4, alpha: 1).cgColor,
            UIColor(red: 1, green: 0.592, blue: 0.102, alpha: 1).cgColor
        ]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        
        // 그라데이션 회전 각도 조정
        gradientLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
        
        view.layer.addSublayer(circleLayer)
        view.layer.addSublayer(gradientLayer)
        gradientLayer.mask = progressLayer

        view.layer.zPosition = 1
        circleLayer.zPosition = 2
        gradientLayer.zPosition = 3
    }
    
    private func animateProgress() {
        for (index, progressLayer) in progressLayers.enumerated() {
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.duration = 1.5
            animation.fromValue = 0
            animation.toValue = index == 0 ? (rank2?.group_preference ?? 0) / 100.0 : (rank3?.group_preference ?? 0) / 100.0
            animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            progressLayer.strokeEnd = index == 0 ? (rank2?.group_preference ?? 0) / 100.0 : (rank3?.group_preference ?? 0) / 100.0
            progressLayer.add(animation, forKey: "animateProgress")
        }
    }
    
    // UIScrollViewDelegate 메서드
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
    }
    
    private func setupBackButton() {
        let backButton = UIButton(type: .system)
        backButton.backgroundColor = UIColor(red: 1, green: 0.592, blue: 0.102, alpha: 1)
        backButton.layer.cornerRadius = 24
        backButton.setTitle("뒤로가기", for: .normal)
        backButton.setTitleColor(.white, for: .normal)
        backButton.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 17)
        
        // 텍스트를 버튼 중앙에 위치시키기
        backButton.titleLabel?.textAlignment = .center
        backButton.contentVerticalAlignment = .center
        backButton.contentHorizontalAlignment = .center
        
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        view.addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backButton.widthAnchor.constraint(equalToConstant: 329),
            backButton.heightAnchor.constraint(equalToConstant: 48),
            backButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5)
        ])
    }

    @objc private func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}
