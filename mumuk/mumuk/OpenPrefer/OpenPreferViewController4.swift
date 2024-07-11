//
//  OpenPreferViewController1.swift
//  mumuk
//
//  Created by 김민준 on 7/3/24.
//

import UIKit

class OpenPreferViewController4 : UIViewController {
    
    var checkToNext : Int = 0
    var uid : String?
    var name : String?
    var preferModel : OpenPreferModel?
    
    let lineImage : UIImageView = {
         let lineImage = UIImageView()
         lineImage.image = UIImage(named: "openline4")
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
//        button.addTarget(self, action: #selector(firstButtonTapped), for: .touchUpInside)

        return button
        
    }()
    
    let titleLabel1 : UILabel = {
        let label = UILabel()
        label.text = "현재 상태"
        label.font = UIFont(name: "Pretendard-Bold", size: 26)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let titleLabel2 : UILabel = {
        let label = UILabel()
        label.text = "에 해당되는"
        label.font = UIFont(name: "Pretendard-Light", size: 26)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let titleLabel3 : UILabel = {
        let label = UILabel()
        label.text = "선택사항을 골라주세요!"
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
    
    
    
    let foodButton1 : UIButton = {
        
        var config = UIButton.Configuration.filled()
        config.background.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        config.imagePadding = 2
        config.imagePlacement = .top
        
        
        // 이미지 추가
        
        if let image = UIImage(named: "diet"){
            let size = CGSize(width: 72, height: 49)
            UIGraphicsBeginImageContextWithOptions(size, false, 0.0) // 그래픽 컨텍스트 생성
            image.draw(in: CGRect(origin: .zero, size: size))
            let scaledImage = UIGraphicsGetImageFromCurrentImageContext() // 그래픽 컨텍스트에서 UIImage 객체 생성
            UIGraphicsEndImageContext() // 그래픽 컨텍스트 종료
            
            config.image = scaledImage
    
        }
        

        // 라벨 추가
        var text = AttributedString.init("다이어트")
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
        
        if let image = UIImage(named: "halal"){
            let size = CGSize(width: 52, height: 54)
            UIGraphicsBeginImageContextWithOptions(size, false, 0.0) // 그래픽 컨텍스트 생성
            image.draw(in: CGRect(origin: .zero, size: size))
            let scaledImage = UIGraphicsGetImageFromCurrentImageContext() // 그래픽 컨텍스트에서 UIImage 객체 생성
            UIGraphicsEndImageContext() // 그래픽 컨텍스트 종료
            
            config.image = scaledImage
    
        }
        

        // 라벨 추가
        var text = AttributedString.init("할랄")
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
        
        if let image = UIImage(named: "vegan"){
            let size = CGSize(width: 57, height: 45)
            UIGraphicsBeginImageContextWithOptions(size, false, 0.0) // 그래픽 컨텍스트 생성
            image.draw(in: CGRect(origin: .zero, size: size))
            let scaledImage = UIGraphicsGetImageFromCurrentImageContext() // 그래픽 컨텍스트에서 UIImage 객체 생성
            UIGraphicsEndImageContext() // 그래픽 컨텍스트 종료
            
            config.image = scaledImage
    
        }
        

        // 라벨 추가
        var text = AttributedString.init("비건")
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
        
    
        
        var text = AttributedString.init("선택사항 없음")
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
    
//    @objc private func firstButtonTapped() {
//        let mainViewController = Openprofile()
//          navigationController?.pushViewController(mainViewController, animated: true)
//    }
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        uid = UserDefaultsManager.shared.getUserId() ?? ""
        print(" open uid4 : \(uid)")
        print("open model4 : \(preferModel)")
        print("open name : \(name)")
        
        nextButton.addTarget(self, action: #selector(moveToNext), for: .touchUpInside)
        setupBackButton()
        setUI()
    
        foodButton1.setNeedsUpdateConfiguration()
        foodButton2.setNeedsUpdateConfiguration()
        foodButton3.setNeedsUpdateConfiguration()
        foodButton4.setNeedsUpdateConfiguration()
        
        
        foodButton1.addTarget(self, action: #selector(buttonClicked1(_:)), for: .touchUpInside)
        foodButton2.addTarget(self, action: #selector(buttonClicked2(_:)), for: .touchUpInside)
        foodButton3.addTarget(self, action: #selector(buttonClicked3(_:)), for: .touchUpInside)
        foodButton4.addTarget(self, action: #selector(buttonClicked4(_:)), for: .touchUpInside)
        
        

        
        
    }
    
    
    func setUI(){
        view.addSubview(lineImage)
        view.addSubview(nextButton)
        view.addSubview(titleLabel1)
        view.addSubview(titleLabel2)
        view.addSubview(titleLabel3)
        view.addSubview(titleLabel5)
        
        view.addSubview(foodButton1)
        view.addSubview(foodButton2)
        view.addSubview(foodButton3)
        view.addSubview(foodButton4)
        
        
    
        
        NSLayoutConstraint.activate([
            lineImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 57.4),
                        lineImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 33),
                        lineImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                        
                        
                        // 변경
                           titleLabel1.topAnchor.constraint(equalTo: lineImage.bottomAnchor , constant: 38),
                        titleLabel1.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor , constant: 32),
            
            titleLabel2.topAnchor.constraint(equalTo: lineImage.bottomAnchor , constant: 38),
            titleLabel2.leadingAnchor.constraint(equalTo: titleLabel1.trailingAnchor , constant: 0),
            
            titleLabel3.topAnchor.constraint(equalTo: titleLabel1.bottomAnchor , constant: 4),
            titleLabel3.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor , constant: 32),
        
            titleLabel5.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -20),
                        titleLabel5.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -13.7),
            nextButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32.4),
            nextButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -31.6),
            nextButton.heightAnchor.constraint(equalToConstant: 48),
            
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
    
    
    
    
    
    @objc func buttonClicked1(_ sender: UIButton) {
        sender.isSelected.toggle()
        foodButton2.isSelected = false
        foodButton3.isSelected = false
        foodButton4.isSelected = false
        preferModel?.foodTypeId = 1
        
        updateButtonConfiguration(button: sender, isSelected: sender.isSelected, text: "다이어트")
        updateButtonConfiguration(button: foodButton2, isSelected: false, text: "할랄")
        updateButtonConfiguration(button: foodButton3, isSelected: false , text: "비건")
        updateButtonConfiguration(button: foodButton4, isSelected: false, text: "선택사항 없음")
     
    }
    
    @objc func buttonClicked2(_ sender: UIButton) {
        
        foodButton1.isSelected = false
        sender.isSelected.toggle()
        foodButton3.isSelected = false
        foodButton4.isSelected = false
        preferModel?.foodTypeId = 2
        
        updateButtonConfiguration(button: foodButton1, isSelected: false, text: "다이어트")
        updateButtonConfiguration(button: sender, isSelected: sender.isSelected, text: "할랄")
        updateButtonConfiguration(button: foodButton3, isSelected: false , text: "비건")
        updateButtonConfiguration(button: foodButton4, isSelected: false, text: "선택사항 없음")
     
    }
    
    @objc func buttonClicked3(_ sender: UIButton) {
        
        foodButton1.isSelected = false
        foodButton2.isSelected = false
        sender.isSelected.toggle()
        foodButton4.isSelected = false
        preferModel?.foodTypeId = 3
        
        updateButtonConfiguration(button: foodButton1, isSelected: false, text: "다이어트")
        
        updateButtonConfiguration(button: foodButton2, isSelected: false , text: "할랄")
        updateButtonConfiguration(button: sender, isSelected: sender.isSelected, text: "비건")
        updateButtonConfiguration(button: foodButton4, isSelected: false, text: "선택사항 없음")
     
    }
    
    @objc func buttonClicked4(_ sender: UIButton) {
        
        foodButton1.isSelected = false
        foodButton2.isSelected = false
        foodButton3.isSelected = false
        sender.isSelected.toggle()
        preferModel?.foodTypeId = 4
        
        updateButtonConfiguration(button: foodButton1, isSelected: false, text: "다이어트")
        updateButtonConfiguration(button: foodButton2, isSelected: false , text: "할랄")
        updateButtonConfiguration(button: foodButton3, isSelected: false, text: "비건")
        updateButtonConfiguration(button: sender, isSelected: sender.isSelected, text: "선택사항 없음")
        
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
        
        if text == "다이어트" {
            if let image = UIImage(named:"diet") {
                newConfig?.image = resizeImage(image: image, targetSize: CGSize(width: 72, height: 49))
            }
        }
        else if text == "할랄" {
            if let image = UIImage(named:"halal") {
                newConfig?.image = resizeImage(image: image, targetSize: CGSize(width: 52, height: 54))
            }
        }
        else if text == "비건" {
            if let image = UIImage(named:"vegan") {
                newConfig?.image = resizeImage(image: image, targetSize: CGSize(width: 57, height: 45))
            }
        }else if text == "선택사항 없음"{
            newConfig?.image = nil
        }
        
        
        
            
            newConfig?.attributedTitle = attributedText
            button.configuration = newConfig
            checkToNext = 1
            button.setNeedsUpdateConfiguration()
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
    
    
    
    @objc func moveToNext() {
        if foodButton1.isSelected || foodButton2.isSelected || foodButton3.isSelected || foodButton4.isSelected {
            let loadingVC = OpenPrefLoading()
            loadingVC.modalPresentationStyle = .fullScreen
            present(loadingVC, animated: true, completion: nil)
            
            // preferModel과 uid 전달 (필요한 경우)
            if let model = preferModel, let userId = uid {
                makePostRequest(model: model, userId: userId)
            }
        }
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
    
    
    func makePostRequest(model: OpenPreferModel, userId: String) {
        guard let url = URL(string: "https://mumuk.store/pref/\(userId)") else {
            print("🚨 Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(model)
            request.httpBody = jsonData

            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print("Request JSON: \(jsonString)")
            }

            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("🚨", error)
                } else if let data = data {
                    if let responseString = String(data: data, encoding: .utf8) {
                        print("✅ Response: \(responseString)")
                    }
                }
            }
            task.resume()
        } catch {
            print("🚨", error)
        }
    }
    
    
    
    
}



