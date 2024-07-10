//
//  Openprofile.swift
//  mumuk
//
//  Created by 김민준 on 7/9/24.
//



import UIKit

class Openprofile : UIViewController {
    //MARK: - 컴포넌트
    var selectedIndex : Int = 0
    var label : String = ""        //foodtype
    var name : String = ""
    var tags: [String] = []    // 언더라인 태그
    var daily: [String] = [] // 오늘 내 입맛은?
    var yesterdayFood: String = ""  // 어제 먹은 음식은
    var spicyType: Bool = false
    var uid : String = ""
    
    
    func firstProfile() {
        print("상세 데이터 불러오기 시작")
        print("Name: \(name)")
        
        guard let url = URL(string: "https://mumuk.store/with-pref/\(name)") else {
            print("🚨🚨🚨 Invalid URL")
            return
        }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                print("🚨🚨🚨 Network error:", error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("🚨🚨🚨 Invalid response")
                return
            }
            
            print("HTTP Status Code: \(httpResponse.statusCode)")
            
            guard let JSONdata = data else {
                print("🚨🚨🚨 No data received")
                return
            }
            
            let dataString = String(data: JSONdata, encoding: .utf8)
            print("Received data: \(dataString ?? "Unable to convert data to string")")
            
            let decoder = JSONDecoder()
            do {
                let decodeData = try decoder.decode(UserPreference.self, from: JSONdata)
                DispatchQueue.main.async {
                    self.configureViewFromData(decodeData)
                    self.updateUI()
                }
            } catch {
                print("🚨🚨🚨 Decoding error:", error)
                if let decodingError = error as? DecodingError {
                    switch decodingError {
                    case .dataCorrupted(let context):
                        print("Data corrupted: \(context.debugDescription)")
                        print("Coding path: \(context.codingPath)")
                    case .keyNotFound(let key, let context):
                        print("Key not found: \(key.stringValue) in path \(context.codingPath)")
                    case .typeMismatch(let type, let context):
                        print("Type mismatch: expected \(type) in path \(context.codingPath)")
                    case .valueNotFound(let type, let context):
                        print("Value not found: expected \(type) in path \(context.codingPath)")
                    @unknown default:
                        print("Unknown decoding error")
                    }
                }
            }
        }
        task.resume()
    }

    func configureViewFromData(_ data: UserPreference) {
        self.name = data.name
        self.selectedIndex = data.imageId
        
        // ModelData에서 friend.imageId 값에 해당하는 이미지 찾기
        if let model = Model.ModelData.first(where: { $0.number == self.selectedIndex }) {
            userImage.image = UIImage(named: model.image)
        } else {
            userImage.image = nil // 적절한 기본 이미지를 설정할 수 있음
        }
        
        switch data.foodType {
        case "다이어트": self.label = "💪🏻 다이어트"
        case "할랄": self.label = "🐷🚫 할랄"
        case "비건": self.label = "🥦 비건"
        default: self.label = "🚫 특이사항없음"
        }
        
        self.tags.removeAll()
        self.tags.append(data.spicyType ? "#맵고수" : "#맵찔이")
        
        let foodEmojis = [
            "가지": "#가지 NO", "내장류": "#내장류 NO", "갑각류": "#갑각류 NO", "해산물": "#해산물",
            "오이": "#오이 NO", "유제품": "#유제품 NO", "향신료": "#향신료 NO", "조개": "#조개 NO",
            "견과류": "#견과류 NO", "#콩/대두 NO": "#콩(대두) NO", "계란": "#계란 NO", "날 것": "#날 것 NO",
            "밀가루(글루텐)": "#밀가루(글루텐) NO", "다 잘 먹어요": "#다 잘 먹어요"
        ]
        for food in data.exceptionalFoods {
            if let emoji = foodEmojis[food] {
                self.tags.append(emoji)
            }
        }
        
        self.yesterdayFood = data.notToday ?? "???"
        self.daily.removeAll()
        
        if data.daily {
            
            let foodTypes = [
                (data.todayKoreanFood, "🇰🇷 한식"), (data.todayJapaneseFood, "🇯🇵 일식"),
                (data.todayChineseFood, "🇨🇳 중식"), (data.todayWesternFood, "🇮🇹 양식"),
                (data.todaySoutheastAsianFood, "🇹🇭 동남아"), (data.todayElseFood, "🇮🇳 기타"),
                (data.todayMeat, "🥩 육류"), (data.todaySeafood, "🐟 해산물"),
                (data.todayCarbohydrate, "🍚 탄수화물"), (data.todayVegetable, "🥬 채소"),
                (data.redFood, "🌶️ 빨간맛"), (data.notRedFood, "🌶️🚫 안 빨간맛"),
                (data.todayRice, "🍙 밥"), (data.todayBread, "🍞 빵"),
                (data.todayNoodle, "🍜 면"), (data.todayHeavy, "🥘 헤비"),
                (data.todayLight, "🥗 라이트"), (data.todaySoup, "🥣 국물"),
                (data.todayNoSoup, "🍽️ NO국물")
            ]
            
            for (value, text) in foodTypes {
                if value == 1 {
                    self.daily.append(text)
                }
            }
        } else {
            self.yesterdayFood = "???"
            self.daily = ["???"]
        }
    }
    
    func updateUI() {
        self.tagUnderCollectionView.reloadData()
        self.dailytasteCollectionView.reloadData()
        
        let imageName = Model.ModelData[selectedIndex].image
        print(imageName)
        userImage.image = UIImage(named: imageName)
        
        self.status.text = label
        self.nickname.text = name
        self.yesterdayeat.text = self.yesterdayFood
        self.yesterdayeat.text = self.yesterdayFood
        // 다른 UI 업데이트가 필요한 경우 여기에 추가
    }
    
    
    
    //언더라인 collectionview 생성
    private let tagUnderCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 7  //cell간격
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    //입맛 collectionview 생성
    private let dailytasteCollectionView: UICollectionView = {
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 4  //상하
        layout.minimumInteritemSpacing = 4  //좌우
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    let backlabel: UIView = {
        let back = UIView()
        back.translatesAutoresizingMaskIntoConstraints = false
        back.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        back.layer.cornerRadius = 15
        back.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        back.layer.shadowOpacity = 1
        back.layer.shadowOffset = CGSize(width: 0, height: 2)
        back.layer.shadowRadius = 10
        return back
    }()
    
    let background: UIView = {
        let back = UIView()
        back.translatesAutoresizingMaskIntoConstraints = false
        back.backgroundColor = #colorLiteral(red: 0.9813271165, green: 0.9813271165, blue: 0.9813271165, alpha: 1)
        back.layer.cornerRadius = 15
        return back
    }()
    
    let mainLabel : UILabel = {
        let label =  UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "Pretendard-Bold" , size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subLabel : UILabel = {
        let label =  UILabel()
        
        label.text = "FOOROFILE 생성완료!"
        label.textAlignment = .center
        label.font = UIFont(name: "Pretendard-Light" , size: 20)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nextButton : UIButton = {
        var config = UIButton.Configuration.filled()
        config.background.backgroundColor = #colorLiteral(red: 1, green: 0.5921568627, blue: 0.1019607843, alpha: 1)
        
        
        // 내부 여백 설정
        config.contentInsets = NSDirectionalEdgeInsets(top: 7, leading: 148, bottom: 7, trailing: 149)
        
        config.title = "메인으로"
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont(name: "Pretendard-Bold", size: 16)
            outgoing.foregroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            return outgoing
        }
    
        var button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 29
        button.layer.masksToBounds = true
        button.isEnabled = true
        button.addTarget(self, action: #selector(firstButtonTapped), for: .touchUpInside)

        return button
        
    }()
    
    let boundary: UILabel = {
        let boundary = UILabel()
        boundary.translatesAutoresizingMaskIntoConstraints = false
        boundary.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        boundary.layer.cornerRadius = 25
        boundary.layer.borderWidth = 4
        boundary.layer.borderColor = UIColor(red: 1, green: 0.656, blue: 0.242, alpha: 1).cgColor
        boundary.layer.masksToBounds = true
        return boundary
    }()
    let status: PaddedLabelround = {
        let label = PaddedLabelround()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont(name: "Pretendard-SemiBold", size: 15)
        label.textAlignment = .center
        label.setPadding(top: 5, left: 15, bottom: 5, right: 15)
        label.layer.backgroundColor = UIColor(red: 1, green: 0.656, blue: 0.242, alpha: 1).cgColor
        label.clipsToBounds = true
        return label
    }()
    
    let titleImage1 : UIImageView = {
        let titleImage = UIImageView()
        
        titleImage.image = UIImage(named: "etc1")
        titleImage.translatesAutoresizingMaskIntoConstraints = false
        titleImage.contentMode = .scaleAspectFit
        return titleImage
    }()
    
    let titleImage2 : UIImageView = {
        let titleImage = UIImageView()
        
        titleImage.image = UIImage(named: "etc2")
        titleImage.translatesAutoresizingMaskIntoConstraints = false
        titleImage.contentMode = .scaleAspectFit
        return titleImage
    }()
    
    var userImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    let nickname: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont(name: "Pretendard-Bold", size: 23)
        label.textAlignment = .center
        label.clipsToBounds = true
        return label
    }()
    
    let yesterday: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "어제 먹은 음식은"
        label.frame = CGRect(x: 0, y: 0, width: 99, height: 18)
        label.textColor = UIColor(red: 0.404, green: 0.404, blue: 0.404, alpha: 1)
        label.font = UIFont(name: "Pretendard-Light", size: 14)
        return label
    }()
    
lazy var yesterdayeat: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.frame = CGRect(x: 0, y: 0, width: 78, height: 29)
        label.textColor = #colorLiteral(red: 0.4037296772, green: 0.4037296474, blue: 0.4037296772, alpha: 1)
        label.font = UIFont(name: "Pretendard-SemiBold", size: 16)
        return label
    }()
    
    let dailytaste: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "오늘 내 입맛은"
        label.frame = CGRect(x: 0, y: 0, width: 86, height: 18)
        label.textColor = UIColor(red: 0.404, green: 0.404, blue: 0.404, alpha: 1)
        label.font = UIFont(name: "Pretendard-light", size: 14)
        return label
    }()
    
    @objc private func firstButtonTapped() {
        let preferVC = TabbarViewController()
        
        let transition = CATransition()
        transition.duration = 0.4
        transition.type = .push
        transition.subtype = .fromRight
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
        
        view.window?.layer.add(transition, forKey: kCATransition)
        preferVC.modalPresentationStyle = .fullScreen  // 전체 화면으로 설정
        present(preferVC, animated: false, completion: nil)
    }
    
    
    //MARK: - func
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        self.name = LoginController.globalName
        
        tagUnderCollectionView.dataSource = self
        tagUnderCollectionView.delegate = self
        tagUnderCollectionView.register(underbordCell.self, forCellWithReuseIdentifier: "underbordCell")
        
        dailytasteCollectionView.dataSource = self
        dailytasteCollectionView.delegate = self
        dailytasteCollectionView.register(dailytasteCell.self, forCellWithReuseIdentifier: "dailytasteCell")

        mainLabel.text = name + "님의"
        
        

        firstProfile()
        setUI()
    }
    
    
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//    }
    
    
    func setUI(){
        view.addSubview(mainLabel)
        view.addSubview(subLabel)
        view.addSubview(nextButton)
        view.addSubview(titleImage1)
        view.addSubview(titleImage2)
        view.addSubview(backlabel)
        view.addSubview(userImage)
        backlabel.addSubview(boundary)
        boundary.addSubview(status)
        backlabel.addSubview(nickname)
        view.addSubview(tagUnderCollectionView)
        backlabel.addSubview(background)
        background.addSubview(yesterday)
        background.addSubview(dailytaste)
        background.addSubview(yesterdayeat)
        view.addSubview(dailytasteCollectionView)

        NSLayoutConstraint.activate([
                mainLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor , constant: 72.3),
                mainLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 35),
                
                subLabel.leadingAnchor.constraint(equalTo: mainLabel.trailingAnchor , constant: 4),
                subLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 35),
                
                background.topAnchor.constraint(equalTo: boundary.bottomAnchor, constant: 92.5),
                background.centerXAnchor.constraint(equalTo: boundary.centerXAnchor),
                background.bottomAnchor.constraint(equalTo: backlabel.bottomAnchor, constant: -15),
                background.widthAnchor.constraint(equalToConstant: 275),
            
              
                
                nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor , constant: -10),
                nextButton.widthAnchor.constraint(equalToConstant: 129),
                nextButton.heightAnchor.constraint(equalToConstant: 56),
                
                titleImage1.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor , constant: 28.4),
                titleImage1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 18.7),
                
                titleImage2.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant:  -25.7),
                titleImage2.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 2),
                
                backlabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor , constant: 25 ),
                backlabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor , constant: 51),
                backlabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor , constant: -23),
                backlabel.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -25),
                
                boundary.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                boundary.topAnchor.constraint(equalTo: backlabel.topAnchor, constant: 25),
                boundary.heightAnchor.constraint(equalToConstant: 275),
                boundary.widthAnchor.constraint(equalToConstant: 275),
                
                status.topAnchor.constraint(equalTo: boundary.topAnchor),
                status.centerXAnchor.constraint(equalTo: boundary.centerXAnchor),
                status.heightAnchor.constraint(equalToConstant: 31),
                status.widthAnchor.constraint(equalToConstant: 140),
                
                userImage.centerXAnchor.constraint(equalTo: boundary.centerXAnchor),
                userImage.widthAnchor.constraint(equalToConstant: 190),
                userImage.heightAnchor.constraint(equalToConstant: 190),
                userImage.centerYAnchor.constraint(equalTo: boundary.centerYAnchor),
                
                nickname.topAnchor.constraint(equalTo: boundary.bottomAnchor, constant: 13.5),
                nickname.centerXAnchor.constraint(equalTo: boundary.centerXAnchor),
                nickname.heightAnchor.constraint(equalToConstant: 21),
                
                tagUnderCollectionView.leadingAnchor.constraint(equalTo: boundary.leadingAnchor),
                tagUnderCollectionView.trailingAnchor.constraint(equalTo: boundary.trailingAnchor),
                tagUnderCollectionView.topAnchor.constraint(equalTo: nickname.bottomAnchor, constant: 13),
                tagUnderCollectionView.heightAnchor.constraint(equalToConstant: 29),
                
                yesterday.topAnchor.constraint(equalTo: background.topAnchor, constant: 20.22),
                yesterday.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 21.5),
            
                yesterdayeat.leadingAnchor.constraint(equalTo: yesterday.trailingAnchor, constant: 18),
                yesterdayeat.centerYAnchor.constraint(equalTo: yesterday.centerYAnchor),
                yesterdayeat.heightAnchor.constraint(equalToConstant: 29),
                
                dailytaste.topAnchor.constraint(equalTo: background.topAnchor, constant: 55.77),
                dailytaste.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 21.5),
                dailytaste.widthAnchor.constraint(equalToConstant: 80),
                dailytaste.heightAnchor.constraint(equalToConstant: 17),
                
                dailytasteCollectionView.leadingAnchor.constraint(equalTo: dailytaste.trailingAnchor, constant: 30),
                dailytasteCollectionView.topAnchor.constraint(equalTo: dailytaste.topAnchor, constant: -8),
                dailytasteCollectionView.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: -18),
                dailytasteCollectionView.bottomAnchor.constraint(equalTo: background.bottomAnchor, constant: -10),

            ])
        }
    
    
}
extension Openprofile: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == tagUnderCollectionView{
            return tags.count
        }
        else {
            return daily.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == tagUnderCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "underbordCell", for: indexPath) as! underbordCell
            cell.tagUnderline.text = tags[indexPath.item]
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dailytasteCell", for: indexPath) as! dailytasteCell
            cell.dailytaste.text = daily[indexPath.item]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == tagUnderCollectionView{
            let tag = tags[indexPath.item]
            let font = UIFont(name: "Pretendard-SemiBold", size: 13)
            let attributes = [NSAttributedString.Key.font: font]
            let size = (tag as NSString).size(withAttributes: attributes)
            return CGSize(width: size.width + 25, height: 29)
        }
        else{
            let tag = daily[indexPath.item]
            let font = UIFont(name: "Pretendard-SemiBold", size: 13)
            let attributes = [NSAttributedString.Key.font: font]
            let size = (tag as NSString).size(withAttributes: attributes)
            return CGSize(width: size.width + 18, height: 29)
        }
    }
}


