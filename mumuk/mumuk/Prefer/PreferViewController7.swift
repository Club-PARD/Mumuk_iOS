//
//  PreferViewController1.swift
//  mumuk
//
//  Created by 김민준 on 7/2/24.
//
import UIKit


class PreferViewController7 : UIViewController{
    var dailyScrumModel : PreferModel?
    
    var uid : String?
    var name : String?

    
    let lineImage1 : UIImageView = {
        let lineImage = UIImageView()
        
    
        lineImage.image = UIImage(named: "yellowLine")
        lineImage.translatesAutoresizingMaskIntoConstraints = false
        lineImage.contentMode = .scaleAspectFit
        return lineImage
    }()
    
    let lineImage2 : UIImageView = {
        let lineImage = UIImageView()
        
    
        lineImage.image = UIImage(named: "yellowLine")
        lineImage.translatesAutoresizingMaskIntoConstraints = false
        lineImage.contentMode = .scaleAspectFit
        return lineImage
    }()
    
    let lineImage3 : UIImageView = {
        let lineImage = UIImageView()
        
    
        lineImage.image = UIImage(named: "yellowLine")
        lineImage.translatesAutoresizingMaskIntoConstraints = false
        lineImage.contentMode = .scaleAspectFit
        return lineImage
    }()
    
    let lineImage4 : UIImageView = {
        let lineImage = UIImageView()
        
    
        lineImage.image = UIImage(named: "yellowLine")
        lineImage.translatesAutoresizingMaskIntoConstraints = false
        lineImage.contentMode = .scaleAspectFit
        return lineImage
    }()
    
    
    let lineImage5 : UIImageView = {
        let lineImage = UIImageView()
        
    
        lineImage.image = UIImage(named: "yellowLine")
        lineImage.translatesAutoresizingMaskIntoConstraints = false
        lineImage.contentMode = .scaleAspectFit
        return lineImage
    }()
    
    
    let lineImage6 : UIImageView = {
        let lineImage = UIImageView()
        
    
        lineImage.image = UIImage(named: "yellowLine")
        lineImage.translatesAutoresizingMaskIntoConstraints = false
        lineImage.contentMode = .scaleAspectFit
        return lineImage
    }()
    
    let lineImage7 : UIImageView = {
        let lineImage = UIImageView()
        
    
        lineImage.image = UIImage(named: "yellowLine")
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
        label.text = "골라주세요!"
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
        config.imagePadding = 8.86
        config.imagePlacement = .bottom
        
        
        // 이미지 추가
        
        if let image = UIImage(named: "soup"){
            let size = CGSize(width: 107, height: 71)
            UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
            image.draw(in: CGRect(origin: .zero, size: size))
            let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        
            config.image = scaledImage
    
        }
        
        var text = AttributedString.init("국물")
        text.foregroundColor = #colorLiteral(red: 0.7254901961, green: 0.7254901961, blue: 0.7254901961, alpha: 1)
        text.font = UIFont(name: "Pretendard-Bold" , size: 20)
        config.attributedTitle = text
        
        config.background.strokeColor = #colorLiteral(red: 0.8745098039, green: 0.8745098039, blue: 0.8745098039, alpha: 1)
        config.background.strokeWidth = 2
        config.background.cornerRadius = 20
        
        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    
    
    let foodButton2 : UIButton = {
        var config = UIButton.Configuration.filled()
        config.background.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        config.imagePadding = 26
        config.imagePlacement = .bottom
        
        
        // 이미지 추가
        
        if let image = UIImage(named: "no_soup"){
            let size = CGSize(width: 93, height: 54)
            UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
            image.draw(in: CGRect(origin: .zero, size: size))
            let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        
            config.image = scaledImage
    
        }
        
        var text = AttributedString.init("NO 국물")
        text.foregroundColor = #colorLiteral(red: 0.7254901961, green: 0.7254901961, blue: 0.7254901961, alpha: 1)
        text.font = UIFont(name: "Pretendard-Bold" , size: 20)
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
        print("model7 : \(dailyScrumModel)")
        print("uid7 : \(uid)" )
        view.backgroundColor = .white
        nextButton.addTarget(self, action: #selector(moveToNext), for: .touchUpInside)
        skipButton.addTarget(self, action: #selector(skipToNext), for: .touchUpInside)
        setUI()
        setupBackButton()
        
        foodButton1.setNeedsUpdateConfiguration()
        foodButton2.setNeedsUpdateConfiguration()
        
        foodButton1.addTarget(self, action: #selector(buttonClicked1(_:)), for: .touchUpInside)
        foodButton2.addTarget(self, action: #selector(buttonClicked2(_:)), for: .touchUpInside)
        
        
      
    }
    
    
    @objc func buttonClicked1(_ sender: UIButton) {
        sender.isSelected.toggle() // 버튼의 선택 상태를 토글
        foodButton2.isSelected = false // 다른 버튼의 선택 상태를 해제
  
        updateButtonConfiguration(button: sender, isSelected: sender.isSelected, text: "국물")
        updateButtonConfiguration(button: foodButton2, isSelected: false, text: "NO 국물")
        if var model = dailyScrumModel {
            model.todaySoup = 1
            model.todayNoSoup = 0
            dailyScrumModel = model
        }
        
        updateNextButtonState()
    }
    
    
    @objc func buttonClicked2(_ sender: UIButton) {
           sender.isSelected.toggle() // 버튼의 선택 상태를 토글
           foodButton1.isSelected = false // 다른 버튼의 선택 상태를 해제
        updateButtonConfiguration(button: foodButton1, isSelected: false, text: "국물")
           updateButtonConfiguration(button: sender, isSelected: sender.isSelected, text: "NO 국물")
        
        if var model = dailyScrumModel {
            model.todaySoup = 0
            model.todayNoSoup = 1
            dailyScrumModel = model
        }
        
        updateNextButtonState()
       }
    
    
    // 버튼 눌렸을때 업데이트
    func updateButtonConfiguration(button: UIButton, isSelected: Bool, text: String) {
        var newConfig = button.configuration
        
        updateNextButtonState()
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

        if text == "국물" {
            if let image = UIImage(named:"soup") {
                newConfig?.image = resizeImage(image: image, targetSize: CGSize(width: 107, height: 71))
            }
        } else if text == "NO 국물" {
            if let image = UIImage(named:"no_soup") {
                newConfig?.image = resizeImage(image: image, targetSize: CGSize(width: 93, height: 54))
            }
        }
        
      
        
        
        
        newConfig?.attributedTitle = attributedText
        button.configuration = newConfig
    }
   
  
    
    func updateNextButtonState() {
            if foodButton1.isSelected || foodButton2.isSelected {
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
    
    
    
    
    @objc func skipToNext(){
        if foodButton1.isSelected == false && foodButton2.isSelected == false {
            let preferVC = DailyFoorofileViewController()
            
            if var model = dailyScrumModel {
                model.todaySoup = 1
                model.todayNoSoup = 1
                dailyScrumModel = model
            }
            
            if let model = dailyScrumModel, let userId = uid {
                makePostRequest(model: model, userId: userId)
            } else {
                print("🍎model : \(dailyScrumModel)")
                print("🍎uid : \(uid) ")
                print("🚨 Error: preferModel or uid is nil")
                return
            }
            
            // 여기에 필요한 데이터를 전달합니다.
            preferVC.uid = self.uid!
            preferVC.name = self.name!
            
            let transition = CATransition()
            transition.duration = 0.4
            transition.type = .push
            transition.subtype = .fromRight
            transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            
            view.window?.layer.add(transition, forKey: kCATransition)
            preferVC.modalPresentationStyle = .fullScreen
            present(preferVC, animated: false, completion: nil)
        }
    }
    
      
    
    
    
    @objc func moveToNext(){
        if foodButton1.isSelected || foodButton2.isSelected {
            let preferVC = DailyFoorofileViewController()
            
            preferVC.uid = self.uid!  // uid 전달
            preferVC.name = self.name!  // name 전달
            let transition = CATransition()
            transition.duration = 0.4
            transition.type = .push
            transition.subtype = .fromRight
            transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            
            // 현재 window에 전환 애니메이션 적용
            view.window?.layer.add(transition, forKey: kCATransition)
            preferVC.modalPresentationStyle = .fullScreen  // 전체 화면으로 설정
            
            
        
            
            
            
            if let model = dailyScrumModel, let userId = uid {
                       makePostRequest(model: model, userId: userId)
                   } else {
                       print("🍎model : \(dailyScrumModel)")
                       print("🍎uid : \(uid) ")
                       print("🚨 Error: preferModel or uid is nil")
                       return
                   }
            
            
            
            
            
            
            
            
            present(preferVC, animated: false, completion: nil)
        }
    }
    
   
    
    
    
    
    
    
    func setUI(){
        view.addSubview(lineImage1)
        view.addSubview(lineImage2)
        view.addSubview(lineImage3)
        view.addSubview(lineImage4)
        view.addSubview(lineImage5)
        view.addSubview(lineImage6)
        view.addSubview(lineImage7)
        
        view.addSubview(titleLabel1)
        view.addSubview(titleLabel2)
        view.addSubview(titleLabel3)
        view.addSubview(titleLabel4)
        view.addSubview(nextButton)
        view.addSubview(skipButton)
        view.addSubview(line)
        
        view.addSubview(foodButton1)
        view.addSubview(foodButton2)
        

        
        NSLayoutConstraint.activate([
            lineImage1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor , constant: 57.4),
            lineImage1.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor , constant: 33),
            lineImage1.widthAnchor.constraint(equalToConstant: 35),
            
            lineImage2.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor , constant: 57.4),
            lineImage2.leadingAnchor.constraint(equalTo: lineImage1.trailingAnchor , constant: 14),
            lineImage2.widthAnchor.constraint(equalToConstant: 35),
            
            lineImage3.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor , constant: 57.4),
            lineImage3.leadingAnchor.constraint(equalTo: lineImage2.trailingAnchor , constant: 14),
            lineImage3.widthAnchor.constraint(equalToConstant: 35),
            
            lineImage4.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor , constant: 57.4),
            lineImage4.leadingAnchor.constraint(equalTo: lineImage3.trailingAnchor , constant: 14),
            lineImage4.widthAnchor.constraint(equalToConstant: 35),
            
            lineImage5.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor , constant: 57.4),
            lineImage5.leadingAnchor.constraint(equalTo: lineImage4.trailingAnchor , constant: 14),
            lineImage5.widthAnchor.constraint(equalToConstant: 35),
            
            lineImage6.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor , constant: 57.4),
            lineImage6.leadingAnchor.constraint(equalTo: lineImage5.trailingAnchor , constant: 14),
            lineImage6.widthAnchor.constraint(equalToConstant: 35),
            
            lineImage7.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor , constant: 57.4),
            lineImage7.leadingAnchor.constraint(equalTo: lineImage6.trailingAnchor , constant: 14),
            lineImage7.widthAnchor.constraint(equalToConstant: 35),
            
            

            titleLabel1.topAnchor.constraint(equalTo: lineImage1.topAnchor , constant: 38),
            titleLabel1.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor , constant: 32),
            
            titleLabel2.topAnchor.constraint(equalTo: lineImage1.topAnchor , constant: 38),
            titleLabel2.leadingAnchor.constraint(equalTo: titleLabel1.trailingAnchor , constant: 0),
            
            titleLabel3.topAnchor.constraint(equalTo: titleLabel1.bottomAnchor , constant: 3),
            titleLabel3.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            
            titleLabel4.topAnchor.constraint(equalTo: titleLabel3.bottomAnchor , constant: 499),
            titleLabel4.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 33.4),
            titleLabel4.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32.6),
            
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
             
            
            foodButton1.topAnchor.constraint(equalTo: titleLabel3.bottomAnchor , constant: 118.1),
            foodButton1.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor , constant: 32),
            foodButton1.widthAnchor.constraint(equalToConstant: 154),
            foodButton1.heightAnchor.constraint(equalToConstant: 147),
            
            foodButton2.topAnchor.constraint(equalTo: titleLabel3.bottomAnchor , constant: 118.1),
            foodButton2.leadingAnchor.constraint(equalTo: foodButton1.trailingAnchor , constant: 21),
            foodButton2.widthAnchor.constraint(equalToConstant: 154),
            foodButton2.heightAnchor.constraint(equalToConstant: 147),
        
           
            
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


//MARK: - 서버 통신
extension PreferViewController7 {
    //POST 하는 함수
    func makePostRequest(model: PreferModel, userId: String) {
        guard let url = URL(string: "https://mumuk.store/daily/\(userId)") else {
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

