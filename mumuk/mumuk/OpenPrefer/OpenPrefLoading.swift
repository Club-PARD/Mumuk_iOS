import UIKit

class OpenPrefLoading: UIViewController {
    
    private let containerView = UIView()
    private let dotsView = UIView()
    private let textLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startAnimation()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        // 컨테이너 뷰 설정
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        
        // 도트 뷰 설정
        dotsView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(dotsView)
        
        // 도트 생성
        for i in 0..<3 {
            let dot = UIView()
            dot.backgroundColor = UIColor(hex: "FF971A")
            dot.layer.cornerRadius = 5
            dot.translatesAutoresizingMaskIntoConstraints = false
            dotsView.addSubview(dot)
            
            NSLayoutConstraint.activate([
                dot.widthAnchor.constraint(equalToConstant: 10),
                dot.heightAnchor.constraint(equalToConstant: 10),
                dot.centerYAnchor.constraint(equalTo: dotsView.centerYAnchor),
                dot.leadingAnchor.constraint(equalTo: dotsView.leadingAnchor, constant: CGFloat(i) * 20)
            ])
        }
        
        // 텍스트 레이블 설정
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.numberOfLines = 2
        textLabel.textAlignment = .center
        textLabel.font = UIFont(name: "Pretendard-ExtraLight", size: 22)
        textLabel.text = "나의 고유 입맛\n키워드를 추출 중이에요"
        containerView.addSubview(textLabel)
        
        NSLayoutConstraint.activate([
            // 컨테이너 뷰 제약 조건
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            // 도트 뷰 제약 조건
            dotsView.topAnchor.constraint(equalTo: containerView.topAnchor),
            dotsView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            dotsView.widthAnchor.constraint(equalToConstant: 60),
            dotsView.heightAnchor.constraint(equalToConstant: 10),
            
            // 텍스트 레이블 제약 조건
            textLabel.topAnchor.constraint(equalTo: dotsView.bottomAnchor, constant: 30),
            textLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            textLabel.widthAnchor.constraint(equalToConstant: 300),
            
            // 컨테이너 뷰의 bottom을 텍스트 레이블의 bottom에 맞춤
            containerView.bottomAnchor.constraint(equalTo: textLabel.bottomAnchor)
        ])
    }
    
    private func startAnimation() {
        let animationDuration: TimeInterval = 0.6
        let delayBetweenDots: TimeInterval = 0.2
        
        for (index, dot) in dotsView.subviews.enumerated() {
            let delay = TimeInterval(index) * delayBetweenDots
            
            UIView.animate(withDuration: animationDuration, delay: delay, options: [.repeat, .autoreverse], animations: {
                dot.transform = CGAffineTransform(translationX: 0, y: -10)
            }, completion: nil)
        }
        
        // 3초 후 Openprofile 화면으로 전환
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let openProfileVC = Openprofile()
            openProfileVC.modalPresentationStyle = .fullScreen
            self.present(openProfileVC, animated: true, completion: nil)
        }
    }
}

extension UIColor {
    convenience init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
