//
//  PreferViewController1.swift
//  mumuk
//
//  Created by 김민준 on 7/2/24.
//
import UIKit


class PreferViewController3 : UIViewController{
    
    var checkToNext : Int = 0
    var uid : String?
    var name : String? 
    var clickedCheck : [Int] = [0,0,0,0]
    
    var dailyScrumModel : PreferModel?
    
    let lineImage : UIImageView = {
          let lineImage = UIImageView()
          lineImage.image = UIImage(named: "line3")  //
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
        
        
        // 내부 여백 설정
        config.contentInsets = NSDirectionalEdgeInsets(top: 7, leading: 0, bottom: 7, trailing: 0)
        
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
    
   

    
    
    
    let foodButton1 : UIButton = {
        
        var config = UIButton.Configuration.filled()
        config.background.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        config.imagePadding = 4
        config.imagePlacement = .top
        
        
        // 이미지 추가
        
        if let image = UIImage(named: "meat"){
            let size = CGSize(width: 63, height: 58)
            UIGraphicsBeginImageContextWithOptions(size, false, 0.0) // 그래픽 컨텍스트 생성
            image.draw(in: CGRect(origin: .zero, size: size))
            let scaledImage = UIGraphicsGetImageFromCurrentImageContext() // 그래픽 컨텍스트에서 UIImage 객체 생성
            UIGraphicsEndImageContext() // 그래픽 컨텍스트 종료
            
            config.image = scaledImage
    
        }
        

        // 라벨 추가
        var text = AttributedString.init("육류")
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
    
    
    let foodButton2 : UIButton = {
        var config = UIButton.Configuration.filled()
        config.background.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        config.imagePadding = 4
        config.imagePlacement = .top
        
        
        // 이미지 추가
        
        if let image = UIImage(named: "vegetable"){
            let size = CGSize(width: 58, height: 63)
            UIGraphicsBeginImageContextWithOptions(size, false, 0.0) // 그래픽 컨텍스트 생성
            image.draw(in: CGRect(origin: .zero, size: size))
            let scaledImage = UIGraphicsGetImageFromCurrentImageContext() // 그래픽 컨텍스트에서 UIImage 객체 생성
            UIGraphicsEndImageContext() // 그래픽 컨텍스트 종료
            
            config.image = scaledImage
    
        }
        

        // 라벨 추가
        var text = AttributedString.init("채소")
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
    
    
    
    let foodButton3 : UIButton = {
        var config = UIButton.Configuration.filled()
        config.background.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        config.imagePadding = 4
        config.imagePlacement = .top
        
        
        // 이미지 추가
        
        if let image = UIImage(named: "rice"){
            let size = CGSize(width: 63, height: 58)
            UIGraphicsBeginImageContextWithOptions(size, false, 0.0) // 그래픽 컨텍스트 생성
            image.draw(in: CGRect(origin: .zero, size: size))
            let scaledImage = UIGraphicsGetImageFromCurrentImageContext() // 그래픽 컨텍스트에서 UIImage 객체 생성
            UIGraphicsEndImageContext() // 그래픽 컨텍스트 종료
            
            config.image = scaledImage
    
        }
        

        // 라벨 추가
        var text = AttributedString.init("탄수화물")
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
    
    
    let foodButton4 : UIButton = {
        var config = UIButton.Configuration.filled()
        config.background.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        config.imagePadding = 4
        config.imagePlacement = .top
        
        
        // 이미지 추가
        
        if let image = UIImage(named: "fish"){
            let size = CGSize(width: 66, height: 51)
            UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
            image.draw(in: CGRect(origin: .zero, size: size))
            let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        
            config.image = scaledImage
    
        }
        
        var text = AttributedString.init("해산물")
        text.foregroundColor = #colorLiteral(red: 0.7254901961, green: 0.7254901961, blue: 0.7254901961, alpha: 1)
        text.font = UIFont(name: "Pretendard-Bold" , size: 15)
        config.attributedTitle = text
        
        config.background.strokeColor = #colorLiteral(red: 0.8745098039, green: 0.8745098039, blue: 0.8745098039, alpha: 1)
        config.background.strokeWidth = 2
        config.background.cornerRadius = 20
        
        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    
    
    
    

    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        nextButton.addTarget(self, action: #selector(moveToNext), for: .touchUpInside)
        skipButton.addTarget(self, action: #selector(skipToNext), for: .touchUpInside)
        setUI()
        setupBackButton()
        
        print("model3 : \(dailyScrumModel)")
        print("uid3 : \(uid)" )
        
        
        foodButton1.setNeedsUpdateConfiguration()
        foodButton2.setNeedsUpdateConfiguration()
        foodButton3.setNeedsUpdateConfiguration()
        foodButton4.setNeedsUpdateConfiguration()
          
        foodButton1.addTarget(self, action: #selector(buttonClicked1(_:)), for: .touchUpInside)
        foodButton2.addTarget(self, action: #selector(buttonClicked2(_:)), for: .touchUpInside)
        foodButton3.addTarget(self, action: #selector(buttonClicked3(_:)), for: .touchUpInside)
        foodButton4.addTarget(self, action: #selector(buttonClicked4(_:)), for: .touchUpInside)
    }
    
    
    
    @objc func buttonClicked1(_ sender: UIButton){
        sender.isSelected.toggle() // 버튼의 선택 상태를 토글

                // 상태에 따른 테두리 색 변경
                if sender.isSelected {
                    var newConfig = sender.configuration

            
                    var text = AttributedString("육류")
                    text.foregroundColor = #colorLiteral(red: 0.9469566941, green: 0.6374832988, blue: 0.2344205678, alpha: 1)
                    text.font = UIFont(name: "Pretendard-Bold", size: 15)
                    newConfig?.attributedTitle = text
                    newConfig?.background.backgroundColor = #colorLiteral(red: 1, green: 0.9764705882, blue: 0.9450980392, alpha: 1) // 선택된 상태의 배경 색
                    newConfig?.background.strokeColor = #colorLiteral(red: 0.9469566941, green: 0.6374832988, blue: 0.2344205678, alpha: 1) // 선택된 상태의 테두리 색
                    sender.configuration = newConfig
                    
                    
                    
                    if var model = dailyScrumModel{
                        model.todayMeat = 1
                        dailyScrumModel = model
                        
                    }
                    
                    
                    checkToNext = 1
                } else {
                    var newConfig = sender.configuration

            
                    var text = AttributedString("육류")
                    text.foregroundColor = #colorLiteral(red: 0.7254901961, green: 0.7254901961, blue: 0.7254901961, alpha: 1)
                    text.font = UIFont(name: "Pretendard-Bold", size: 15)
                    newConfig?.attributedTitle = text
                    newConfig?.background.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) // 선택된 상태의 배경 색
                    newConfig?.background.strokeColor = #colorLiteral(red: 0.8745098039, green: 0.8745098039, blue: 0.8745098039, alpha: 1) // 선택된 상태의 테두리 색
                    sender.configuration = newConfig
                    
                    
                    
                    if var model = dailyScrumModel{
                        model.todayMeat = 0
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

            
                    var text = AttributedString("채소")
                    text.foregroundColor = #colorLiteral(red: 0.9469566941, green: 0.6374832988, blue: 0.2344205678, alpha: 1)
                    text.font = UIFont(name: "Pretendard-Bold", size: 15)
                    newConfig?.attributedTitle = text
                    newConfig?.background.backgroundColor = #colorLiteral(red: 1, green: 0.9764705882, blue: 0.9450980392, alpha: 1) // 선택된 상태의 배경 색
                    newConfig?.background.strokeColor = #colorLiteral(red: 0.9469566941, green: 0.6374832988, blue: 0.2344205678, alpha: 1) // 선택된 상태의 테두리 색
                    sender.configuration = newConfig
                    
                    if var model = dailyScrumModel{
                        model.todayVegetable = 1
                        dailyScrumModel = model
                        
                    }
                    
                    checkToNext = 1
                } else {
                    var newConfig = sender.configuration

            
                    var text = AttributedString("채소")
                    text.foregroundColor = #colorLiteral(red: 0.7254901961, green: 0.7254901961, blue: 0.7254901961, alpha: 1)
                    text.font = UIFont(name: "Pretendard-Bold", size: 15)
                    newConfig?.attributedTitle = text
                    newConfig?.background.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) // 선택된 상태의 배경 색
                    newConfig?.background.strokeColor = #colorLiteral(red: 0.8745098039, green: 0.8745098039, blue: 0.8745098039, alpha: 1) // 선택된 상태의 테두리 색
                    sender.configuration = newConfig
                    
                    
                    if var model = dailyScrumModel{
                        model.todayVegetable = 0
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

            
                    var text = AttributedString("탄수화물")
                    text.foregroundColor = #colorLiteral(red: 0.9469566941, green: 0.6374832988, blue: 0.2344205678, alpha: 1)
                    text.font = UIFont(name: "Pretendard-Bold", size: 15)
                    newConfig?.attributedTitle = text
                    newConfig?.background.backgroundColor = #colorLiteral(red: 1, green: 0.9764705882, blue: 0.9450980392, alpha: 1) // 선택된 상태의 배경 색
                    newConfig?.background.strokeColor = #colorLiteral(red: 0.9469566941, green: 0.6374832988, blue: 0.2344205678, alpha: 1) // 선택된 상태의 테두리 색
                    sender.configuration = newConfig
                    
                    if var model = dailyScrumModel{
                        model.todayCarbohydrate = 1
                        dailyScrumModel = model
                        
                    }
                    checkToNext = 1
                } else {
                    var newConfig = sender.configuration

            
                    var text = AttributedString("탄수화물")
                    text.foregroundColor = #colorLiteral(red: 0.7254901961, green: 0.7254901961, blue: 0.7254901961, alpha: 1)
                    text.font = UIFont(name: "Pretendard-Bold", size: 15)
                    newConfig?.attributedTitle = text
                    newConfig?.background.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) // 선택된 상태의 배경 색
                    newConfig?.background.strokeColor = #colorLiteral(red: 0.8745098039, green: 0.8745098039, blue: 0.8745098039, alpha: 1) // 선택된 상태의 테두리 색
                    sender.configuration = newConfig
                    
                    
                    if var model = dailyScrumModel{
                        model.todayCarbohydrate = 0
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

            
                    var text = AttributedString("해산물")
                    text.foregroundColor = #colorLiteral(red: 0.9469566941, green: 0.6374832988, blue: 0.2344205678, alpha: 1)
                    text.font = UIFont(name: "Pretendard-Bold", size: 15)
                    newConfig?.attributedTitle = text
                    newConfig?.background.backgroundColor = #colorLiteral(red: 1, green: 0.9764705882, blue: 0.9450980392, alpha: 1) // 선택된 상태의 배경 색
                    newConfig?.background.strokeColor = #colorLiteral(red: 0.9469566941, green: 0.6374832988, blue: 0.2344205678, alpha: 1) // 선택된 상태의 테두리 색
                    sender.configuration = newConfig
                    
                    
                    if var model = dailyScrumModel{
                        model.todaySeafood = 1
                        dailyScrumModel = model
                        
                    }
                    checkToNext = 1
                } else {
                    var newConfig = sender.configuration

            
                    var text = AttributedString("해산물")
                    text.foregroundColor = #colorLiteral(red: 0.7254901961, green: 0.7254901961, blue: 0.7254901961, alpha: 1)
                    text.font = UIFont(name: "Pretendard-Bold", size: 15)
                    newConfig?.attributedTitle = text
                    newConfig?.background.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) // 선택된 상태의 배경 색
                    newConfig?.background.strokeColor = #colorLiteral(red: 0.8745098039, green: 0.8745098039, blue: 0.8745098039, alpha: 1) // 선택된 상태의 테두리 색
                    sender.configuration = newConfig
                    
                    
                    
                    if var model = dailyScrumModel{
                        model.todaySeafood = 0
                        dailyScrumModel = model
                        
                    }
                    checkToNext = 0
                }

                // 버튼 상태 업데이트 요청
                sender.setNeedsUpdateConfiguration()
        updateNextButtonState()
    }
    
    
    func updateNextButtonState() {
            if foodButton1.isSelected || foodButton2.isSelected || foodButton3.isSelected  || foodButton4.isSelected{
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
        if checkToNext  == 0{
            let preferVC = PreferViewController4()
            
            if var model = dailyScrumModel{
                model.todayMeat = 1
                model.todayVegetable = 1
                model.todayCarbohydrate = 1
                model.todaySeafood = 1
                dailyScrumModel = model 
            }
            
            
            
            
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
        if checkToNext == 1{
            let preferVC = PreferViewController4()
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
        view.addSubview(nextButton)
        view.addSubview(skipButton)
        view.addSubview(line)
        
        view.addSubview(foodButton1)
        view.addSubview(foodButton2)
        view.addSubview(foodButton3)
        view.addSubview(foodButton4)
        

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
            
            
            foodButton1.topAnchor.constraint(equalTo: titleLabel3.bottomAnchor , constant: 74),
            foodButton1.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor , constant: 50.4),
            foodButton1.widthAnchor.constraint(equalToConstant: 130),
            foodButton1.heightAnchor.constraint(equalToConstant: 120),
            
            
            foodButton2.topAnchor.constraint(equalTo: titleLabel3.bottomAnchor , constant: 74),
            foodButton2.leadingAnchor.constraint(equalTo: foodButton1.trailingAnchor , constant: 31),
            foodButton2.widthAnchor.constraint(equalToConstant: 130),
            foodButton2.heightAnchor.constraint(equalToConstant: 120),
            
            foodButton3.topAnchor.constraint(equalTo: foodButton1.bottomAnchor , constant: 24),
            foodButton3.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor , constant: 50.4),
            foodButton3.widthAnchor.constraint(equalToConstant: 130),
            foodButton3.heightAnchor.constraint(equalToConstant: 120),
            
            foodButton4.topAnchor.constraint(equalTo: foodButton1.bottomAnchor , constant: 24),
            foodButton4.leadingAnchor.constraint(equalTo: foodButton3.trailingAnchor , constant: 31),
            foodButton4.widthAnchor.constraint(equalToConstant: 130),
            foodButton4.heightAnchor.constraint(equalToConstant: 120),
            
            
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
