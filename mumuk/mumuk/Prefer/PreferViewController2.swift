//
//  PreferViewController1.swift
//  mumuk
//
//  Created by 김민준 on 7/2/24.
//
import UIKit


class PreferViewController2 : UIViewController{
    var dailyScrumModel : PreferModel?
    var checkToNext : Int = 0
    var uid : String?
    var name : String?
//    var clickedCheck : [Int] = [0,0,0,0,0,0]
    
    
    let lineImage : UIImageView = {
        let lineImage = UIImageView()
        lineImage.image = UIImage(named: "line2")  //
        lineImage.translatesAutoresizingMaskIntoConstraints = false
        lineImage.contentMode = .scaleAspectFit
        return lineImage
    }()
    
    
    let titleLabel1 : UILabel = {
        let label = UILabel()
        label.text = "오늘 먹고 싶은 입맛"
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
        label.text = "모두 골라주세요!"
        label.font = UIFont(name: "Pretendard-Light", size: 26)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let titleLabel4 : UILabel = {
        let label = UILabel()
        label.text = "오늘의 입맛은 입맛찾기 페이지에서 언제든 수정이 가능해요!"
        label.font = UIFont(name: "Pretendard-SemiBold", size: 14)
        label.textColor = #colorLiteral(red: 0.7254901961, green: 0.7254901961, blue: 0.7254901961, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    let nextButton : UIButton = {
        var config = UIButton.Configuration.filled()
        config.background.backgroundColor = #colorLiteral(red: 0.9294117647, green: 0.9294117647, blue: 0.9294117647, alpha: 1)
        
        
        config.title = "다음"
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont(name: "Pretendard-SemiBold", size: 17)
            outgoing.foregroundColor = #colorLiteral(red: 0.5803921569, green: 0.5803921569, blue: 0.5803921569, alpha: 1)
            return outgoing
        }
    
        var button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 24
        button.layer.masksToBounds = true
        button.isEnabled = false
        
        return button
        
    }()
    
    
    
    
    let skipButton: UIButton = {
        let button = UIButton()
        button.setTitle("SKIP", for: .normal)
        button.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 17) // 글꼴 설정
        
        button.setTitleColor(#colorLiteral(red: 0.8705882353, green: 0.8705882353, blue: 0.8705882353, alpha: 1), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.sizeToFit()
        return button
    }()

    
    let line : UIView = {
        let line = UIView()
        line.backgroundColor = #colorLiteral(red: 0.8990607262, green: 0.8990607262, blue: 0.8990607262, alpha: 1)
        line.translatesAutoresizingMaskIntoConstraints = false
       return line
    }()
    
    
//
    
    
    
    
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
            let size = CGSize(width: 63, height: 58)
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
            let size = CGSize(width: 63, height: 58)
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
            let size = CGSize(width: 63, height: 58)
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
            let size = CGSize(width: 59, height: 56)
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
  
    
    
    
    
    //MARK: - view
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        nextButton.addTarget(self, action: #selector(moveToNext), for: .touchUpInside)
        skipButton.addTarget(self, action: #selector(skipToNext), for: .touchUpInside)
        setUI()
        setupBackButton()
       
        print("model2 : \(dailyScrumModel)")
        print("uid2 : \(uid)" )
        
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

    @objc func buttonClicked1(_ sender: UIButton){
        sender.isSelected.toggle() // 버튼의 선택 상태를 토글
        
                // 상태에 따른 테두리 색 변경
                if sender.isSelected {
                    var newConfig = sender.configuration

            
                    var text = AttributedString("한식")
                    text.foregroundColor = #colorLiteral(red: 0.9469566941, green: 0.6374832988, blue: 0.2344205678, alpha: 1)
                    text.font = UIFont(name: "Pretendard-Bold", size: 15)
                    newConfig?.attributedTitle = text
                    newConfig?.background.backgroundColor = #colorLiteral(red: 1, green: 0.9764705882, blue: 0.9450980392, alpha: 1) // 선택된 상태의 배경 색
                    newConfig?.background.strokeColor = #colorLiteral(red: 0.9469566941, green: 0.6374832988, blue: 0.2344205678, alpha: 1) // 선택된 상태의 테두리 색
                    sender.configuration = newConfig
                    
                    // struct 멤버에 접근해서 값바꾸기
                    if var model = dailyScrumModel{
                        model.todayKoreanFood = 1
                        dailyScrumModel = model
                    }
                    
                    checkToNext = 1
                } else {
                    var newConfig = sender.configuration

            
                    var text = AttributedString("한식")
                    text.foregroundColor = #colorLiteral(red: 0.7254901961, green: 0.7254901961, blue: 0.7254901961, alpha: 1)
                    text.font = UIFont(name: "Pretendard-Bold", size: 15)
                    newConfig?.attributedTitle = text
                    newConfig?.background.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) // 선택된 상태의 배경 색
                    newConfig?.background.strokeColor = #colorLiteral(red: 0.8745098039, green: 0.8745098039, blue: 0.8745098039, alpha: 1) // 선택된 상태의 테두리 색
                    sender.configuration = newConfig
                    
                    if var model = dailyScrumModel{
                        model.todayKoreanFood = 0
                        dailyScrumModel = model
                    }
                    
                    checkToNext = 0
                }

                // 버튼 상태 업데이트 요청
                sender.setNeedsUpdateConfiguration()
                updateNextButtonState()
    }
    
    
    @objc func buttonClicked2(_ sender: UIButton){
        sender.isSelected.toggle() // 버튼의 선택 상태를 토글
            
                // 상태에 따른 테두리 색 변경
                if sender.isSelected {
                    var newConfig = sender.configuration

            
                    var text = AttributedString("양식")
                    text.foregroundColor = #colorLiteral(red: 0.9469566941, green: 0.6374832988, blue: 0.2344205678, alpha: 1)
                    text.font = UIFont(name: "Pretendard-Bold", size: 15)
                    newConfig?.attributedTitle = text
                    newConfig?.background.backgroundColor = #colorLiteral(red: 1, green: 0.9764705882, blue: 0.9450980392, alpha: 1) // 선택된 상태의 배경 색
                    newConfig?.background.strokeColor = #colorLiteral(red: 0.9469566941, green: 0.6374832988, blue: 0.2344205678, alpha: 1) // 선택된 상태의 테두리 색
                    sender.configuration = newConfig
                    
                    if var model = dailyScrumModel{
                        model.todayWesternFood = 1
                        dailyScrumModel = model
                    }
                    checkToNext = 1
                } else {
                    var newConfig = sender.configuration

            
                    var text = AttributedString("양식")
                    text.foregroundColor = #colorLiteral(red: 0.7254901961, green: 0.7254901961, blue: 0.7254901961, alpha: 1)
                    text.font = UIFont(name: "Pretendard-Bold", size: 15)
                    newConfig?.attributedTitle = text
                    newConfig?.background.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) // 선택된 상태의 배경 색
                    newConfig?.background.strokeColor = #colorLiteral(red: 0.8745098039, green: 0.8745098039, blue: 0.8745098039, alpha: 1) // 선택된 상태의 테두리 색
                    sender.configuration = newConfig
                    
                    if var model = dailyScrumModel{
                        model.todayWesternFood = 0
                        dailyScrumModel = model
                    }
                    checkToNext = 0
                }

                // 버튼 상태 업데이트 요청
                sender.setNeedsUpdateConfiguration()
                updateNextButtonState()
    }
    
    
    @objc func buttonClicked3(_ sender: UIButton){
        sender.isSelected.toggle() // 버튼의 선택 상태를 토글

                // 상태에 따른 테두리 색 변경
                if sender.isSelected {
                    var newConfig = sender.configuration

            
                    var text = AttributedString("중식")
                    text.foregroundColor = #colorLiteral(red: 0.9469566941, green: 0.6374832988, blue: 0.2344205678, alpha: 1)
                    text.font = UIFont(name: "Pretendard-Bold", size: 15)
                    newConfig?.attributedTitle = text
                    newConfig?.background.backgroundColor = #colorLiteral(red: 1, green: 0.9764705882, blue: 0.9450980392, alpha: 1) // 선택된 상태의 배경 색
                    newConfig?.background.strokeColor = #colorLiteral(red: 0.9469566941, green: 0.6374832988, blue: 0.2344205678, alpha: 1) // 선택된 상태의 테두리 색
                    sender.configuration = newConfig
                    
                    
                    if var model = dailyScrumModel{
                        model.todayChineseFood = 1
                        dailyScrumModel = model
                    }
                    checkToNext = 1
                } else {
                    var newConfig = sender.configuration

            
                    var text = AttributedString("중식")
                    text.foregroundColor = #colorLiteral(red: 0.7254901961, green: 0.7254901961, blue: 0.7254901961, alpha: 1)
                    text.font = UIFont(name: "Pretendard-Bold", size: 15)
                    newConfig?.attributedTitle = text
                    newConfig?.background.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) // 선택된 상태의 배경 색
                    newConfig?.background.strokeColor = #colorLiteral(red: 0.8745098039, green: 0.8745098039, blue: 0.8745098039, alpha: 1) // 선택된 상태의 테두리 색
                    sender.configuration = newConfig
                    
                    
                    if var model = dailyScrumModel{
                        model.todayChineseFood = 0
                        dailyScrumModel = model
                    }
                    
                    checkToNext = 0
                }

                // 버튼 상태 업데이트 요청
                sender.setNeedsUpdateConfiguration()
                updateNextButtonState()
    }
    
    
    @objc func buttonClicked4(_ sender: UIButton){
        sender.isSelected.toggle() // 버튼의 선택 상태를 토글

                // 상태에 따른 테두리 색 변경
                if sender.isSelected {
                    var newConfig = sender.configuration

            
                    var text = AttributedString("일식")
                    text.foregroundColor = #colorLiteral(red: 0.9469566941, green: 0.6374832988, blue: 0.2344205678, alpha: 1)
                    text.font = UIFont(name: "Pretendard-Bold", size: 15)
                    newConfig?.attributedTitle = text
                    newConfig?.background.backgroundColor = #colorLiteral(red: 1, green: 0.9764705882, blue: 0.9450980392, alpha: 1) // 선택된 상태의 배경 색
                    newConfig?.background.strokeColor = #colorLiteral(red: 0.9469566941, green: 0.6374832988, blue: 0.2344205678, alpha: 1) // 선택된 상태의 테두리 색
                    sender.configuration = newConfig
                    
                    
                    if var model = dailyScrumModel{
                        model.todayJapaneseFood = 1
                        dailyScrumModel = model
                    }
                    
                    checkToNext = 1
                } else {
                    var newConfig = sender.configuration

            
                    var text = AttributedString("일식")
                    text.foregroundColor = #colorLiteral(red: 0.7254901961, green: 0.7254901961, blue: 0.7254901961, alpha: 1)
                    text.font = UIFont(name: "Pretendard-Bold", size: 15)
                    newConfig?.attributedTitle = text
                    newConfig?.background.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) // 선택된 상태의 배경 색
                    newConfig?.background.strokeColor = #colorLiteral(red: 0.8745098039, green: 0.8745098039, blue: 0.8745098039, alpha: 1) // 선택된 상태의 테두리 색
                    sender.configuration = newConfig
                    
                    
                    if var model = dailyScrumModel{
                        model.todayJapaneseFood = 0
                        dailyScrumModel = model
                    }
                    
                    
                    checkToNext = 0
                }

                // 버튼 상태 업데이트 요청
                sender.setNeedsUpdateConfiguration()
                updateNextButtonState()
    }
    
    @objc func buttonClicked5(_ sender: UIButton){
        sender.isSelected.toggle() // 버튼의 선택 상태를 토글

                // 상태에 따른 테두리 색 변경
                if sender.isSelected {
                    var newConfig = sender.configuration
                    var text = AttributedString("동남아")
                    text.foregroundColor = #colorLiteral(red: 0.9469566941, green: 0.6374832988, blue: 0.2344205678, alpha: 1)
                    text.font = UIFont(name: "Pretendard-Bold", size: 15)
                    newConfig?.attributedTitle = text
                    newConfig?.background.backgroundColor = #colorLiteral(red: 1, green: 0.9764705882, blue: 0.9450980392, alpha: 1) // 선택된 상태의 배경 색
                    newConfig?.background.strokeColor = #colorLiteral(red: 0.9469566941, green: 0.6374832988, blue: 0.2344205678, alpha: 1) // 선택된 상태의 테두리 색

                    var subtitleText = AttributedString("(태국, 베트남)")
                    subtitleText.foregroundColor = #colorLiteral(red: 0.9469566941, green: 0.6374832988, blue: 0.2344205678, alpha: 1)
                    subtitleText.font = UIFont(name: "Pretendard-Medium", size: 11)
                    newConfig?.attributedSubtitle = subtitleText
                    sender.configuration = newConfig
                    
                    if var model = dailyScrumModel{
                        model.todaySoutheastAsianFood = 1
                        dailyScrumModel = model
                    }
                    
                    
                    checkToNext = 1
                } else {
                    var newConfig = sender.configuration
                    var text = AttributedString("동남아")
                    text.foregroundColor = #colorLiteral(red: 0.7254901961, green: 0.7254901961, blue: 0.7254901961, alpha: 1)
                    text.font = UIFont(name: "Pretendard-Bold", size: 15)
                    newConfig?.attributedTitle = text
                    newConfig?.background.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) // 선택된 상태의 배경 색
                    newConfig?.background.strokeColor = #colorLiteral(red: 0.8745098039, green: 0.8745098039, blue: 0.8745098039, alpha: 1) // 선택된 상태의 테두리 색

                    var subtitleText = AttributedString("(태국, 베트남)")
                    subtitleText.foregroundColor = #colorLiteral(red: 0.7254901961, green: 0.7254901961, blue: 0.7254901961, alpha: 1)
                    subtitleText.font = UIFont(name: "Pretendard-Medium", size: 11)
                    newConfig?.attributedSubtitle = subtitleText
                    sender.configuration = newConfig
                    
                    
                    if var model = dailyScrumModel{
                        model.todaySoutheastAsianFood = 0
                        dailyScrumModel = model
                    }
                    
                    checkToNext = 0
                }

                // 버튼 상태 업데이트 요청
                sender.setNeedsUpdateConfiguration()
                updateNextButtonState()
    }
    
    
    @objc func buttonClicked6(_ sender: UIButton){
        sender.isSelected.toggle() // 버튼의 선택 상태를 토글

                // 상태에 따른 테두리 색 변경
                if sender.isSelected {
                    var newConfig = sender.configuration
                    var text = AttributedString("기타")
                    text.foregroundColor = #colorLiteral(red: 0.9469566941, green: 0.6374832988, blue: 0.2344205678, alpha: 1)
                    text.font = UIFont(name: "Pretendard-Bold", size: 15)
                    newConfig?.attributedTitle = text
                    newConfig?.background.backgroundColor = #colorLiteral(red: 1, green: 0.9764705882, blue: 0.9450980392, alpha: 1) // 선택된 상태의 배경 색
                    newConfig?.background.strokeColor = #colorLiteral(red: 0.9469566941, green: 0.6374832988, blue: 0.2344205678, alpha: 1) // 선택된 상태의 테두리 색

                    var subtitleText = AttributedString("(멕시코, 인도 등)")
                    subtitleText.foregroundColor = #colorLiteral(red: 0.9469566941, green: 0.6374832988, blue: 0.2344205678, alpha: 1)
                    subtitleText.font = UIFont(name: "Pretendard-Medium", size: 11)
                    newConfig?.attributedSubtitle = subtitleText
                    sender.configuration = newConfig
                    
                    
                    
                    if var model = dailyScrumModel{
                        model.todayElseFood = 1
                        dailyScrumModel = model
                    }
                    checkToNext = 1
                } else {
                    var newConfig = sender.configuration
                    var text = AttributedString("기타")
                    text.foregroundColor = #colorLiteral(red: 0.7254901961, green: 0.7254901961, blue: 0.7254901961, alpha: 1)
                    text.font = UIFont(name: "Pretendard-Bold", size: 15)
                    newConfig?.attributedTitle = text
                    newConfig?.background.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) // 선택된 상태의 배경 색
                    newConfig?.background.strokeColor = #colorLiteral(red: 0.8745098039, green: 0.8745098039, blue: 0.8745098039, alpha: 1) // 선택된 상태의 테두리 색

                    var subtitleText = AttributedString("(멕시코, 인도 등)")
                    subtitleText.foregroundColor = #colorLiteral(red: 0.7254901961, green: 0.7254901961, blue: 0.7254901961, alpha: 1)
                    subtitleText.font = UIFont(name: "Pretendard-Medium", size: 11)
                    newConfig?.attributedSubtitle = subtitleText
                    sender.configuration = newConfig
                
                    
                    if var model = dailyScrumModel{
                        model.todayElseFood = 0
                        dailyScrumModel = model

                    }
                    checkToNext = 0
                }

                // 버튼 상태 업데이트 요청
                sender.setNeedsUpdateConfiguration()
                updateNextButtonState()
    }
    
    
    func updateNextButtonState() {
            if koreaFoodButton.isSelected || americaFoodButton.isSelected ||
                chinaFoodButton.isSelected ||
                japanFoodButton.isSelected ||
                tieFoodButton.isSelected ||
                etcFoodButton.isSelected{
                nextButton.isEnabled = true
                nextButton.configuration?.background.backgroundColor = #colorLiteral(red: 1, green: 0.5921568627, blue: 0.1019607843, alpha: 1) // 활성화 색상
                nextButton.configuration?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
                    var outgoing = incoming
                    outgoing.foregroundColor = UIColor.white
                    return outgoing
                }
            } else {
                nextButton.isEnabled = false
                nextButton.configuration?.background.backgroundColor = #colorLiteral(red: 0.8705882353, green: 0.8705882353, blue: 0.8705882353, alpha: 1) // 비활성화 색상
                nextButton.configuration?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
                    var outgoing = incoming
                    outgoing.foregroundColor = UIColor.gray
                    return outgoing
                }
            }
        }
    
    
    @objc func skipToNext(){
        if checkToNext == 0 {
            if var model = dailyScrumModel{
                model.todayKoreanFood = 1
                model.todayWesternFood = 1
                model.todayChineseFood = 1
                model.todayJapaneseFood = 1
                model.todaySoutheastAsianFood = 1
                model.todayElseFood = 1
                dailyScrumModel = model
            }
            
            let preferVC = PreferViewController3()
            preferVC.dailyScrumModel = self.dailyScrumModel
            preferVC.uid = self.uid  // uid 전달
            preferVC.name = self.name  // name 전달
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
    
    
    
    
    @objc func moveToNext(){
        if checkToNext == 1 {
            let preferVC = PreferViewController3()
            preferVC.uid = self.uid  // uid 전달
            preferVC.name = self.name  // name 전달
            preferVC.dailyScrumModel = self.dailyScrumModel
            
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
    
    
    func setUI(){
        view.addSubview(lineImage)
        
        view.addSubview(titleLabel1)
        view.addSubview(titleLabel2)
        view.addSubview(titleLabel3)
        view.addSubview(titleLabel4)
        view.addSubview(line)
        view.addSubview(nextButton)
        view.addSubview(skipButton)
        
        view.addSubview(koreaFoodButton)
        view.addSubview(americaFoodButton)
        view.addSubview(chinaFoodButton)
        view.addSubview(japanFoodButton)
        view.addSubview(tieFoodButton)
        view.addSubview(etcFoodButton)
        
        
        
        NSLayoutConstraint.activate([
            lineImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 57.4),
                        lineImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
                        lineImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32),
                        
                        
                        // 변경
                         titleLabel1.topAnchor.constraint(equalTo: lineImage.topAnchor , constant: 38),
                        titleLabel1.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor , constant: 32),
                   
                        titleLabel2.topAnchor.constraint(equalTo: lineImage.topAnchor , constant: 38),
                        titleLabel2.leadingAnchor.constraint(equalTo: titleLabel1.trailingAnchor , constant: 0),
            
            titleLabel3.topAnchor.constraint(equalTo: titleLabel1.bottomAnchor , constant: 3),
            titleLabel3.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            
            titleLabel4.topAnchor.constraint(equalTo: titleLabel3.bottomAnchor , constant: 499),
                        titleLabel4.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            nextButton.topAnchor.constraint(equalTo: titleLabel4.bottomAnchor, constant: 19),
            nextButton.leadingAnchor.constraint(equalTo: line.trailingAnchor, constant: 10.6),
            nextButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            nextButton.heightAnchor.constraint(equalToConstant: 48),
 
            skipButton.topAnchor.constraint(equalTo: titleLabel4.bottomAnchor , constant: 26),
            skipButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor , constant: 33.2),
            
            
            line.widthAnchor.constraint(equalToConstant: 2),
            line.heightAnchor.constraint(equalToConstant: 20),
            line.topAnchor.constraint(equalTo: titleLabel4.bottomAnchor, constant: 33),
            line.leadingAnchor.constraint(equalTo: skipButton.trailingAnchor , constant: 8.6 ),
            
//            skipButton.heightAnchor.constraint(equalToConstant: 48),
//            skipButton.widthAnchor.constraint(equalToConstant: 108),
            
            koreaFoodButton.topAnchor.constraint(equalTo: titleLabel3.bottomAnchor , constant: 25.1),
            koreaFoodButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor , constant: 50.4),
            koreaFoodButton.widthAnchor.constraint(equalToConstant: 130),
            koreaFoodButton.heightAnchor.constraint(equalToConstant: 120),
            
            
            americaFoodButton.topAnchor.constraint(equalTo: titleLabel3.bottomAnchor , constant: 24.8),
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
            backButton.widthAnchor.constraint(equalToConstant: 10),
            backButton.heightAnchor.constraint(equalToConstant: 22),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 31.79),
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 68)
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
    
    
}
