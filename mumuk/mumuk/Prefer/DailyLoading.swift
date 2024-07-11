//
//  DailyLoading.swift
//  mumuk
//
//  Created by 김현중 on 7/12/24.
//

import UIKit

class DailyLoading: UIViewController {
    
    private let containerView = UIView()
    private let dotsView = UIView()
    private let textLabel = UILabel()
    
    var uid: String?
    var name: String?
    
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
        textLabel.numberOfLines = 0
        textLabel.textAlignment = .center
        textLabel.font = UIFont(name: "Pretendard-ExtraLight", size: 22)
        textLabel.text = "선호도를 반영한\nDAILY FOOROFILE이\n완성되고 있어요"
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
            textLabel.widthAnchor.constraint(equalToConstant: 266),
            
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
        
        // 3초 후 DailyFoorofileViewController로 전환
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let dailyFoorofileVC = DailyFoorofileViewController()
            dailyFoorofileVC.uid = self.uid!
            dailyFoorofileVC.name = self.name!
            dailyFoorofileVC.modalPresentationStyle = .fullScreen
            self.present(dailyFoorofileVC, animated: true, completion: nil)
        }
    }
}
