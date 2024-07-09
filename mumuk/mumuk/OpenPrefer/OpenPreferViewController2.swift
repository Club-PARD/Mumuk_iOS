//
//  OpenPreferViewController1.swift
//  mumuk
//
//  Created by 김민준 on 7/3/24.
//

import UIKit

class OpenPreferViewController2 : UIViewController {
    var uid : String?
    var name : String?
    var preferModel : OpenPreferModel?
    

    
    let lineImage1 : UIImageView = {
        let lineImage = UIImageView()
        lineImage.image = UIImage(named: "yellowLine")
        lineImage.translatesAutoresizingMaskIntoConstraints = false
        lineImage.contentMode = .scaleAspectFill
        lineImage.clipsToBounds = true
        return lineImage
    }()
    
    let lineImage2 : UIImageView = {
        let lineImage = UIImageView()
        lineImage.image = UIImage(named: "yellowLine")
        lineImage.translatesAutoresizingMaskIntoConstraints = false
        lineImage.contentMode = .scaleAspectFill
        lineImage.clipsToBounds = true
        return lineImage
    }()
    
    let lineImage3 : UIImageView = {
        let lineImage = UIImageView()
        lineImage.image = UIImage(named: "grayLine")
        lineImage.translatesAutoresizingMaskIntoConstraints = false
        lineImage.contentMode = .scaleAspectFill
        lineImage.clipsToBounds = true
        return lineImage
    }()
    
    let lineImage4 : UIImageView = {
        let lineImage = UIImageView()
        lineImage.image = UIImage(named: "grayLine")
        lineImage.translatesAutoresizingMaskIntoConstraints = false
        lineImage.contentMode = .scaleAspectFill
        lineImage.clipsToBounds = true
        return lineImage
    }()
    
    let nextButton : UIButton = {
        var config = UIButton.Configuration.filled()
        config.background.backgroundColor = #colorLiteral(red: 1, green: 0.5921568627, blue: 0.1019607843, alpha: 1)
        
        
        // 내부 여백 설정
        config.contentInsets = NSDirectionalEdgeInsets(top: 7, leading: 148, bottom: 7, trailing: 149)
        
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
        label.text = "어떤 매운 맛 타입"
        label.font = UIFont(name: "Pretendard-Bold", size: 26)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let titleLabel2 : UILabel = {
        let label = UILabel()
        label.text = "인지"
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
    
    let titleLabel4 : UILabel = {
        let label = UILabel()
        label.text = "* 맵기 기준: 불닭볶음면"
        label.font = UIFont(name: "Pretendard-SemiBold", size: 12)
        label.textColor = #colorLiteral(red: 1, green: 0.5921568627, blue: 0.1019607843, alpha: 1)
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
    
    
    let foodButton1 : UIButton = {
        var config = UIButton.Configuration.filled()
        config.background.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        config.imagePadding = 4
        config.imagePlacement = .top
        
        
        // 이미지 추가
        
        if let image = UIImage(named: "spicy"){
            let size = CGSize(width: 73, height: 84)
            UIGraphicsBeginImageContextWithOptions(size, false, 0.0) // 그래픽 컨텍스트 생성
            image.draw(in: CGRect(origin: .zero, size: size))
            let scaledImage = UIGraphicsGetImageFromCurrentImageContext() // 그래픽 컨텍스트에서 UIImage 객체 생성
            UIGraphicsEndImageContext() // 그래픽 컨텍스트 종료
            
            config.image = scaledImage
    
        }
        

        // 라벨 추가
        var text = AttributedString.init("맵고수")
        text.foregroundColor = #colorLiteral(red: 0.7254901961, green: 0.7254901961, blue: 0.7254901961, alpha: 1)
        text.font = UIFont(name: "Pretendard-Bold" , size: 20)
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
        
        if let image = UIImage(named: "not_spicy"){
            let size = CGSize(width: 82, height: 86.3)
            UIGraphicsBeginImageContextWithOptions(size, false, 0.0) // 그래픽 컨텍스트 생성
            image.draw(in: CGRect(origin: .zero, size: size))
            let scaledImage = UIGraphicsGetImageFromCurrentImageContext() // 그래픽 컨텍스트에서 UIImage 객체 생성
            UIGraphicsEndImageContext() // 그래픽 컨텍스트 종료
            
            config.image = scaledImage
    
        }
        

        // 라벨 추가
        var text = AttributedString.init("맵찔이")
        text.foregroundColor = #colorLiteral(red: 0.7254901961, green: 0.7254901961, blue: 0.7254901961, alpha: 1)
        text.font = UIFont(name: "Pretendard-Bold" , size: 20)
        config.attributedTitle = text
        
        config.background.strokeColor = #colorLiteral(red: 0.8745098039, green: 0.8745098039, blue: 0.8745098039, alpha: 1)
        config.background.strokeWidth = 2
        config.background.cornerRadius = 20

        
        // config 버튼에 합치기
       
        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(" open uid2 : \(uid)")
        print("open model2 : \(preferModel)")
        
        view.backgroundColor = .white
        nextButton.addTarget(self, action: #selector(moveToNext), for: .touchUpInside)
        setupBackButton()
        setUI()
       
       
        foodButton1.setNeedsUpdateConfiguration()
        foodButton2.setNeedsUpdateConfiguration()
        
        foodButton1.addTarget(self, action: #selector(buttonClicked1(_:)), for: .touchUpInside)
        foodButton2.addTarget(self, action: #selector(buttonClicked2(_:)), for: .touchUpInside)
        
    
        
    }
    
   
    @objc func buttonClicked1(_ sender: UIButton) {
        sender.isSelected.toggle() // 버튼의 선택 상태를 토글
        
        
        
        
        foodButton2.isSelected = false // 다른 버튼의 선택 상태를 해제
        
        updateButtonConfiguration(button: sender, isSelected: sender.isSelected, text: "맵고수")
        updateButtonConfiguration(button: foodButton2, isSelected: false, text: "맵찔이")
//
       
        preferModel?.spicyType = true
        
        
        
        
        
    }
    
    @objc func buttonClicked2(_ sender: UIButton) {
           sender.isSelected.toggle() // 버튼의 선택 상태를 토글
           foodButton1.isSelected = false // 다른 버튼의 선택 상태를 해제

           updateButtonConfiguration(button: sender, isSelected: sender.isSelected, text: "맵찔이")
           updateButtonConfiguration(button: foodButton1, isSelected: false, text: "맵고수")
        
      
        preferModel?.spicyType = false

       }
    
    
    // 버튼 눌렸을때 업데이트
    func updateButtonConfiguration(button: UIButton, isSelected: Bool, text: String) {
        var newConfig = button.configuration

        var attributedText = AttributedString(text)
        attributedText.font = UIFont(name: "Pretendard-Bold", size: 20)

        if isSelected {
            attributedText.foregroundColor = #colorLiteral(red: 0.9469566941, green: 0.6374832988, blue: 0.2344205678, alpha: 1)
            newConfig?.background.backgroundColor = #colorLiteral(red: 1, green: 0.9764705882, blue: 0.9450980392, alpha: 1) // 선택된 상태의 배경 색
            newConfig?.background.strokeColor = #colorLiteral(red: 0.9469566941, green: 0.6374832988, blue: 0.2344205678, alpha: 1) // 선택된 상태의 테두리 색
            
        } else {
            attributedText.foregroundColor = #colorLiteral(red: 0.7254901961, green: 0.7254901961, blue: 0.7254901961, alpha: 1)
            newConfig?.background.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) // 기본 배경 색
            newConfig?.background.strokeColor = #colorLiteral(red: 0.8745098039, green: 0.8745098039, blue: 0.8745098039, alpha: 1) // 기본 테두리 색
            

        }

        if text == "맵고수" {
            if let image = UIImage(named:"spicy") {
                newConfig?.image = resizeImage(image: image, targetSize: CGSize(width: 73, height: 84))
            }
        } else if text == "맵찔이" {
            if let image = UIImage(named:"not_spicy") {
                newConfig?.image = resizeImage(image: image, targetSize: CGSize(width: 82, height: 86.3))
            }
        }

        
        
        
        newConfig?.attributedTitle = attributedText
        button.configuration = newConfig
    }
   
    
    
    // 이미지 사이즈 조정
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
    
    
    
    
    @objc func moveToNext(){

        
        if  foodButton1.isSelected || foodButton2.isSelected {
            let preferVC = OpenPreferViewController3()
            
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
    
    
    
    func setUI(){
        view.addSubview(lineImage1)
        view.addSubview(lineImage2)
        view.addSubview(lineImage3)
        view.addSubview(lineImage4)
        view.addSubview(nextButton)
        
        view.addSubview(titleLabel1)
        view.addSubview(titleLabel2)
        view.addSubview(titleLabel3)
        view.addSubview(titleLabel4)
        view.addSubview(titleLabel5)
        
        view.addSubview(foodButton1)
        view.addSubview(foodButton2)
        
        
        
        NSLayoutConstraint.activate([
            lineImage1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor , constant: 57.4),
            lineImage1.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor , constant: 36),
            lineImage1.widthAnchor.constraint(equalToConstant: 69),
            
            lineImage2.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor , constant: 57.4),
            lineImage2.leadingAnchor.constraint(equalTo: lineImage1.trailingAnchor , constant: 16),
            lineImage2.widthAnchor.constraint(equalToConstant: 69),
            
            lineImage3.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor , constant: 57.4),
            lineImage3.leadingAnchor.constraint(equalTo: lineImage2.trailingAnchor , constant: 16),
            lineImage3.widthAnchor.constraint(equalToConstant: 69),

            lineImage4.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor , constant: 57.4),
            lineImage4.leadingAnchor.constraint(equalTo: lineImage3.trailingAnchor , constant: 16),
            lineImage4.widthAnchor.constraint(equalToConstant: 69),
        
            titleLabel1.topAnchor.constraint(equalTo: lineImage1.bottomAnchor , constant: 38),
            titleLabel1.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor , constant: 32),
            
            titleLabel2.topAnchor.constraint(equalTo: lineImage1.bottomAnchor , constant: 38),
            titleLabel2.leadingAnchor.constraint(equalTo: titleLabel1.trailingAnchor , constant: 0),
            
            titleLabel3.topAnchor.constraint(equalTo: titleLabel1.bottomAnchor , constant: 2.8),
            titleLabel3.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor , constant: 32),
        
            titleLabel4.topAnchor.constraint(equalTo: titleLabel3.bottomAnchor, constant: 3),
            titleLabel4.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            
            titleLabel5.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -20),
            titleLabel5.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor , constant: 58.4),
            
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -13.7),
            nextButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32.4),
            nextButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -31.6),
            nextButton.heightAnchor.constraint(equalToConstant: 48),
            
            
            foodButton1.topAnchor.constraint(equalTo: titleLabel3.bottomAnchor , constant: 75.1),
            foodButton1.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor , constant: 40),
            foodButton1.widthAnchor.constraint(equalToConstant: 142),
            foodButton1.heightAnchor.constraint(equalToConstant: 226),
            
            
            foodButton2.topAnchor.constraint(equalTo: titleLabel3.bottomAnchor , constant: 75.1),
            foodButton2.leadingAnchor.constraint(equalTo: foodButton1.trailingAnchor , constant: 32),
            foodButton2.widthAnchor.constraint(equalToConstant: 142),
            foodButton2.heightAnchor.constraint(equalToConstant: 226),
            
            
            
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
