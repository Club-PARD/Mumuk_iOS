//
//  OpenPreferViewController1.swift
//  mumuk
//
//  Created by 김민준 on 7/3/24.
//

import UIKit

class OpenPreferViewController1 : UIViewController {
    var uid : String?
    var name : String?
    var okayAll : Int = 0
    var someCheck : Int = 0
    var userId : String?
    
    
    var model: OpenPreferModel = OpenPreferModel( // OpenPreferModel 인스턴스를 빈 값으로 초기화
            exceptionalFoods: [],
            spicyType: false,
            koreanFood: 0,
            westernFood: 0,
            chineseFood: 0,
            japaneseFood: 0,
            southeastAsianFood: 0,
            elseFood: 0,
            foodTypeId: 0
        )

    
   
    
    
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
        lineImage.image = UIImage(named: "grayLine")
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
        label.text = "선호하지 않거나"
        label.font = UIFont(name: "Pretendard-Bold", size: 26)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let titleLabel2 : UILabel = {
        let label = UILabel()
        label.text = "먹지 못하는 음식"
        label.font = UIFont(name: "Pretendard-Bold", size: 26)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let titleLabel3 : UILabel = {
        let label = UILabel()
        label.text = "을"
        label.font = UIFont(name: "Pretendard-Light", size: 26)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let titleLabel4 : UILabel = {
        let label = UILabel()
        label.text = "모두 골라주세요!"
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
    
    
    let hateButton1 : UIButton = {
        var config = UIButton.Configuration.filled()
        config.background.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

    
        var text = AttributedString.init("🐷 내장류")
        text.foregroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        text.font = UIFont(name: "Pretendard-Regular" , size: 15)
        config.attributedTitle = text
        
    
        config.titleAlignment = .center
      
        config.background.strokeColor = #colorLiteral(red: 0.8745098039, green: 0.8745098039, blue: 0.8745098039, alpha: 1)
        config.background.strokeWidth = 1
        config.background.cornerRadius = 50

        
        // config 버튼에 합치기
        let button = UIButton(configuration: config)

        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    
    
    
    
    let hateButton2 : UIButton = {
        var config = UIButton.Configuration.filled()
        config.background.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

    
        var text = AttributedString.init("🍆 가지")
        text.foregroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        text.font = UIFont(name: "Pretendard-Regular" , size: 15)
        config.attributedTitle = text
        
      

        config.titleAlignment = .center
      
        config.background.strokeColor = #colorLiteral(red: 0.8745098039, green: 0.8745098039, blue: 0.8745098039, alpha: 1)
        config.background.strokeWidth = 1
        config.background.cornerRadius = 50

        
        // config 버튼에 합치기
        let button = UIButton(configuration: config)

        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    
    
    let hateButton3 : UIButton = {
        var config = UIButton.Configuration.filled()
        config.background.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

    
        var text = AttributedString.init("🦀 갑각류")
        text.foregroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        text.font = UIFont(name: "Pretendard-Regular" , size: 15)
        config.attributedTitle = text
        
      

        config.titleAlignment = .center
      
        config.background.strokeColor = #colorLiteral(red: 0.8745098039, green: 0.8745098039, blue: 0.8745098039, alpha: 1)
        config.background.strokeWidth = 1
        config.background.cornerRadius = 50

        
        // config 버튼에 합치기
        let button = UIButton(configuration: config)

        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    
    let hateButton4 : UIButton = {
        var config = UIButton.Configuration.filled()
        config.background.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

    
        var text = AttributedString.init("🐟 해산물")
        text.foregroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        text.font = UIFont(name: "Pretendard-Regular" , size: 15)
        config.attributedTitle = text
        
      

        config.titleAlignment = .center
      
        config.background.strokeColor = #colorLiteral(red: 0.8745098039, green: 0.8745098039, blue: 0.8745098039, alpha: 1)
        config.background.strokeWidth = 1
        config.background.cornerRadius = 50

        
        // config 버튼에 합치기
        let button = UIButton(configuration: config)

        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    
    
    let hateButton5 : UIButton = {
        var config = UIButton.Configuration.filled()
        config.background.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

    
        var text = AttributedString.init("🥒 오이")
        text.foregroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        text.font = UIFont(name: "Pretendard-Regular" , size: 15)
        config.attributedTitle = text
        
      

        config.titleAlignment = .center
      
        config.background.strokeColor = #colorLiteral(red: 0.8745098039, green: 0.8745098039, blue: 0.8745098039, alpha: 1)
        config.background.strokeWidth = 1
        config.background.cornerRadius = 50

        
        // config 버튼에 합치기
        let button = UIButton(configuration: config)

        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    let hateButton6 : UIButton = {
        var config = UIButton.Configuration.filled()
        config.background.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

    
        var text = AttributedString.init("🥛 유제품")
        text.foregroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        text.font = UIFont(name: "Pretendard-Regular" , size: 15)
        config.attributedTitle = text
        
      

        config.titleAlignment = .center
      
        config.background.strokeColor = #colorLiteral(red: 0.8745098039, green: 0.8745098039, blue: 0.8745098039, alpha: 1)
        config.background.strokeWidth = 1
        config.background.cornerRadius = 50

        
        // config 버튼에 합치기
        let button = UIButton(configuration: config)

        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    let hateButton7 : UIButton = {
        var config = UIButton.Configuration.filled()
        config.background.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

    
        var text = AttributedString.init("🫚 향신료")
        text.foregroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        text.font = UIFont(name: "Pretendard-Regular" , size: 15)
        config.attributedTitle = text
        
      

        config.titleAlignment = .center
      
        config.background.strokeColor = #colorLiteral(red: 0.8745098039, green: 0.8745098039, blue: 0.8745098039, alpha: 1)
        config.background.strokeWidth = 1
        config.background.cornerRadius = 50

        
        // config 버튼에 합치기
        let button = UIButton(configuration: config)

        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    let hateButton8 : UIButton = {
        var config = UIButton.Configuration.filled()
        config.background.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

    
        var text = AttributedString.init("🦪 조개")
        text.foregroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        text.font = UIFont(name: "Pretendard-Regular" , size: 15)
        config.attributedTitle = text
        
      

        config.titleAlignment = .center
      
        config.background.strokeColor = #colorLiteral(red: 0.8745098039, green: 0.8745098039, blue: 0.8745098039, alpha: 1)
        config.background.strokeWidth = 1
        config.background.cornerRadius = 50

        
        // config 버튼에 합치기
        let button = UIButton(configuration: config)

        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    
    
    let hateButton9 : UIButton = {
        var config = UIButton.Configuration.filled()
        config.background.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

    
        var text = AttributedString.init("🥜 견과류")
        text.foregroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        text.font = UIFont(name: "Pretendard-Regular" , size: 15)
        config.attributedTitle = text
        
      

        config.titleAlignment = .center
      
        config.background.strokeColor = #colorLiteral(red: 0.8745098039, green: 0.8745098039, blue: 0.8745098039, alpha: 1)
        config.background.strokeWidth = 1
        config.background.cornerRadius = 50

        
        // config 버튼에 합치기
        let button = UIButton(configuration: config)

        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    let hateButton10 : UIButton = {
        var config = UIButton.Configuration.filled()
        config.background.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

    
        var text = AttributedString.init("🫘 콩(대두)")
        text.foregroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        text.font = UIFont(name: "Pretendard-Regular" , size: 14)
        config.attributedTitle = text
        
      

        config.titleAlignment = .center
      
        config.background.strokeColor = #colorLiteral(red: 0.8745098039, green: 0.8745098039, blue: 0.8745098039, alpha: 1)
        config.background.strokeWidth = 1
        config.background.cornerRadius = 50

        
        // config 버튼에 합치기
        let button = UIButton(configuration: config)

        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    
    let hateButton11 : UIButton = {
        var config = UIButton.Configuration.filled()
        config.background.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

    
        var text = AttributedString.init("🥚 계란")
        text.foregroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        text.font = UIFont(name: "Pretendard-Regular" , size: 15)
        config.attributedTitle = text
        
      

        config.titleAlignment = .center
      
        config.background.strokeColor = #colorLiteral(red: 0.8745098039, green: 0.8745098039, blue: 0.8745098039, alpha: 1)
        config.background.strokeWidth = 1
        config.background.cornerRadius = 50

        
        // config 버튼에 합치기
        let button = UIButton(configuration: config)

        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    
    let hateButton12 : UIButton = {
        var config = UIButton.Configuration.filled()
        config.background.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

    
        var text = AttributedString.init("🍣 날 것")
        text.foregroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        text.font = UIFont(name: "Pretendard-Regular" , size: 15)
        config.attributedTitle = text
        
      

        config.titleAlignment = .center
      
        config.background.strokeColor = #colorLiteral(red: 0.8745098039, green: 0.8745098039, blue: 0.8745098039, alpha: 1)
        config.background.strokeWidth = 1
        config.background.cornerRadius = 50

        
        // config 버튼에 합치기
        let button = UIButton(configuration: config)

        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    
    let hateButton13 : UIButton = {
        var config = UIButton.Configuration.filled()
        config.background.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

    
        var text = AttributedString.init("🍞 밀가루(글루텐)")
        text.foregroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        text.font = UIFont(name: "Pretendard-Regular" , size: 15)
        config.attributedTitle = text
        
      

        config.titleAlignment = .center
      
        config.background.strokeColor = #colorLiteral(red: 0.8745098039, green: 0.8745098039, blue: 0.8745098039, alpha: 1)
        config.background.strokeWidth = 1
        config.background.cornerRadius = 50

        
        // config 버튼에 합치기
        let button = UIButton(configuration: config)

        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    let hateButton14 : UIButton = {
        var config = UIButton.Configuration.filled()
        config.background.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

    
        var text = AttributedString.init("😋 다 잘 먹어요")
        text.foregroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        text.font = UIFont(name: "Pretendard-Regular" , size: 15)
        config.attributedTitle = text
        
      

        config.titleAlignment = .center
      
        config.background.strokeColor = #colorLiteral(red: 0.8745098039, green: 0.8745098039, blue: 0.8745098039, alpha: 1)
        config.background.strokeWidth = 1
        config.background.cornerRadius = 50

        
        // config 버튼에 합치기
        let button = UIButton(configuration: config)

        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    
    //MARK: - viewDidLoads
    override func viewDidLoad() {
        super.viewDidLoad()
        model.exceptionalFoods = []
        view.backgroundColor = .white
        print(" open uid1 : \(uid)")
        print("open model1 : \(model)")
        
        
        nextButton.addTarget(self, action: #selector(moveToNext), for: .touchUpInside)
        hateButton1.setNeedsUpdateConfiguration()
        hateButton2.setNeedsUpdateConfiguration()
        hateButton3.setNeedsUpdateConfiguration()
        hateButton4.setNeedsUpdateConfiguration()
        hateButton5.setNeedsUpdateConfiguration()
        hateButton6.setNeedsUpdateConfiguration()
        hateButton7.setNeedsUpdateConfiguration()
        hateButton8.setNeedsUpdateConfiguration()
        hateButton9.setNeedsUpdateConfiguration()
        hateButton10.setNeedsUpdateConfiguration()
        hateButton11.setNeedsUpdateConfiguration()
        hateButton12.setNeedsUpdateConfiguration()
        hateButton13.setNeedsUpdateConfiguration()
        hateButton14.setNeedsUpdateConfiguration()
        
     
        
       
                
        
        buttonClicked()
        setupBackButton()
        setUI()
    }
    
    
    
    func buttonClicked(){
        hateButton1.addTarget(self, action: #selector(buttonClicked1(_:)), for: .touchUpInside)
        hateButton2.addTarget(self, action: #selector(buttonClicked2(_:)), for: .touchUpInside)
        hateButton3.addTarget(self, action: #selector(buttonClicked3(_:)), for: .touchUpInside)
        hateButton4.addTarget(self, action: #selector(buttonClicked4(_:)), for: .touchUpInside)
        hateButton5.addTarget(self, action: #selector(buttonClicked5(_:)), for: .touchUpInside)
        hateButton6.addTarget(self, action: #selector(buttonClicked6(_:)), for: .touchUpInside)
        hateButton7.addTarget(self, action: #selector(buttonClicked7(_:)), for: .touchUpInside)
        hateButton8.addTarget(self, action: #selector(buttonClicked8(_:)), for: .touchUpInside)
        hateButton9.addTarget(self, action: #selector(buttonClicked9(_:)), for: .touchUpInside)
        hateButton10.addTarget(self, action: #selector(buttonClicked10(_:)), for: .touchUpInside)
        hateButton11.addTarget(self, action: #selector(buttonClicked11(_:)), for: .touchUpInside)
        hateButton12.addTarget(self, action: #selector(buttonClicked12(_:)), for: .touchUpInside)
        hateButton13.addTarget(self, action: #selector(buttonClicked13(_:)), for: .touchUpInside)
        hateButton14.addTarget(self, action: #selector(buttonClicked14(_:)), for: .touchUpInside)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        hateButton1.setNeedsUpdateConfiguration()
        hateButton1.updateConfiguration()
        hateButton2.setNeedsUpdateConfiguration()
        hateButton2.updateConfiguration()
        hateButton3.setNeedsUpdateConfiguration()
        hateButton3.updateConfiguration()
        hateButton4.setNeedsUpdateConfiguration()
        hateButton4.updateConfiguration()
        hateButton5.setNeedsUpdateConfiguration()
        hateButton5.updateConfiguration()
        hateButton6.setNeedsUpdateConfiguration()
        hateButton6.updateConfiguration()
        hateButton7.setNeedsUpdateConfiguration()
        hateButton7.updateConfiguration()
        hateButton8.setNeedsUpdateConfiguration()
        hateButton8.updateConfiguration()
        hateButton9.setNeedsUpdateConfiguration()
        hateButton9.updateConfiguration()
        hateButton10.setNeedsUpdateConfiguration()
        hateButton10.updateConfiguration()
        hateButton11.setNeedsUpdateConfiguration()
        hateButton11.updateConfiguration()
        hateButton12.setNeedsUpdateConfiguration()
        hateButton12.updateConfiguration()
        hateButton13.setNeedsUpdateConfiguration()
        hateButton13.updateConfiguration()
        hateButton14.setNeedsUpdateConfiguration()
        hateButton14.updateConfiguration()
    }
    
    @objc func buttonClicked1(_ sender: UIButton){
        sender.isSelected.toggle() // 버튼의 선택 상태를 토글
                    
                // 상태에 따른 테두리 색 변경
                if sender.isSelected && okayAll == 0 {
                    var newConfig = sender.configuration
                    
            
                    var text = AttributedString("🐷 내장류")
                    text.foregroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                    text.font = UIFont(name: "Pretendard-Regular", size: 15)
                    newConfig?.attributedTitle = text
                    newConfig?.background.backgroundColor = #colorLiteral(red: 0.9469566941, green: 0.6374832988, blue: 0.2344205678, alpha: 1) // 선택된 상태의 배경 색
                    newConfig?.background.strokeColor = #colorLiteral(red: 0.9469566941, green: 0.6374832988, blue: 0.2344205678, alpha: 1) // 선택된 상태의 테두리 색
                    sender.configuration = newConfig
          
                    someCheck = 1
                } else {
                    var newConfig = sender.configuration

            
                    var text = AttributedString("🐷 내장류")
                    text.foregroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                    text.font = UIFont(name: "Pretendard-Regular", size: 15)
                    newConfig?.attributedTitle = text
                    newConfig?.background.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) // 선택된 상태의 배경 색
                    newConfig?.background.strokeColor = #colorLiteral(red: 0.8745098039, green: 0.8745098039, blue: 0.8745098039, alpha: 1) // 선택된 상태의 테두리 색
                    sender.configuration = newConfig
                    
                    someCheck = 0
                }

                // 버튼 상태 업데이트 요청
                sender.setNeedsUpdateConfiguration()
        
    }
    
    @objc func buttonClicked2(_ sender: UIButton){
        sender.isSelected.toggle() // 버튼의 선택 상태를 토글

                // 상태에 따른 테두리 색 변경
                if sender.isSelected && okayAll == 0  {
                    var newConfig = sender.configuration

            
                    var text = AttributedString("🍆 가지")
                    text.foregroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                    text.font = UIFont(name: "Pretendard-Regular", size: 15)
                    newConfig?.attributedTitle = text
                    newConfig?.background.backgroundColor = #colorLiteral(red: 0.9469566941, green: 0.6374832988, blue: 0.2344205678, alpha: 1) // 선택된 상태의 배경 색
                    newConfig?.background.strokeColor = #colorLiteral(red: 0.9469566941, green: 0.6374832988, blue: 0.2344205678, alpha: 1) // 선택된 상태의 테두리 색
                    sender.configuration = newConfig
                    someCheck = 1
               
                    
                } else {
                    var newConfig = sender.configuration

            
                    var text = AttributedString("🍆 가지")
                    text.foregroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                    text.font = UIFont(name: "Pretendard-Regular", size: 15)
                    newConfig?.attributedTitle = text
                    newConfig?.background.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) // 선택된 상태의 배경 색
                    newConfig?.background.strokeColor = #colorLiteral(red: 0.8745098039, green: 0.8745098039, blue: 0.8745098039, alpha: 1) // 선택된 상태의 테두리 색
                    sender.configuration = newConfig
                    someCheck = 0
                    
                }

                // 버튼 상태 업데이트 요청
                sender.setNeedsUpdateConfiguration()
        
    }
    
    
    
    @objc func buttonClicked3(_ sender: UIButton){
        sender.isSelected.toggle() // 버튼의 선택 상태를 토글

                // 상태에 따른 테두리 색 변경
                if sender.isSelected && okayAll == 0 {
                    var newConfig = sender.configuration

            
                    var text = AttributedString("🦀 갑각류")
                    text.foregroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                    text.font = UIFont(name: "Pretendard-Regular", size: 15)
                    newConfig?.attributedTitle = text
                    newConfig?.background.backgroundColor = #colorLiteral(red: 0.9469566941, green: 0.6374832988, blue: 0.2344205678, alpha: 1) // 선택된 상태의 배경 색
                    newConfig?.background.strokeColor = #colorLiteral(red: 0.9469566941, green: 0.6374832988, blue: 0.2344205678, alpha: 1) // 선택된 상태의 테두리 색
                    sender.configuration = newConfig
                    someCheck = 1
              
                } else {
                    var newConfig = sender.configuration

            
                    var text = AttributedString("🦀 갑각류")
                    text.foregroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                    text.font = UIFont(name: "Pretendard-Regular", size: 15)
                    newConfig?.attributedTitle = text
                    newConfig?.background.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) // 선택된 상태의 배경 색
                    newConfig?.background.strokeColor = #colorLiteral(red: 0.8745098039, green: 0.8745098039, blue: 0.8745098039, alpha: 1) // 선택된 상태의 테두리 색
                    sender.configuration = newConfig
                    someCheck = 0
                    
                }

                // 버튼 상태 업데이트 요청
                sender.setNeedsUpdateConfiguration()
        
    }
    
    
    
    
    @objc func buttonClicked4(_ sender: UIButton){
        sender.isSelected.toggle() // 버튼의 선택 상태를 토글

                // 상태에 따른 테두리 색 변경
                if sender.isSelected && okayAll == 0 {
                    var newConfig = sender.configuration

            
                    var text = AttributedString("🐟 해산물")
                    text.foregroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                    text.font = UIFont(name: "Pretendard-Regular", size: 15)
                    newConfig?.attributedTitle = text
                    newConfig?.background.backgroundColor = #colorLiteral(red: 0.9469566941, green: 0.6374832988, blue: 0.2344205678, alpha: 1) // 선택된 상태의 배경 색
                    newConfig?.background.strokeColor = #colorLiteral(red: 0.9469566941, green: 0.6374832988, blue: 0.2344205678, alpha: 1) // 선택된 상태의 테두리 색
                    sender.configuration = newConfig
                    
              

                    someCheck = 1
                } else {
                    var newConfig = sender.configuration

            
                    var text = AttributedString("🐟 해산물")
                    text.foregroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                    text.font = UIFont(name: "Pretendard-Regular", size: 15)
                    newConfig?.attributedTitle = text
                    newConfig?.background.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) // 선택된 상태의 배경 색
                    newConfig?.background.strokeColor = #colorLiteral(red: 0.8745098039, green: 0.8745098039, blue: 0.8745098039, alpha: 1) // 선택된 상태의 테두리 색
                    sender.configuration = newConfig
                    someCheck = 0
                    
                }

                // 버튼 상태 업데이트 요청
                sender.setNeedsUpdateConfiguration()
        
    }
    
    @objc func buttonClicked5(_ sender: UIButton){
        sender.isSelected.toggle() // 버튼의 선택 상태를 토글

                // 상태에 따른 테두리 색 변경
                if sender.isSelected {
                    var newConfig = sender.configuration

            
                    var text = AttributedString("🥒 오이")
                    text.foregroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                    text.font = UIFont(name: "Pretendard-Regular", size: 15)
                    newConfig?.attributedTitle = text
                    newConfig?.background.backgroundColor = #colorLiteral(red: 0.9469566941, green: 0.6374832988, blue: 0.2344205678, alpha: 1) // 선택된 상태의 배경 색
                    newConfig?.background.strokeColor = #colorLiteral(red: 0.9469566941, green: 0.6374832988, blue: 0.2344205678, alpha: 1) // 선택된 상태의 테두리 색
                    sender.configuration = newConfig
                    
                 

                    
                    someCheck = 1
                } else {
                    var newConfig = sender.configuration

            
                    var text = AttributedString("🥒 오이")
                    text.foregroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                    text.font = UIFont(name: "Pretendard-Regular", size: 15)
                    newConfig?.attributedTitle = text
                    newConfig?.background.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) // 선택된 상태의 배경 색
                    newConfig?.background.strokeColor = #colorLiteral(red: 0.8745098039, green: 0.8745098039, blue: 0.8745098039, alpha: 1) // 선택된 상태의 테두리 색
                    sender.configuration = newConfig
                    someCheck = 0
                    
                }

                // 버튼 상태 업데이트 요청
                sender.setNeedsUpdateConfiguration()
        
    }
    
    @objc func buttonClicked6(_ sender: UIButton){
        sender.isSelected.toggle() // 버튼의 선택 상태를 토글

                // 상태에 따른 테두리 색 변경
                if sender.isSelected && okayAll == 0  {
                    var newConfig = sender.configuration

            
                    var text = AttributedString("🥛 유제품")
                    text.foregroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                    text.font = UIFont(name: "Pretendard-Regular", size: 15)
                    newConfig?.attributedTitle = text
                    newConfig?.background.backgroundColor = #colorLiteral(red: 0.9469566941, green: 0.6374832988, blue: 0.2344205678, alpha: 1) // 선택된 상태의 배경 색
                    newConfig?.background.strokeColor = #colorLiteral(red: 0.9469566941, green: 0.6374832988, blue: 0.2344205678, alpha: 1) // 선택된 상태의 테두리 색
                    sender.configuration = newConfig
                    someCheck = 1
                    
              

                } else {
                    var newConfig = sender.configuration

            
                    var text = AttributedString("🥛 유제품")
                    text.foregroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                    text.font = UIFont(name: "Pretendard-Regular", size: 15)
                    newConfig?.attributedTitle = text
                    newConfig?.background.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) // 선택된 상태의 배경 색
                    newConfig?.background.strokeColor = #colorLiteral(red: 0.8745098039, green: 0.8745098039, blue: 0.8745098039, alpha: 1) // 선택된 상태의 테두리 색
                    sender.configuration = newConfig
                    
                    someCheck = 0
                }

                // 버튼 상태 업데이트 요청
                sender.setNeedsUpdateConfiguration()
        
    }
    
    
    @objc func buttonClicked7(_ sender: UIButton){
        sender.isSelected.toggle() // 버튼의 선택 상태를 토글

                // 상태에 따른 테두리 색 변경
                if sender.isSelected  && okayAll == 0 {
                    var newConfig = sender.configuration

            
                    var text = AttributedString("🫚 향신료")
                    text.foregroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                    text.font = UIFont(name: "Pretendard-Regular", size: 15)
                    newConfig?.attributedTitle = text
                    newConfig?.background.backgroundColor = #colorLiteral(red: 0.9469566941, green: 0.6374832988, blue: 0.2344205678, alpha: 1) // 선택된 상태의 배경 색
                    newConfig?.background.strokeColor = #colorLiteral(red: 0.9469566941, green: 0.6374832988, blue: 0.2344205678, alpha: 1) // 선택된 상태의 테두리 색
                    sender.configuration = newConfig
               

                    someCheck = 1
                } else {
                    var newConfig = sender.configuration

            
                    var text = AttributedString("🫚 향신료")
                    text.foregroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                    text.font = UIFont(name: "Pretendard-Regular", size: 15)
                    newConfig?.attributedTitle = text
                    newConfig?.background.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) // 선택된 상태의 배경 색
                    newConfig?.background.strokeColor = #colorLiteral(red: 0.8745098039, green: 0.8745098039, blue: 0.8745098039, alpha: 1) // 선택된 상태의 테두리 색
                    sender.configuration = newConfig
                    
                    someCheck = 0
                }

                // 버튼 상태 업데이트 요청
                sender.setNeedsUpdateConfiguration()
        
    }
    
    
    @objc func buttonClicked8(_ sender: UIButton){
        sender.isSelected.toggle() // 버튼의 선택 상태를 토글

                // 상태에 따른 테두리 색 변경
                if sender.isSelected && okayAll == 0  {
                    var newConfig = sender.configuration

            
                    var text = AttributedString("🦪 조개")
                    text.foregroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                    text.font = UIFont(name: "Pretendard-Regular", size: 15)
                    newConfig?.attributedTitle = text
                    newConfig?.background.backgroundColor = #colorLiteral(red: 0.9469566941, green: 0.6374832988, blue: 0.2344205678, alpha: 1) // 선택된 상태의 배경 색
                    newConfig?.background.strokeColor = #colorLiteral(red: 0.9469566941, green: 0.6374832988, blue: 0.2344205678, alpha: 1) // 선택된 상태의 테두리 색
                    sender.configuration = newConfig
                    someCheck = 1
                    
              

                } else {
                    var newConfig = sender.configuration

            
                    var text = AttributedString("🦪 조개")
                    text.foregroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                    text.font = UIFont(name: "Pretendard-Regular", size: 15)
                    newConfig?.attributedTitle = text
                    newConfig?.background.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) // 선택된 상태의 배경 색
                    newConfig?.background.strokeColor = #colorLiteral(red: 0.8745098039, green: 0.8745098039, blue: 0.8745098039, alpha: 1) // 선택된 상태의 테두리 색
                    sender.configuration = newConfig
                    
        
                }

                // 버튼 상태 업데이트 요청
                sender.setNeedsUpdateConfiguration()
        
    }
    
    
    @objc func buttonClicked9(_ sender: UIButton){
        sender.isSelected.toggle() // 버튼의 선택 상태를 토글

                // 상태에 따른 테두리 색 변경
                if sender.isSelected  && okayAll == 0 {
                    var newConfig = sender.configuration

            
                    var text = AttributedString("🥜 견과류")
                    text.foregroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                    text.font = UIFont(name: "Pretendard-Regular", size: 15)
                    newConfig?.attributedTitle = text
                    newConfig?.background.backgroundColor = #colorLiteral(red: 0.9469566941, green: 0.6374832988, blue: 0.2344205678, alpha: 1) // 선택된 상태의 배경 색
                    newConfig?.background.strokeColor = #colorLiteral(red: 0.9469566941, green: 0.6374832988, blue: 0.2344205678, alpha: 1) // 선택된 상태의 테두리 색
                    sender.configuration = newConfig
                    
               

                    someCheck = 1
                } else {
                    var newConfig = sender.configuration

            
                    var text = AttributedString("🥜 견과류")
                    text.foregroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                    text.font = UIFont(name: "Pretendard-Regular", size: 15)
                    newConfig?.attributedTitle = text
                    newConfig?.background.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) // 선택된 상태의 배경 색
                    newConfig?.background.strokeColor = #colorLiteral(red: 0.8745098039, green: 0.8745098039, blue: 0.8745098039, alpha: 1) // 선택된 상태의 테두리 색
                    sender.configuration = newConfig
                    
                    someCheck = 0
                }

                // 버튼 상태 업데이트 요청
                sender.setNeedsUpdateConfiguration()
        
    }
    
    @objc func buttonClicked10(_ sender: UIButton){
        sender.isSelected.toggle() // 버튼의 선택 상태를 토글

                // 상태에 따른 테두리 색 변경
                if sender.isSelected  && okayAll == 0 {
                    var newConfig = sender.configuration

            
                    var text = AttributedString("🫘 콩(대두)")
                    text.foregroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                    text.font = UIFont(name: "Pretendard-Regular", size: 15)
                    newConfig?.attributedTitle = text
                    newConfig?.background.backgroundColor = #colorLiteral(red: 0.9469566941, green: 0.6374832988, blue: 0.2344205678, alpha: 1) // 선택된 상태의 배경 색
                    newConfig?.background.strokeColor = #colorLiteral(red: 0.9469566941, green: 0.6374832988, blue: 0.2344205678, alpha: 1) // 선택된 상태의 테두리 색
                    sender.configuration = newConfig
                    
               
                    someCheck = 1
                } else {
                    var newConfig = sender.configuration

            
                    var text = AttributedString("🫘 콩(대두)")
                    text.foregroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                    text.font = UIFont(name: "Pretendard-Regular", size: 15)
                    newConfig?.attributedTitle = text
                    newConfig?.background.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) // 선택된 상태의 배경 색
                    newConfig?.background.strokeColor = #colorLiteral(red: 0.8745098039, green: 0.8745098039, blue: 0.8745098039, alpha: 1) // 선택된 상태의 테두리 색
                    sender.configuration = newConfig
                    
                    someCheck = 0
                }

                // 버튼 상태 업데이트 요청
                sender.setNeedsUpdateConfiguration()
        
    }
    
    @objc func buttonClicked11(_ sender: UIButton){
        sender.isSelected.toggle() // 버튼의 선택 상태를 토글

                // 상태에 따른 테두리 색 변경
                if sender.isSelected  && okayAll == 0 {
                    var newConfig = sender.configuration

            
                    var text = AttributedString("🥚 계란")
                    text.foregroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                    text.font = UIFont(name: "Pretendard-Regular", size: 15)
                    newConfig?.attributedTitle = text
                    newConfig?.background.backgroundColor = #colorLiteral(red: 0.9469566941, green: 0.6374832988, blue: 0.2344205678, alpha: 1) // 선택된 상태의 배경 색
                    newConfig?.background.strokeColor = #colorLiteral(red: 0.9469566941, green: 0.6374832988, blue: 0.2344205678, alpha: 1) // 선택된 상태의 테두리 색
                    sender.configuration = newConfig
                    
                    
                  
                    someCheck = 1
                } else {
                    var newConfig = sender.configuration

            
                    var text = AttributedString("🥚 계란")
                    text.foregroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                    text.font = UIFont(name: "Pretendard-Regular", size: 15)
                    newConfig?.attributedTitle = text
                    newConfig?.background.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) // 선택된 상태의 배경 색
                    newConfig?.background.strokeColor = #colorLiteral(red: 0.8745098039, green: 0.8745098039, blue: 0.8745098039, alpha: 1) // 선택된 상태의 테두리 색
                    sender.configuration = newConfig
                    
                    someCheck = 0
                }

                // 버튼 상태 업데이트 요청
                sender.setNeedsUpdateConfiguration()
        
    }
    
    @objc func buttonClicked12(_ sender: UIButton){
        sender.isSelected.toggle() // 버튼의 선택 상태를 토글

                // 상태에 따른 테두리 색 변경
                if sender.isSelected  && okayAll == 0 {
                    var newConfig = sender.configuration

            
                    var text = AttributedString("🍣 날 것")
                    text.foregroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                    text.font = UIFont(name: "Pretendard-Regular", size: 15)
                    newConfig?.attributedTitle = text
                    newConfig?.background.backgroundColor = #colorLiteral(red: 0.9469566941, green: 0.6374832988, blue: 0.2344205678, alpha: 1) // 선택된 상태의 배경 색
                    newConfig?.background.strokeColor = #colorLiteral(red: 0.9469566941, green: 0.6374832988, blue: 0.2344205678, alpha: 1) // 선택된 상태의 테두리 색
                    sender.configuration = newConfig
                    
                    someCheck = 1
                } else {
                    var newConfig = sender.configuration

            
                    var text = AttributedString("🍣 날 것")
                    text.foregroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                    text.font = UIFont(name: "Pretendard-Regular", size: 15)
                    newConfig?.attributedTitle = text
                    newConfig?.background.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) // 선택된 상태의 배경 색
                    newConfig?.background.strokeColor = #colorLiteral(red: 0.8745098039, green: 0.8745098039, blue: 0.8745098039, alpha: 1) // 선택된 상태의 테두리 색
                    sender.configuration = newConfig
                    
                    someCheck = 0
                    
                }

                // 버튼 상태 업데이트 요청
                sender.setNeedsUpdateConfiguration()
        
    }
    
    @objc func buttonClicked13(_ sender: UIButton){
        sender.isSelected.toggle() // 버튼의 선택 상태를 토글

                // 상태에 따른 테두리 색 변경
                if sender.isSelected  && okayAll == 0 {
                    var newConfig = sender.configuration

            
                    var text = AttributedString("🍞 밀가루(글루텐)")
                    text.foregroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                    text.font = UIFont(name: "Pretendard-Regular", size: 15)
                    newConfig?.attributedTitle = text
                    newConfig?.background.backgroundColor = #colorLiteral(red: 0.9469566941, green: 0.6374832988, blue: 0.2344205678, alpha: 1) // 선택된 상태의 배경 색
                    newConfig?.background.strokeColor = #colorLiteral(red: 0.9469566941, green: 0.6374832988, blue: 0.2344205678, alpha: 1) // 선택된 상태의 테두리 색
                    sender.configuration = newConfig
                    
                    if !model.exceptionalFoods.contains("13") {
                        model.exceptionalFoods.append("13")
                    }

                    someCheck = 1
                } else {
                    var newConfig = sender.configuration

            
                    var text = AttributedString("🍞 밀가루(글루텐)")
                    text.foregroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                    text.font = UIFont(name: "Pretendard-Regular", size: 15)
                    newConfig?.attributedTitle = text
                    newConfig?.background.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) // 선택된 상태의 배경 색
                    newConfig?.background.strokeColor = #colorLiteral(red: 0.8745098039, green: 0.8745098039, blue: 0.8745098039, alpha: 1) // 선택된 상태의 테두리 색
                    sender.configuration = newConfig
                    
                    someCheck = 0
                }

                // 버튼 상태 업데이트 요청
                sender.setNeedsUpdateConfiguration()
        
    }
    
    @objc func buttonClicked14(_ sender: UIButton){
        sender.isSelected.toggle() // 버튼의 선택 상태를 토글

                // 상태에 따른 테두리 색 변경
                if sender.isSelected && someCheck == 0 {
                    var newConfig = sender.configuration

            
                    var text = AttributedString("😋 다 잘 먹어요")
                    text.foregroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                    text.font = UIFont(name: "Pretendard-Regular", size: 15)
                    newConfig?.attributedTitle = text
                    newConfig?.background.backgroundColor = #colorLiteral(red: 0.9469566941, green: 0.6374832988, blue: 0.2344205678, alpha: 1) // 선택된 상태의 배경 색
                    newConfig?.background.strokeColor = #colorLiteral(red: 0.9469566941, green: 0.6374832988, blue: 0.2344205678, alpha: 1) // 선택된 상태의 테두리 색
                    sender.configuration = newConfig
                    
                    if !model.exceptionalFoods.contains("14") {
                        model.exceptionalFoods.append("14")
                    }
                    okayAll = 1
                } else {
                    var newConfig = sender.configuration

            
                    var text = AttributedString("😋 다 잘 먹어요")
                    text.foregroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                    text.font = UIFont(name: "Pretendard-Regular", size: 15)
                    newConfig?.attributedTitle = text
                    newConfig?.background.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) // 선택된 상태의 배경 색
                    newConfig?.background.strokeColor = #colorLiteral(red: 0.8745098039, green: 0.8745098039, blue: 0.8745098039, alpha: 1) // 선택된 상태의 테두리 색
                    sender.configuration = newConfig
                    
                    okayAll = 0
                }

                // 버튼 상태 업데이트 요청
                sender.setNeedsUpdateConfiguration()
        
    }
    
    @objc func moveToNext(){
        if  hateButton1.isSelected || hateButton2.isSelected || hateButton3.isSelected || hateButton4.isSelected || hateButton5.isSelected || hateButton6.isSelected || hateButton7.isSelected || hateButton8.isSelected || hateButton9.isSelected || hateButton10.isSelected || hateButton11.isSelected || hateButton12.isSelected || hateButton13.isSelected || hateButton14.isSelected {
            
            let preferVC = OpenPreferViewController2()
            
            valueCount()
            preferVC.uid = self.uid
            preferVC.name = self.name  
            
            preferVC.preferModel = self.model
            
            
        
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
        
        view.addSubview(hateButton1)
        view.addSubview(hateButton2)
        view.addSubview(hateButton3)
        view.addSubview(hateButton4)
        view.addSubview(hateButton5)
        view.addSubview(hateButton6)
        view.addSubview(hateButton7)
        view.addSubview(hateButton8)
        view.addSubview(hateButton9)
        view.addSubview(hateButton10)
        view.addSubview(hateButton11)
        view.addSubview(hateButton12)
        view.addSubview(hateButton13)
        view.addSubview(hateButton14)
        
        
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
            
            titleLabel2.topAnchor.constraint(equalTo: titleLabel1.bottomAnchor , constant: 3),
            titleLabel2.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor , constant: 32),
            
            titleLabel3.topAnchor.constraint(equalTo: titleLabel1.bottomAnchor , constant: 3),
            titleLabel3.leadingAnchor.constraint(equalTo:titleLabel2.trailingAnchor , constant:0),
        
            titleLabel4.topAnchor.constraint(equalTo: titleLabel2.bottomAnchor, constant: 3),
            titleLabel4.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            
            titleLabel5.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -20),
            titleLabel5.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor , constant: 58.4),
            
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -13.7),
            nextButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32.4),
            nextButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -31.6),
            nextButton.heightAnchor.constraint(equalToConstant: 48),
            
            
            hateButton1.topAnchor.constraint(equalTo: titleLabel4.bottomAnchor , constant: 38),
            hateButton1.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            hateButton1.widthAnchor.constraint(equalToConstant: 92),
            hateButton1.heightAnchor.constraint(equalToConstant: 42),
            
            
            
            hateButton2.topAnchor.constraint(equalTo: titleLabel4.bottomAnchor , constant: 38),
            hateButton2.leadingAnchor.constraint(equalTo: hateButton1.trailingAnchor, constant: 14),
            hateButton2.widthAnchor.constraint(equalToConstant: 80),
            hateButton2.heightAnchor.constraint(equalToConstant: 40),
            
            
            hateButton3.topAnchor.constraint(equalTo: titleLabel4.bottomAnchor , constant: 38),
            hateButton3.leadingAnchor.constraint(equalTo: hateButton2.trailingAnchor, constant: 14),
            hateButton3.widthAnchor.constraint(equalToConstant: 92),
            hateButton3.heightAnchor.constraint(equalToConstant: 40),
            
            
            hateButton4.topAnchor.constraint(equalTo: hateButton1.bottomAnchor , constant: 13),
            hateButton4.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            hateButton4.widthAnchor.constraint(equalToConstant: 92),
            hateButton4.heightAnchor.constraint(equalToConstant: 40),
            
            hateButton5.topAnchor.constraint(equalTo: hateButton1.bottomAnchor , constant: 13),
            hateButton5.leadingAnchor.constraint(equalTo: hateButton4.trailingAnchor, constant: 14),
            hateButton5.widthAnchor.constraint(equalToConstant: 80),
            hateButton5.heightAnchor.constraint(equalToConstant: 40),
            
            
            hateButton6.topAnchor.constraint(equalTo: hateButton1.bottomAnchor , constant: 13),
            hateButton6.leadingAnchor.constraint(equalTo: hateButton5.trailingAnchor, constant: 14),
            hateButton6.widthAnchor.constraint(equalToConstant: 92),
            hateButton6.heightAnchor.constraint(equalToConstant: 40),
            
            hateButton7.topAnchor.constraint(equalTo: hateButton4.bottomAnchor , constant: 13),
            hateButton7.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            hateButton7.widthAnchor.constraint(equalToConstant: 92),
            hateButton7.heightAnchor.constraint(equalToConstant: 40),
            
            hateButton8.topAnchor.constraint(equalTo: hateButton4.bottomAnchor , constant: 13),
            hateButton8.leadingAnchor.constraint(equalTo: hateButton7.trailingAnchor, constant: 14),
            hateButton8.widthAnchor.constraint(equalToConstant: 80),
            hateButton8.heightAnchor.constraint(equalToConstant: 40),
            
            hateButton9.topAnchor.constraint(equalTo: hateButton4.bottomAnchor , constant: 13),
            hateButton9.leadingAnchor.constraint(equalTo: hateButton8.trailingAnchor, constant: 14),
            hateButton9.widthAnchor.constraint(equalToConstant: 92),
            hateButton9.heightAnchor.constraint(equalToConstant: 40),
            
            hateButton10.topAnchor.constraint(equalTo: hateButton7.bottomAnchor , constant: 13),
            hateButton10.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            
            hateButton10.heightAnchor.constraint(equalToConstant: 40),
            
            hateButton11.topAnchor.constraint(equalTo: hateButton7.bottomAnchor , constant: 13),
            hateButton11.leadingAnchor.constraint(equalTo: hateButton10.trailingAnchor, constant: 14),
            hateButton11.widthAnchor.constraint(equalToConstant: 80),
            hateButton11.heightAnchor.constraint(equalToConstant: 40),
            
            hateButton12.topAnchor.constraint(equalTo: hateButton7.bottomAnchor , constant: 13),
            hateButton12.leadingAnchor.constraint(equalTo: hateButton11.trailingAnchor, constant: 14),
            hateButton12.widthAnchor.constraint(equalToConstant: 92),
            hateButton12.heightAnchor.constraint(equalToConstant: 40),
            
            hateButton13.topAnchor.constraint(equalTo: hateButton10.bottomAnchor , constant: 13),
            hateButton13.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
//            hateButton13.widthAnchor.constraint(equalToConstant: 134),
            hateButton13.heightAnchor.constraint(equalToConstant: 40),
            
            hateButton14.topAnchor.constraint(equalTo: hateButton10.bottomAnchor , constant: 13),
            hateButton14.leadingAnchor.constraint(equalTo: hateButton13.trailingAnchor, constant: 14),
//            hateButton14.widthAnchor.constraint(equalToConstant: 119),
            hateButton14.heightAnchor.constraint(equalToConstant: 40),
            
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
    
    func valueCount(){
    
            
            if hateButton1.isSelected{
                if !model.exceptionalFoods.contains("1"){
                    model.exceptionalFoods.append("1")
                }
            }else{
                model.exceptionalFoods.removeAll { $0 == "1" }
            }
        

        
        if hateButton2.isSelected{
            if !model.exceptionalFoods.contains("2"){
                model.exceptionalFoods.append("2")
            }
        }else{
            model.exceptionalFoods.removeAll { $0 == "2" }
        }
    
        if hateButton3.isSelected{
            if !model.exceptionalFoods.contains("3"){
                model.exceptionalFoods.append("3")
            }
        }else{
            model.exceptionalFoods.removeAll { $0 == "3" }
        }
    
        
        if hateButton4.isSelected{
            if !model.exceptionalFoods.contains("4"){
                model.exceptionalFoods.append("4")
            }
        }else{
            model.exceptionalFoods.removeAll { $0 == "4" }
        }
    
        
        if hateButton5.isSelected{
            if !model.exceptionalFoods.contains("5"){
                model.exceptionalFoods.append("5")
            }
        }else{
            model.exceptionalFoods.removeAll { $0 == "5" }
        }
    
        
        if hateButton6.isSelected{
            if !model.exceptionalFoods.contains("6"){
                model.exceptionalFoods.append("6")
            }
        }else{
            model.exceptionalFoods.removeAll { $0 == "6" }
        }
    
        
        if hateButton1.isSelected{
            if !model.exceptionalFoods.contains("7"){
                model.exceptionalFoods.append("7")
            }
        }else{
            model.exceptionalFoods.removeAll { $0 == "7" }
        }
    
        
        if hateButton8.isSelected{
            if !model.exceptionalFoods.contains("8"){
                model.exceptionalFoods.append("8")
            }
        }else{
            model.exceptionalFoods.removeAll { $0 == "8" }
        }
    
        
        if hateButton9.isSelected{
            if !model.exceptionalFoods.contains("9"){
                model.exceptionalFoods.append("9")
            }
        }else{
            model.exceptionalFoods.removeAll { $0 == "9" }
        }
    
        
        if hateButton10.isSelected{
            if !model.exceptionalFoods.contains("10"){
                model.exceptionalFoods.append("10")
            }
        }else{
            model.exceptionalFoods.removeAll { $0 == "10" }
        }
    
        
        if hateButton11.isSelected{
            if !model.exceptionalFoods.contains("11"){
                model.exceptionalFoods.append("11")
            }
        }else{
            model.exceptionalFoods.removeAll { $0 == "11" }
        }
    
        
        if hateButton12.isSelected{
            if !model.exceptionalFoods.contains("12"){
                model.exceptionalFoods.append("12")
            }
        }else{
            model.exceptionalFoods.removeAll { $0 == "12" }
        }
    
        if hateButton13.isSelected{
            if !model.exceptionalFoods.contains("13"){
                model.exceptionalFoods.append("13")
            }
        }else{
            model.exceptionalFoods.removeAll { $0 == "13" }
        }
        if hateButton14.isSelected{
            if !model.exceptionalFoods.contains("14"){
                model.exceptionalFoods.append("14")
            }
        }else{
            model.exceptionalFoods.removeAll { $0 == "14" }
        }
    
      
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



