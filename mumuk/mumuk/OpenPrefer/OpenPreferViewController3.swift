//
//  OpenPreferViewController1.swift
//  mumuk
//
//  Created by 김민준 on 7/3/24.
//

import UIKit

class OpenPreferViewController3 : UIViewController {
    var uid : String?
    var name : String?
    var preferModel : OpenPreferModel?
    
    
    
    var checkToNext : Int = 0
    let lineImage : UIImageView = {
         let lineImage = UIImageView()
         lineImage.image = UIImage(named: "openline3")
         lineImage.translatesAutoresizingMaskIntoConstraints = false
         lineImage.contentMode = .scaleAspectFit
         lineImage.clipsToBounds = true
         return lineImage
     }()
    
    let nextButton : UIButton = {
        var config = UIButton.Configuration.filled()
        config.background.backgroundColor = #colorLiteral(red: 1, green: 0.5921568627, blue: 0.1019607843, alpha: 1)
        
        config.title = "다음"
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont(name: "Pretendard-SemiBold", size: 17)
            outgoing.foregroundColor = UIColor.white
            return outgoing
        }
    
        var button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 24
        button.layer.masksToBounds = true
        
        
        return button
        
    }()
    
    let titleLabel1 : UILabel = {
        let label = UILabel()
        label.text = "가장 선호하는 입맛"
        label.font = UIFont(name: "Pretendard-Bold", size: 26)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let titleLabel2 : UILabel = {
        let label = UILabel()
        label.text = "을"
        label.font = UIFont(name: "Pretendard-Light", size: 26)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let titleLabel3 : UILabel = {
        let label = UILabel()
        label.text = "골라주세요!"
        label.font = UIFont(name: "Pretendard-Light", size: 26)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
   
    
    let titleLabel5 : UILabel = {
        let label = UILabel()
        label.text = "고유 입맛은 MY페이지에서 다시 수정할 수 있어요!"
        label.font = UIFont(name: "Pretendard-SemiBold", size: 14)
        label.textColor = #colorLiteral(red: 0.3294117647, green: 0.3294117647, blue: 0.3294117647, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let koreaFoodButton : UIButton = {
        var config = UIButton.Configuration.filled()
        config.background.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        config.imagePadding = 4
        config.imagePlacement = .top
        
        
        // 이미지 추가
        
        if let image = UIImage(named: "koreafood"){
            let size = CGSize(width: 63, height: 58)
            UIGraphicsBeginImageContextWithOptions(size, false, 0.0) // 그래픽 컨텍스트 생성
            image.draw(in: CGRect(origin: .zero, size: size))
            let scaledImage = UIGraphicsGetImageFromCurrentImageContext() // 그래픽 컨텍스트에서 UIImage 객체 생성
            UIGraphicsEndImageContext() // 그래픽 컨텍스트 종료
            
            config.image = scaledImage
    
        }
        

        // 라벨 추가
        var text = AttributedString.init("한식")
        text.foregroundColor = #colorLiteral(red: 0.7254901961, green: 0.7254901961, blue: 0.7254901961, alpha: 1)
        text.font = UIFont(name: "Pretendard-Bold" , size: 15)
        config.attributedTitle = text
        
        config.background.strokeColor = #colorLiteral(red: 0.8745098039, green: 0.8745098039, blue: 0.8745098039, alpha: 1)
        config.background.strokeWidth = 2
        config.background.cornerRadius = 20

        
        // config 버튼에 합치기
       
        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    
    
    
    let americaFoodButton : UIButton = {
        var config = UIButton.Configuration.filled()
        config.background.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        config.imagePadding = 4
        config.imagePlacement = .top
        
        
        // 이미지 추가
        
        if let image = UIImage(named: "americafood"){
            let size = CGSize(width: 50.2, height: 56.1)
            UIGraphicsBeginImageContextWithOptions(size, false, 0.0) // 그래픽 컨텍스트 생성
            image.draw(in: CGRect(origin: .zero, size: size))
            let scaledImage = UIGraphicsGetImageFromCurrentImageContext() // 그래픽 컨텍스트에서 UIImage 객체 생성
            UIGraphicsEndImageContext() // 그래픽 컨텍스트 종료
            
            config.image = scaledImage
    
        }
        

        // 라벨 추가
        var text = AttributedString.init("양식")
        text.foregroundColor = #colorLiteral(red: 0.7254901961, green: 0.7254901961, blue: 0.7254901961, alpha: 1)
        text.font = UIFont(name: "Pretendard-Bold" , size: 15)
        config.attributedTitle = text
        
        config.background.strokeColor = #colorLiteral(red: 0.8745098039, green: 0.8745098039, blue: 0.8745098039, alpha: 1)
        config.background.strokeWidth = 2
        config.background.cornerRadius = 20

        
        // config 버튼에 합치기
        let button = UIButton(configuration: config)
//        button.addTarget(self, action: #selector(clicked2(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    
    
    
    let chinaFoodButton : UIButton = {
        var config = UIButton.Configuration.filled()
        config.background.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        config.imagePadding = 4
        config.imagePlacement = .top
        
        
        // 이미지 추가
        
        if let image = UIImage(named: "chinafood"){
            let size = CGSize(width: 54.9, height: 47.6)
            UIGraphicsBeginImageContextWithOptions(size, false, 0.0) // 그래픽 컨텍스트 생성
            image.draw(in: CGRect(origin: .zero, size: size))
            let scaledImage = UIGraphicsGetImageFromCurrentImageContext() // 그래픽 컨텍스트에서 UIImage 객체 생성
            UIGraphicsEndImageContext() // 그래픽 컨텍스트 종료
            
            config.image = scaledImage
    
        }
        

        // 라벨 추가
        var text = AttributedString.init("중식")
        text.foregroundColor = #colorLiteral(red: 0.7254901961, green: 0.7254901961, blue: 0.7254901961, alpha: 1)
        text.font = UIFont(name: "Pretendard-Bold" , size: 15)
        config.attributedTitle = text
        
        config.background.strokeColor = #colorLiteral(red: 0.8745098039, green: 0.8745098039, blue: 0.8745098039, alpha: 1)
        config.background.strokeWidth = 2
        config.background.cornerRadius = 20

        
        // config 버튼에 합치기
        let button = UIButton(configuration: config)
//        button.addTarget(self, action: #selector(clicked2(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    

    let japanFoodButton : UIButton = {
        var config = UIButton.Configuration.filled()
        config.background.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        config.imagePadding = 4
        config.imagePlacement = .top
        
        
        // 이미지 추가
        
        if let image = UIImage(named: "japanfood"){
            let size = CGSize(width: 53, height: 51)
            UIGraphicsBeginImageContextWithOptions(size, false, 0.0) // 그래픽 컨텍스트 생성
            image.draw(in: CGRect(origin: .zero, size: size))
            let scaledImage = UIGraphicsGetImageFromCurrentImageContext() // 그래픽 컨텍스트에서 UIImage 객체 생성
            UIGraphicsEndImageContext() // 그래픽 컨텍스트 종료
            
            config.image = scaledImage
    
        }
        

        // 라벨 추가
        var text = AttributedString.init("일식")
        text.foregroundColor = #colorLiteral(red: 0.7254901961, green: 0.7254901961, blue: 0.7254901961, alpha: 1)
        text.font = UIFont(name: "Pretendard-Bold" , size: 15)
        config.attributedTitle = text
        
        config.background.strokeColor = #colorLiteral(red: 0.8745098039, green: 0.8745098039, blue: 0.8745098039, alpha: 1)
        config.background.strokeWidth = 2
        config.background.cornerRadius = 20

        
        // config 버튼에 합치기
        let button = UIButton(configuration: config)
//        button.addTarget(self, action: #selector(clicked2(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    
    let tieFoodButton : UIButton = {
        var config = UIButton.Configuration.filled()
        config.background.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        config.imagePadding = 4
        config.imagePlacement = .top
       
        // 이미지 추가
    
        if let image = UIImage(named: "tiefood"){
            let size = CGSize(width: 59, height: 56)
            UIGraphicsBeginImageContextWithOptions(size, false, 0.0) // 그래픽 컨텍스트 생성
            image.draw(in: CGRect(origin: .zero, size: size))
            let scaledImage = UIGraphicsGetImageFromCurrentImageContext() // 그래픽 컨텍스트에서 UIImage 객체 생성
            UIGraphicsEndImageContext() // 그래픽 컨텍스트 종료
            
            config.image = scaledImage
    
        }
        
        var text = AttributedString.init("동남아")
        text.foregroundColor = #colorLiteral(red: 0.7254901961, green: 0.7254901961, blue: 0.7254901961, alpha: 1)
        text.font = UIFont(name: "Pretendard-Bold" , size: 15)
        config.attributedTitle = text
        
        var subtitleContainer = AttributeContainer()
        subtitleContainer.foregroundColor = #colorLiteral(red: 0.7254901961, green: 0.7254901961, blue: 0.7254901961, alpha: 1)
        subtitleContainer.font = UIFont(name: "Pretendard-Medium" , size: 11)
        config.attributedSubtitle = AttributedString("(태국, 베트남)", attributes: subtitleContainer)
        
        
        config.titleAlignment = .center
        config.titlePadding = 0
      
        config.background.strokeColor = #colorLiteral(red: 0.8745098039, green: 0.8745098039, blue: 0.8745098039, alpha: 1)
        config.background.strokeWidth = 2
        config.background.cornerRadius = 20

        
        // config 버튼에 합치기
        let button = UIButton(configuration: config)
//        button.addTarget(self, action: #selector(clicked2(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    
    let etcFoodButton : UIButton = {
        var config = UIButton.Configuration.filled()
        config.background.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        config.imagePadding = 4
        config.imagePlacement = .top
       
        // 이미지 추가
    
        if let image = UIImage(named: "etcfood"){
            let size = CGSize(width: 57, height: 57)
            UIGraphicsBeginImageContextWithOptions(size, false, 0.0) // 그래픽 컨텍스트 생성
            image.draw(in: CGRect(origin: .zero, size: size))
            let scaledImage = UIGraphicsGetImageFromCurrentImageContext() // 그래픽 컨텍스트에서 UIImage 객체 생성
            UIGraphicsEndImageContext() // 그래픽 컨텍스트 종료
            
            config.image = scaledImage
    
        }
        
        var text = AttributedString.init("기타")
        text.foregroundColor = #colorLiteral(red: 0.7254901961, green: 0.7254901961, blue: 0.7254901961, alpha: 1)
        text.font = UIFont(name: "Pretendard-Bold" , size: 15)
        config.attributedTitle = text
        
        var subtitleContainer = AttributeContainer()
        subtitleContainer.foregroundColor = #colorLiteral(red: 0.7254901961, green: 0.7254901961, blue: 0.7254901961, alpha: 1)
        subtitleContainer.font = UIFont(name: "Pretendard-Medium" , size: 11)
        config.attributedSubtitle = AttributedString("(멕시코, 인도 등)", attributes: subtitleContainer)
        
        
        config.titleAlignment = .center
        config.titlePadding = 0
      
        config.background.strokeColor = #colorLiteral(red: 0.8745098039, green: 0.8745098039, blue: 0.8745098039, alpha: 1)
        config.background.strokeWidth = 2
        config.background.cornerRadius = 20

        
        // config 버튼에 합치기
        let button = UIButton(configuration: config)
//        button.addTarget(self, action: #selector(clicked2(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        print(" open uid3 : \(uid)")
        print("open model3 : \(preferModel)")
        view.backgroundColor = .white
        nextButton.addTarget(self, action: #selector(moveToNext), for: .touchUpInside)
        setupBackButton()
        setUI()
        
        
        koreaFoodButton.setNeedsUpdateConfiguration()
        americaFoodButton.setNeedsUpdateConfiguration()
        chinaFoodButton.setNeedsUpdateConfiguration()
        japanFoodButton.setNeedsUpdateConfiguration()
        etcFoodButton.setNeedsUpdateConfiguration()
        tieFoodButton.setNeedsUpdateConfiguration()
        
        
        koreaFoodButton.addTarget(self, action: #selector(buttonClicked1(_:)), for: .touchUpInside)
        americaFoodButton.addTarget(self, action: #selector(buttonClicked2(_:)), for: .touchUpInside)
        chinaFoodButton.addTarget(self, action: #selector(buttonClicked3(_:)), for: .touchUpInside)
        japanFoodButton.addTarget(self, action: #selector(buttonClicked4(_:)), for: .touchUpInside)
        tieFoodButton.addTarget(self, action: #selector(buttonClicked5(_:)), for: .touchUpInside)
        etcFoodButton.addTarget(self, action: #selector(buttonClicked6(_:)), for: .touchUpInside)
    }
    
    
    func setUI(){
        view.addSubview(lineImage)
        
        view.addSubview(nextButton)
        
        view.addSubview(titleLabel1)
        view.addSubview(titleLabel2)
        view.addSubview(titleLabel3)
        
        view.addSubview(titleLabel5)
        
        view.addSubview(koreaFoodButton)
        view.addSubview(americaFoodButton)
        view.addSubview(chinaFoodButton)
        view.addSubview(japanFoodButton)
        view.addSubview(tieFoodButton)
        view.addSubview(etcFoodButton)
        
        
        
        NSLayoutConstraint.activate([
            lineImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 57.4),
                        lineImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 33),
                        lineImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                        
                        
                        // 변경
                           titleLabel1.topAnchor.constraint(equalTo: lineImage.bottomAnchor , constant: 38),
                        titleLabel1.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor , constant: 32),
            
            titleLabel2.topAnchor.constraint(equalTo: lineImage.bottomAnchor , constant: 38),
            titleLabel2.leadingAnchor.constraint(equalTo: titleLabel1.trailingAnchor , constant: 0),
            
            titleLabel3.topAnchor.constraint(equalTo: titleLabel1.bottomAnchor , constant: 3),
            titleLabel3.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor , constant: 32),
            
            
            
            titleLabel5.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -20),
                        titleLabel5.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -13.7),
            nextButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32.4),
            nextButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -31.6),
            nextButton.heightAnchor.constraint(equalToConstant: 48),
            
            
            koreaFoodButton.topAnchor.constraint(equalTo: titleLabel3.bottomAnchor , constant: 32),
            koreaFoodButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor , constant: 50.4),
            koreaFoodButton.widthAnchor.constraint(equalToConstant: 130),
            koreaFoodButton.heightAnchor.constraint(equalToConstant: 120),
            
            
            americaFoodButton.topAnchor.constraint(equalTo: titleLabel3.bottomAnchor , constant: 32),
            americaFoodButton.leadingAnchor.constraint(equalTo: koreaFoodButton.trailingAnchor, constant: 32.4),
            americaFoodButton.widthAnchor.constraint(equalToConstant: 130),
            americaFoodButton.heightAnchor.constraint(equalToConstant: 120),
            
            chinaFoodButton.topAnchor.constraint(equalTo: koreaFoodButton.bottomAnchor , constant: 24.8),
            chinaFoodButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 51.8),
            chinaFoodButton.widthAnchor.constraint(equalToConstant: 130),
            chinaFoodButton.heightAnchor.constraint(equalToConstant: 120),
            
            japanFoodButton.topAnchor.constraint(equalTo: koreaFoodButton.bottomAnchor , constant: 24.8),
            japanFoodButton.leadingAnchor.constraint(equalTo: chinaFoodButton.trailingAnchor, constant: 30),
            japanFoodButton.widthAnchor.constraint(equalToConstant: 130),
            japanFoodButton.heightAnchor.constraint(equalToConstant: 120),
            
            
            tieFoodButton.topAnchor.constraint(equalTo: chinaFoodButton.bottomAnchor , constant: 24),
            tieFoodButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 51.8),
            tieFoodButton.widthAnchor.constraint(equalToConstant: 130),
            tieFoodButton.heightAnchor.constraint(equalToConstant: 120),
            
            
            
            etcFoodButton.topAnchor.constraint(equalTo: chinaFoodButton.bottomAnchor , constant: 24),
            etcFoodButton.leadingAnchor.constraint(equalTo: tieFoodButton.trailingAnchor, constant: 30),
            etcFoodButton.widthAnchor.constraint(equalToConstant: 130),
            etcFoodButton.heightAnchor.constraint(equalToConstant: 120),
        ])
    }
    
    
    func setupBackButton() {
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "back"), for: .normal)
        backButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
        view.addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backButton.widthAnchor.constraint(equalToConstant: 30),
            backButton.heightAnchor.constraint(equalToConstant: 37),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 23),
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50)
        ])
    }
    
    
    
    @objc func dismissVC() {
        let transition = CATransition()
        transition.duration = 0.4
        transition.type = .push
        transition.subtype = .fromLeft
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        view.window?.layer.add(transition, forKey: kCATransition)
        dismiss(animated: false, completion: nil)
    }
    
    
    
    @objc func buttonClicked1(_ sender: UIButton) {
        sender.isSelected.toggle()
        americaFoodButton.isSelected = false
        chinaFoodButton.isSelected = false
        japanFoodButton.isSelected = false
        tieFoodButton.isSelected = false
        etcFoodButton.isSelected = false
        
        preferModel?.koreanFood = 1
        preferModel?.westernFood = 0
        preferModel?.chineseFood = 0
        preferModel?.japaneseFood = 0
        preferModel?.southeastAsianFood = 0
        preferModel?.elseFood = 0
        
        updateButtonConfiguration(button: sender, isSelected: sender.isSelected, text: "한식")
        updateButtonConfiguration(button: americaFoodButton, isSelected: false, text: "양식")
        updateButtonConfiguration(button: chinaFoodButton, isSelected: false , text: "중식")
        updateButtonConfiguration(button: japanFoodButton, isSelected: false, text: "일식")
        updateButtonConfiguration(button: tieFoodButton, isSelected: false, text: "동남아")
        updateButtonConfiguration(button: etcFoodButton, isSelected: false, text: "기타")

        
    }
    
    
    @objc func buttonClicked2(_ sender: UIButton) {
        sender.isSelected.toggle()
        koreaFoodButton.isSelected = false
        chinaFoodButton.isSelected = false
        japanFoodButton.isSelected = false
        tieFoodButton.isSelected = false
        etcFoodButton.isSelected = false
        
        preferModel?.koreanFood = 0
        preferModel?.westernFood = 1
        preferModel?.chineseFood = 0
        preferModel?.japaneseFood = 0
        preferModel?.southeastAsianFood = 0
        preferModel?.elseFood = 0
        
        
        updateButtonConfiguration(button: koreaFoodButton, isSelected: false, text: "한식")
        updateButtonConfiguration(button: sender, isSelected: sender.isSelected, text: "양식")
        updateButtonConfiguration(button: chinaFoodButton, isSelected: false , text: "중식")
        updateButtonConfiguration(button: japanFoodButton, isSelected: false, text: "일식")
        updateButtonConfiguration(button: tieFoodButton, isSelected: false, text: "동남아")
        updateButtonConfiguration(button: etcFoodButton, isSelected: false, text: "기타")

        
    }
    
    
    
    
    
    
    
    
    @objc func buttonClicked3(_ sender: UIButton) {
        sender.isSelected.toggle()
        koreaFoodButton.isSelected = false
        americaFoodButton.isSelected = false
        japanFoodButton.isSelected = false
        tieFoodButton.isSelected = false
        etcFoodButton.isSelected = false
        

        preferModel?.koreanFood = 0
        preferModel?.westernFood = 0
        preferModel?.chineseFood = 1
        preferModel?.japaneseFood = 0
        preferModel?.southeastAsianFood = 0
        preferModel?.elseFood = 0
        
        updateButtonConfiguration(button: koreaFoodButton, isSelected: false, text: "한식")
        updateButtonConfiguration(button: americaFoodButton, isSelected: false , text: "양식")
        updateButtonConfiguration(button: sender, isSelected: sender.isSelected, text: "중식")
      
        updateButtonConfiguration(button: japanFoodButton, isSelected: false, text: "일식")
        updateButtonConfiguration(button: tieFoodButton, isSelected: false, text: "동남아")
        updateButtonConfiguration(button: etcFoodButton, isSelected: false, text: "기타")

        
    }
    
    
    
    @objc func buttonClicked4(_ sender: UIButton) {
        
        koreaFoodButton.isSelected = false
        americaFoodButton.isSelected = false
        chinaFoodButton.isSelected = false
        sender.isSelected.toggle()
        tieFoodButton.isSelected = false
        etcFoodButton.isSelected = false
        
    
        preferModel?.koreanFood = 0
        preferModel?.westernFood = 0
        preferModel?.chineseFood = 0
        preferModel?.japaneseFood = 1
        preferModel?.southeastAsianFood = 0
        preferModel?.elseFood = 0
        
        updateButtonConfiguration(button: koreaFoodButton, isSelected: false, text: "한식")
        updateButtonConfiguration(button: americaFoodButton, isSelected: false, text: "양식")
        updateButtonConfiguration(button: chinaFoodButton, isSelected: false , text: "중식")
        
        updateButtonConfiguration(button: sender, isSelected: sender.isSelected, text: "일식")
        updateButtonConfiguration(button: tieFoodButton, isSelected: false, text: "동남아")
        updateButtonConfiguration(button: etcFoodButton, isSelected: false, text: "기타")

        
    }
    
    
    
    @objc func buttonClicked5(_ sender: UIButton) {
        
        koreaFoodButton.isSelected = false
        americaFoodButton.isSelected = false
        chinaFoodButton.isSelected = false
        japanFoodButton.isSelected = false
        sender.isSelected.toggle()
        etcFoodButton.isSelected = false
        
        preferModel?.koreanFood = 0
        preferModel?.westernFood = 0
        preferModel?.chineseFood = 0
        preferModel?.japaneseFood = 0
        preferModel?.southeastAsianFood = 1
        preferModel?.elseFood = 0
        updateButtonConfiguration(button: koreaFoodButton, isSelected: false, text: "한식")
        updateButtonConfiguration(button: americaFoodButton, isSelected: false, text: "양식")
        updateButtonConfiguration(button: chinaFoodButton, isSelected: false , text: "중식")
        updateButtonConfiguration(button: japanFoodButton, isSelected: false, text: "일식")
        updateButtonConfiguration(button: sender, isSelected: sender.isSelected, text: "동남아")
        updateButtonConfiguration(button: etcFoodButton, isSelected: false, text: "기타")

        
    }
    
    @objc func buttonClicked6(_ sender: UIButton) {
        
        koreaFoodButton.isSelected = false
        americaFoodButton.isSelected = false
        chinaFoodButton.isSelected = false
        japanFoodButton.isSelected = false
        tieFoodButton.isSelected = false
        sender.isSelected.toggle()
        
        
        preferModel?.koreanFood = 0
        preferModel?.westernFood = 0
        preferModel?.chineseFood = 0
        preferModel?.japaneseFood = 0
        preferModel?.southeastAsianFood = 0
        preferModel?.elseFood = 1
        
        updateButtonConfiguration(button: koreaFoodButton, isSelected: false, text: "한식")
        updateButtonConfiguration(button: americaFoodButton, isSelected: false, text: "양식")
        updateButtonConfiguration(button: chinaFoodButton, isSelected: false , text: "중식")
        updateButtonConfiguration(button: japanFoodButton, isSelected: false, text: "일식")
       
        updateButtonConfiguration(button: tieFoodButton, isSelected: false, text: "동남아")
        updateButtonConfiguration(button: sender, isSelected: sender.isSelected, text: "기타")
        
    }
    
    func updateButtonConfiguration(button: UIButton, isSelected: Bool, text: String) {
        var newConfig = button.configuration
        
        var attributedText = AttributedString(text)
        attributedText.font = UIFont(name: "Pretendard-Bold", size: 15)

        if isSelected {
            attributedText.foregroundColor = #colorLiteral(red: 0.9469566941, green: 0.6374832988, blue: 0.2344205678, alpha: 1)
            newConfig?.background.backgroundColor = #colorLiteral(red: 1, green: 0.9764705882, blue: 0.9450980392, alpha: 1) // 선택된 상태의 배경 색
            newConfig?.background.strokeColor = #colorLiteral(red: 0.9469566941, green: 0.6374832988, blue: 0.2344205678, alpha: 1) // 선택된 상태의 테두리 색
            
        } else {
            attributedText.foregroundColor = #colorLiteral(red: 0.7254901961, green: 0.7254901961, blue: 0.7254901961, alpha: 1)
            newConfig?.background.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) // 기본 배경 색
            newConfig?.background.strokeColor = #colorLiteral(red: 0.8745098039, green: 0.8745098039, blue: 0.8745098039, alpha: 1) // 기본 테두리 색
        }
        
        if text == "한식" {
            if let image = UIImage(named:"koerafood") {
                newConfig?.image = resizeImage(image: image, targetSize: CGSize(width: 63, height: 58))
            }
        }
        else if text == "양식" {
            if let image = UIImage(named:"americafood") {
                newConfig?.image = resizeImage(image: image, targetSize: CGSize(width: 50.2, height: 56.1))
            }
        }
        else if text == "중식" {
            if let image = UIImage(named:"chinafood") {
                newConfig?.image = resizeImage(image: image, targetSize: CGSize(width: 54.9, height: 47.6))
            }
        }
        else if text == "일식" {
                if let image = UIImage(named:"japanfood") {
                    newConfig?.image = resizeImage(image: image, targetSize: CGSize(width: 53, height: 51))
                }
        }
        else if text == "동남아" {
                if let image = UIImage(named:"tiefood") {
                    newConfig?.image = resizeImage(image: image, targetSize: CGSize(width: 59, height: 56))
                }
        }
        else if text == "기타" {
                if let image = UIImage(named:"etcfood") {
                    newConfig?.image = resizeImage(image: image, targetSize: CGSize(width: 57, height: 57))
                }
        }
            
            newConfig?.attributedTitle = attributedText
            button.configuration = newConfig
            checkToNext = 1
            button.setNeedsUpdateConfiguration()
        }
    
    
   
    
    @objc func moveToNext(){
        if koreaFoodButton.isSelected || americaFoodButton.isSelected || chinaFoodButton.isSelected || japanFoodButton.isSelected || tieFoodButton.isSelected || etcFoodButton.isSelected {
            let preferVC = OpenPreferViewController4()
            preferVC.uid = self.uid  // uid 전달
            preferVC.name = self.name  // name 전달
            preferVC.preferModel = self.preferModel
            
            let transition = CATransition()
            transition.duration = 0.4
            transition.type = .push
            transition.subtype = .fromRight
            transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            
            // 현재 window에 전환 애니메이션 적용
            view.window?.layer.add(transition, forKey: kCATransition)
            preferVC.modalPresentationStyle = .fullScreen  // 전체 화면으로 설정
            present(preferVC, animated: false, completion: nil)
        }
    }
    
    
  
        
        func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
            let size = image.size
            
            let widthRatio  = targetSize.width  / size.width
            let heightRatio = targetSize.height / size.height
            
            var newSize: CGSize
            if widthRatio > heightRatio {
                newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
            } else {
                newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
            }
            
            let rect = CGRect(origin: .zero, size: newSize)
            
            UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
            image.draw(in: rect)
            
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return newImage!
        }
        
        
        
        
    
        
        
}
