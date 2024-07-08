import UIKit

class LoadingViewController: UIViewController {
    private var imageView: UIImageView!
    private var label: UILabel!
    private var additionalLabel: UILabel!
    private var dotTimer: Timer?
    private var transitionTimer: Timer?
    private var dotCount = 1

    var rank1: Rank? // 데이터 전달을 위한 변수 추가
    var rank2: Rank? // 데이터 전달을 위한 변수 추가
    var rank3: Rank? // 데이터 전달을 위한 변수 추가
    var userName: String? // 데이터 전달을 위한 변수 추가

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupLoadingView()
        setupLoadingLabel()
        setupAdditionalLabel()
        startDotAnimation()

        // 4초 후에 다음 뷰 컨트롤러로 전환
        transitionTimer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(transitionToNextViewController), userInfo: nil, repeats: false)
    }
    
    private func setupLoadingView() {
        imageView = UIImageView(image: UIImage(named: "Loading"))
        imageView.frame = CGRect(x: 0, y: 0, width: 116.37, height: 124.51)
        imageView.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor

        view.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 116.37),
            imageView.heightAnchor.constraint(equalToConstant: 124.51),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 261.63)
        ])
    }

    private func setupLoadingLabel() {
        label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 215.84, height: 25)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = UIFont(name: "Pretendard-Bold", size: 25)
        
        let paragraphStyle = NSMutableParagraphStyle()

        label.textAlignment = .center
        
        label.attributedText = NSMutableAttributedString(
            string: "입맛 적중률 측정중.",
            attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle]
        )

        view.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.widthAnchor.constraint(equalToConstant: 215.84),
            label.heightAnchor.constraint(equalToConstant: 25),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 29.86)
        ])
    }

    private func setupAdditionalLabel() {
        additionalLabel = UILabel()
        additionalLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        additionalLabel.font = UIFont(name: "Pretendard-Light", size: 15)
        additionalLabel.numberOfLines = 0
        additionalLabel.lineBreakMode = .byWordWrapping
        additionalLabel.textAlignment = .center

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.12
        paragraphStyle.alignment = .center

        let attributedString = NSMutableAttributedString(
            string: "열심히 입맛을 종합하고 있어요\n과연 어떤 메뉴가 나올까요?",
            attributes: [
                NSAttributedString.Key.paragraphStyle: paragraphStyle
            ]
        )

        additionalLabel.attributedText = attributedString

        view.addSubview(additionalLabel)
        
        additionalLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            additionalLabel.widthAnchor.constraint(equalToConstant: 203.59),
            additionalLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            additionalLabel.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 14.72)
        ])
    }

    private func startDotAnimation() {
        dotTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(updateDots), userInfo: nil, repeats: true)
    }

    @objc private func updateDots() {
        dotCount = (dotCount % 3) + 1
        let dots = String(repeating: ".", count: dotCount)
        let paragraphStyle = NSMutableParagraphStyle()
        label.attributedText = NSMutableAttributedString(
            string: "입맛 적중률 측정중\(dots)",
            attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle]
        )
    }

    @objc private func transitionToNextViewController() {
        // 타이머 중지
        dotTimer?.invalidate()
        transitionTimer?.invalidate()

        // 다음 뷰 컨트롤러로 데이터 전달 및 전환
        let reconFoodVC = ReconFoodViewController1()
        reconFoodVC.rank1 = self.rank1
        reconFoodVC.rank2 = self.rank2
        reconFoodVC.rank3 = self.rank3
        reconFoodVC.userName = self.userName
        
        reconFoodVC.modalPresentationStyle = .fullScreen
        self.present(reconFoodVC, animated: false, completion: {
            // 로딩 뷰가 완전히 사라진 후에 프로그레스 애니메이션 시작
            reconFoodVC.animateProgress()
        })
    }


    deinit {
        dotTimer?.invalidate()
        transitionTimer?.invalidate()
    }
}
