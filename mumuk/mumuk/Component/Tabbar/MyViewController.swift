


import UIKit
import KakaoSDKUser

class MyViewController: UIViewController {
    var uid : String = ""
    var selectedIndex : Int = 0
    var label : String = ""        //foodtype
    var name : String = ""
    var tags: [String] = []    // 언더라인 태그
    var daily: [String] = [] // 오늘 내 입맛은?
    var yesterdayFood: String = ""  // 어제 먹은 음식은
    var spicyType: Bool = false     //언더라인 태그에 삽입
    var koreanFood : Int = 0
    var japaneseFood : Int = 0
    var chineseFood : Int = 0
    var westernFood : Int = 0
    var southeastAsianFood : Int = 0
    var elseFood : Int = 0
//
//    func Profiletag() {
//        print("상세 데이터 불러오기 시작")
//        print("✅uid \(uid)")
//        if let url = URL(string: "https://mumuk.store/with-pref/\(name)") {
//            let session = URLSession(configuration: .default)
//            let task = session.dataTask(with: url) { data, response, error in
//                if let error = error {
//                    print("🚨🚨🚨", error)
//                    return
//                }
//                if let JSONdata = data {
//                    let dataString = String(data: JSONdata, encoding: .utf8)
//                    print(dataString ?? "No data")
//
//                    let decoder = JSONDecoder()
//                    do {
//                        let decodeData = try decoder.decode(OpenPreferModel.self, from: JSONdata)
//                        DispatchQueue.main.async {
//                            self.koreanFood = decodeData.koreanFood
//                            self.japaneseFood = decodeData.japaneseFood
//                            self.chineseFood = decodeData.chineseFood
//                            self.westernFood = decodeData.westernFood
//                            self.southeastAsianFood = decodeData.southeastAsianFood
//                            self.elseFood = decodeData.elseFood
//                        }
//                    } catch {
//                        print("🚨🚨🚨", error)
//                    }
//                }
//            }
//            task.resume()
//        }
//    }
//
//
    
    func deepProfile() {
        print(uid)
        print("상세 데이터 불러오기 시작")
        print("✅uid \(uid)")
        print(name)
        if let url = URL(string: "https://mumuk.store/with-pref/daily/\(name)") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("🚨🚨🚨", error)
                    return
                }
                if let JSONdata = data {
                    let dataString = String(data: JSONdata, encoding: .utf8)
                    print(dataString ?? "No data")
                    
                    let decoder = JSONDecoder()
                    do {
                        let decodeData = try decoder.decode(UserPreference.self, from: JSONdata)
                        DispatchQueue.main.async {
                            self.configureViewFromData(decodeData)
                            self.updateUI()
                        }
                    } catch {
                        print("🚨🚨🚨", error)
                    }
                }
            }
            task.resume()
        }
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
            "가지": "#가지 NO", "내장류": "#내장류 NO", "갑각류": "#갑각류 NO", "해산물": "#해산물 NO",
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
        userImage.image = UIImage(named: imageName)

        self.mystatelabel.text = label
        self.nameLabel.text = name
        self.yesterdayeat.text = self.yesterdayFood
        self.yesterdayeat.text = self.yesterdayFood
        // 다른 UI 업데이트가 필요한 경우 여기에 추가
    }

    let scrollView: UIScrollView = {
        let scrollViews = UIScrollView()
        scrollViews.translatesAutoresizingMaskIntoConstraints = false
        scrollViews.backgroundColor = .white
        return scrollViews
    }()
    
    let contentView: UIView = {
        let contents = UIView()
        contents.translatesAutoresizingMaskIntoConstraints = false
        contents.backgroundColor = .white
        return contents
    }()
    
    let firstView: UIView = {
        let first = UIView()
        first.translatesAutoresizingMaskIntoConstraints = false
        first.backgroundColor = .white
        first.clipsToBounds = true
        first.layer.cornerRadius = 50
        first.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMaxYCorner, .layerMaxXMaxYCorner)
        first.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        first.layer.shadowOffset = CGSize(width: 0, height: 2)
        first.layer.shadowRadius = 7
        first.layer.shadowOpacity = 1
        first.layer.masksToBounds = false
        return first
    }()
    
    let secondView: UIView = {
        let second = UIView()
        second.translatesAutoresizingMaskIntoConstraints = false
        second.backgroundColor = .white
        second.clipsToBounds = true
        second.layer.cornerRadius = 20
        second.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        second.layer.shadowOffset = CGSize(width: 0, height: 1)
        second.layer.shadowRadius = 10
        second.layer.shadowOpacity = 1
        second.layer.masksToBounds = false
        return second
    }()

    let thirdView: UIView = {
        let third = UIView()
        third.translatesAutoresizingMaskIntoConstraints = false
        third.backgroundColor = .white
        
        third.clipsToBounds = true
        third.layer.cornerRadius = 20

        third.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        third.layer.shadowOffset = CGSize(width: 0, height: 1)    //그림자 위치.
        third.layer.shadowRadius = 10     //흐림반경. 값 클수록 넓고 흐릿
        third.layer.shadowOpacity = 1   //그림자의 투명도. 0.0(투명) ~ 1.0(불투명)
        third.layer.masksToBounds = false //경계 벗어나도록
        return third
    }()
    
    let fourthView: UIView = {
        let fourth = UIView()
        fourth.translatesAutoresizingMaskIntoConstraints = false
        fourth.backgroundColor = .white
        
        fourth.clipsToBounds = true
        fourth.layer.cornerRadius = 20

        fourth.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        fourth.layer.shadowOffset = CGSize(width: 0, height: 1)    //그림자 위치.
        fourth.layer.shadowRadius = 10     //흐림반경. 값 클수록 넓고 흐릿
        fourth.layer.shadowOpacity = 1   //그림자의 투명도. 0.0(투명) ~ 1.0(불투명)
        fourth.layer.masksToBounds = false //경계 벗어나도록
        return fourth
    }()
    
    private let tagUnderCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 5
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private let dailytasteCollectionView: UICollectionView = {
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8  //상하
        layout.minimumInteritemSpacing = 12  //좌우
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
//    let editprofile: UIButton = {
//        let edit = UIButton()
//        edit.translatesAutoresizingMaskIntoConstraints = false
//        edit.addTarget(self, action: #selector(editButtonnPressed), for: .touchUpInside)
//
//        let label = PaddedLabelunder()
//        label.text = "프로필 수정>"
//        label.frame = CGRect(x: 0, y: 0, width: 69, height: 14)
//        label.textAlignment = .center
//        label.textColor = UIColor(red: 0.725, green: 0.725, blue: 0.725, alpha: 1)
//        label.font = UIFont(name: "Pretendard-Medium", size: 12)
//        edit.addSubview(label)
//
//        var paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.lineHeightMultiple = 1.52
//
//        return edit
//    }()
    
    let labelMy: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "MY"
        label.frame = CGRect(x: 0, y: 0, width: 35, height: 19)
        label.textColor = .black
        label.font = UIFont(name: "Pretendard-Bold", size: 22)
        return label
    }()
    
    // 이미지 들어가는 테두리
    var userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 40.5 // 반지름을 이미지 뷰의 절반으로 설정하여 원형으로 만듦
        imageView.layer.borderWidth = 2 // 테두리 두께 설정
        imageView.layer.borderColor = #colorLiteral(red: 1, green: 0.5921568627, blue: 0.1019607843, alpha: 1) // 테두리 색상 설정
        imageView.clipsToBounds = true // 이미지가 경계를 넘지 않도록 함
        return imageView
    }()
    
    // 이미지 삽입하는 곳
    var userImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    private let modalButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(editbuttonpressed), for: .touchUpInside)
        button.setTitle("+", for: .normal)
        button.setTitleColor(UIColor.orange, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.layer.borderColor = UIColor.orange.cgColor
        button.layer.borderWidth = 2.0  // 테두리 두께 설정
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 1, right: 0)
        return button
    }()
    
    var nameLabel : UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.frame = CGRect(x: 0, y: 0, width: 130, height: 30)
        name.textColor = UIColor.black
        name.font = UIFont(name: "Pretendard-Bold", size: 25)
        return name
    }()
    
    let personaltasteedit: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(editButtonnPressed), for: .touchUpInside)
        
        // PaddedLabel 생성
        let label = PaddedLabelunder()
        label.text = "고유입맛 수정하기 >"
        label.textColor = #colorLiteral(red: 0.7743276358, green: 0.7743276358, blue: 0.7743276358, alpha: 1)
        label.font = UIFont(name: "Pretendard-Medium", size: 12)
        label.textAlignment = .center
        
        button.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: button.topAnchor),
            label.bottomAnchor.constraint(equalTo: button.bottomAnchor),
            label.leadingAnchor.constraint(equalTo: button.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: button.trailingAnchor)
        ])
        return button
    }()
    
    let myState: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "요즘 나의 상태는"
        label.frame = CGRect(x: 0, y: 0, width: 112 , height: 20)
        label.textColor = #colorLiteral(red: 0.3747495413, green: 0.3747495115, blue: 0.3747495115, alpha: 1)
        label.font = UIFont(name: "Pretendard-Medium", size: 17)
        return label
    }()
    
    lazy var mystatelabel: PaddedLabel = {
            let label = PaddedLabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.frame = CGRect(x: 0, y: 0, width: 78, height: 29)
            label.textColor = UIColor(red: 1, green: 0.592, blue: 0.102, alpha: 1)
            label.layer.cornerRadius = 14.5
            label.layer.borderWidth = 1
            label.layer.borderColor = UIColor(red: 1, green: 0.592, blue: 0.102, alpha: 1).cgColor
            label.font = UIFont(name: "Pretendard-Bold", size: 14)
            label.setPadding(top: 5, left: 9, bottom: 5, right: 9)
            return label
        }()
    
    let yesterday: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "어제 먹은 음식"
        label.frame = CGRect(x: 0, y: 0, width: 112 , height: 20)
        label.textColor = #colorLiteral(red: 0.3747495413, green: 0.3747495115, blue: 0.3747495115, alpha: 1)
        label.font = UIFont(name: "Pretendard-Medium", size: 17)
        return label
    }()
    
    lazy var yesterdayeat: PaddedLabel = {
            let label = PaddedLabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.frame = CGRect(x: 0, y: 0, width: 78, height: 29)
            label.textColor = UIColor(red: 1, green: 0.592, blue: 0.102, alpha: 1)
            label.layer.cornerRadius = 14.5
            label.layer.borderWidth = 1
            label.layer.borderColor = UIColor(red: 1, green: 0.592, blue: 0.102, alpha: 1).cgColor
            label.font = UIFont(name: "Pretendard-Bold", size: 14)
            label.setPadding(top: 5, left: 9, bottom: 5, right: 9)
            return label
        }()
    
    var line : UIView = {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.frame = CGRect(x: 0, y: 0, width: 271, height: 0)
        
        var stroke = UIView()
        stroke.bounds = line.bounds.insetBy(dx: -1, dy: -1)
        stroke.center = line.center
        stroke.layer.borderWidth = 2
        stroke.layer.borderColor = UIColor(red: 0.929, green: 0.929, blue: 0.929, alpha: 1).cgColor
        line.addSubview(stroke)
        return line
    }()

    let todaykeyword: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "오늘의 입맛 키워드"
        label.frame = CGRect(x: 0, y: 0, width: 128 , height: 20)
        label.textColor = #colorLiteral(red: 0.3747495413, green: 0.3747495115, blue: 0.3747495115, alpha: 1)
        label.font = UIFont(name: "Pretendard-Medium", size: 17)
        return label
    }()
    
    let helplabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "도움말"
        label.frame = CGRect(x: 0, y: 0, width: 45 , height: 20)
        label.textColor = UIColor(red: 0.302, green: 0.302, blue: 0.302, alpha: 1)
        label.font = UIFont(name: "Pretendard-Medium", size: 17)
        return label
    }()
    
    let customer: UIButton = {
        var configuration = UIButton.Configuration.plain()

        var text = AttributedString("고객센터")
        text.font = UIFont(name: "Pretendard-Medium", size: 14)
        text.foregroundColor = UIColor.black
        configuration.attributedTitle = text
        configuration.image = UIImage(named: "head")
        configuration.imagePadding = 19
        configuration.imagePlacement = .leading
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)

        let button = UIButton(configuration: configuration)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(customercontect), for: .touchUpInside)
        
        return button
    }()
    
    let service: UIButton = {
        var configuration = UIButton.Configuration.plain()

        var text = AttributedString("서비스 이용약관")
        text.font = UIFont(name: "Pretendard-Medium", size: 14)
        text.foregroundColor = UIColor.black
        configuration.attributedTitle = text
        configuration.image = UIImage(named: "sheet")
        configuration.imagePadding = 19
        configuration.imagePlacement = .leading
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)

        let button = UIButton(configuration: configuration)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()
    
    let logout: UIButton = {
        var configuration = UIButton.Configuration.plain()

        var text = AttributedString("로그아웃")
        text.font = UIFont(name: "Pretendard-Medium", size: 14)
        text.foregroundColor = UIColor.black
        configuration.attributedTitle = text
        configuration.image = UIImage(named: "logout")
        configuration.imagePadding = 19
        configuration.imagePlacement = .leading
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)

        let button = UIButton(configuration: configuration)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)

        return button
    }()
    //프로필 수정 기능 생기면 다시 만지겠지
//    @objc func editButtonnPressed(){
//         let preferVC = EditController()
//         preferVC.userId = self.uid  // uid 전달
//         preferVC.name = self.name  // name 전달
//         let transition = CATransition()
//             transition.duration = 0.4
//             transition.type = .push
//             transition.subtype = .fromRight
//             transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
//
//             // 현재 window에 전환 애니메이션 적용
//             view.window?.layer.add(transition, forKey: kCATransition)
//         preferVC.modalPresentationStyle = .fullScreen  // 전체 화면으로 설정
//         present(preferVC, animated: false, completion: nil)
//     }
    
    @objc private func editButtonnPressed() {
        print("수정수정 눌림")
        
//        let preferVC = edit1()
        let preferVC = Edit1()
//        preferVC.model = self.OpenPreferModel
        // OpenPreferModel 생성
        var exceptionalFoods: [String] = []
        
        // foodEmojis에 따른 exceptionalFoods 설정
        if self.tags.contains("#내장류 NO") { exceptionalFoods.append("1") }
        if self.tags.contains("#가지 NO") { exceptionalFoods.append("2") }
        if self.tags.contains("#갑각류 NO") { exceptionalFoods.append("3") }
        if self.tags.contains("#해산물 NO") { exceptionalFoods.append("4") }
        if self.tags.contains("#오이 NO") { exceptionalFoods.append("5") }
        if self.tags.contains("#유제품 NO") { exceptionalFoods.append("6") }
        if self.tags.contains("#향신료 NO") { exceptionalFoods.append("7") }
        if self.tags.contains("#조개 NO") { exceptionalFoods.append("8") }
        if self.tags.contains("#견과류 NO") { exceptionalFoods.append("9") }
        if self.tags.contains("#콩(대두) NO") { exceptionalFoods.append("10") }
        if self.tags.contains("#계란 NO") { exceptionalFoods.append("11") }
        if self.tags.contains("#날 것 NO") { exceptionalFoods.append("12") }
        if self.tags.contains("#밀가루(글루텐) NO") { exceptionalFoods.append("13") }
        if self.tags.contains("#다 잘 먹어요") { exceptionalFoods.append("14") }
        
        // foodTypeId 설정
        var foodTypeId: Int
        switch self.label {
        case "💪🏻 다이어트": foodTypeId = 1
        case "🐷🚫 할랄": foodTypeId = 2
        case "🥦 비건": foodTypeId = 3
        default: foodTypeId = 4
        }
        
        let openPreferModel = OpenPreferModel(
            exceptionalFoods: exceptionalFoods,
            spicyType: self.spicyType,
            koreanFood: self.koreanFood,
            westernFood: self.westernFood,
            chineseFood: self.chineseFood,
            japaneseFood: self.japaneseFood,
            southeastAsianFood: self.southeastAsianFood,
            elseFood: self.elseFood,
            foodTypeId: foodTypeId
        )
        
        // OpenPreferModel을 OpenPreferViewController1에 전달
        preferVC.openPreferModel = openPreferModel
        
        preferVC.uid = self.uid
        preferVC.name = self.name
        
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
    
    
    @objc private func customercontect() {
        showAlert(message: "010-5685-0125로 문의 하던가 말던가~")
    }
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {    //뷰가 뜰 때 실행되는 함수
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)      //이거hiddend을  true로 해서 움직일 때 위에 색 바뀌는거 없애줌
    }
    
    override func viewWillDisappear(_ animated: Bool) { // 뷰가 사라질 때 실행되는 함수
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.customer.setNeedsUpdateConfiguration()
            self.service.setNeedsUpdateConfiguration()
            self.logout.setNeedsUpdateConfiguration()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        tagUnderCollectionView.dataSource = self
        tagUnderCollectionView.delegate = self
        tagUnderCollectionView.register(underTagCell.self, forCellWithReuseIdentifier: "underTagCell")
        
        dailytasteCollectionView.dataSource = self
        dailytasteCollectionView.delegate = self
        dailytasteCollectionView.register(dailytasteCell.self, forCellWithReuseIdentifier: "dailytasteCell")
        
        // selectedIndex를 기반으로 userImage 설정
        let imageName = Model.ModelData[selectedIndex].image
        print(imageName)
        userImage.image = UIImage(named: imageName)
        nameLabel.text = name
        mystatelabel.text = label
        yesterdayeat.text = yesterdayFood
        
        deepProfile()
        setUI()
    }

        @objc func editbuttonpressed() {
            //키보드 내리기
            view.endEditing(true)
            
            let ModalImageEdite = ModalImageEdite()
            ModalImageEdite.selectedIndex = self.selectedIndex
            ModalImageEdite.uid = self.uid// uid 값 전달
            ModalImageEdite.modalPresentationStyle = .formSheet
            
            ModalImageEdite.selectedImage = UIImage(named: Model.ModelData[selectedIndex].image)
            
            // detent 설정
            if let sheet = ModalImageEdite.sheetPresentationController {
                // detents 배열을 설정하여 원하는 위치에 맞게 모달 창의 위치를 조정할 수 있습니다.
                sheet.detents = [
                    .custom { _ in
                        return 550  //이 숫자로 원하는 만큼 조절가능
                    }
                ]
                sheet.preferredCornerRadius = 40 // 모달 창의 모서리 둥글기 설정

                ModalImageEdite.delegate = self // delegate 설정
                
                // 모달을 present
                present(ModalImageEdite, animated: true)
            }
        }
        
    
    func setUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(firstView)
        contentView.addSubview(secondView)
        contentView.addSubview(thirdView)
        contentView.addSubview(fourthView)
        firstView.addSubview(labelMy)
        firstView.addSubview(userImageView)
        userImageView.addSubview(userImage)
        firstView.addSubview(modalButton)
//        firstView.addSubview(editprofile)
        firstView.addSubview(nameLabel)
        firstView.addSubview(tagUnderCollectionView)
        firstView.addSubview(personaltasteedit)
        secondView.addSubview(myState)
        secondView.addSubview(mystatelabel)
        thirdView.addSubview(yesterday)
        thirdView.addSubview(yesterdayeat)
        thirdView.addSubview(line)
        thirdView.addSubview(todaykeyword)
        thirdView.addSubview(dailytasteCollectionView)
        fourthView.addSubview(helplabel)
        fourthView.addSubview(customer)
        fourthView.addSubview(service)
        fourthView.addSubview(logout)


        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -80),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 800), // contentView의 높이 제약 추가
            
            firstView.topAnchor.constraint(equalTo: contentView.topAnchor),
            firstView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            firstView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            firstView.heightAnchor.constraint(equalToConstant: 176),
            
            secondView.topAnchor.constraint(equalTo: firstView.bottomAnchor, constant: 29),
            secondView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 34),
            secondView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -34),
            secondView.heightAnchor.constraint(equalToConstant: 79),
            
            thirdView.topAnchor.constraint(equalTo: secondView.bottomAnchor, constant: 29),
            thirdView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 34),
            thirdView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -34),
            thirdView.heightAnchor.constraint(equalToConstant: 263),
            
            tagUnderCollectionView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 3),
            tagUnderCollectionView.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            tagUnderCollectionView.heightAnchor.constraint(equalToConstant: 14),
            tagUnderCollectionView.widthAnchor.constraint(equalToConstant: 219),
            
            personaltasteedit.topAnchor.constraint(equalTo: tagUnderCollectionView.bottomAnchor, constant: 11.7),
            personaltasteedit.leadingAnchor.constraint(equalTo: tagUnderCollectionView.leadingAnchor),
            personaltasteedit.heightAnchor.constraint(equalToConstant: 11),
            
            fourthView.topAnchor.constraint(equalTo: thirdView.bottomAnchor, constant: 31),
            fourthView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 34),
            fourthView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -34),
            fourthView.heightAnchor.constraint(equalToConstant: 208),
            
            labelMy.topAnchor.constraint(equalTo: firstView.topAnchor, constant: 10),
            labelMy.leadingAnchor.constraint(equalTo: firstView.leadingAnchor, constant: 32),
            
            userImageView.topAnchor.constraint(equalTo: firstView.topAnchor, constant: 42.5),
            userImageView.widthAnchor.constraint(equalToConstant: 81),
            userImageView.heightAnchor.constraint(equalToConstant: 81),
            userImageView.trailingAnchor.constraint(equalTo: firstView.trailingAnchor, constant: -32.1),
            
            userImage.centerXAnchor.constraint(equalTo: userImageView.centerXAnchor),
            userImage.centerYAnchor.constraint(equalTo: userImageView.centerYAnchor),
            userImage.widthAnchor.constraint(equalTo: userImageView.widthAnchor),
            userImage.heightAnchor.constraint(equalTo: userImageView.heightAnchor),
            
            modalButton.trailingAnchor.constraint(equalTo: userImage.trailingAnchor),
            modalButton.bottomAnchor.constraint(equalTo: userImage.bottomAnchor),
            modalButton.heightAnchor.constraint(equalToConstant: 24),
            modalButton.widthAnchor.constraint(equalToConstant: 24),
            
//
//            editprofile.topAnchor.constraint(equalTo: firstView.topAnchor, constant: 135.5),
//            editprofile.centerXAnchor.constraint(equalTo: userImageView.centerXAnchor),
//            editprofile.widthAnchor.constraint(equalToConstant: 69),
//            editprofile.heightAnchor.constraint(equalToConstant: 14),
            
            nameLabel.topAnchor.constraint(equalTo: labelMy.bottomAnchor, constant: 22.81),
            nameLabel.leadingAnchor.constraint(equalTo: firstView.leadingAnchor, constant: 32),
            
            myState.topAnchor.constraint(equalTo: secondView.topAnchor, constant: 30),
            myState.leadingAnchor.constraint(equalTo: secondView.leadingAnchor, constant: 27),
            
            mystatelabel.centerYAnchor.constraint(equalTo: myState.centerYAnchor),
            mystatelabel.trailingAnchor.constraint(equalTo: secondView.trailingAnchor, constant: -27),
            
            yesterday.topAnchor.constraint(equalTo: thirdView.topAnchor, constant: 35),
            yesterday.leadingAnchor.constraint(equalTo: thirdView.leadingAnchor, constant: 28),
            
            yesterdayeat.centerYAnchor.constraint(equalTo: yesterday.centerYAnchor),
            yesterdayeat.trailingAnchor.constraint(equalTo: thirdView.trailingAnchor, constant: -27),
            
            line.topAnchor.constraint(equalTo: thirdView.topAnchor, constant: 93),
            line.leadingAnchor.constraint(equalTo: thirdView.leadingAnchor, constant: 28),
            
            todaykeyword.topAnchor.constraint(equalTo: line.topAnchor, constant: 32),
            todaykeyword.leadingAnchor.constraint(equalTo: thirdView.leadingAnchor, constant: 28),
            
            dailytasteCollectionView.topAnchor.constraint(equalTo: todaykeyword.bottomAnchor, constant: 24),
            dailytasteCollectionView.leadingAnchor.constraint(equalTo: thirdView.leadingAnchor, constant: 68),
            dailytasteCollectionView.widthAnchor.constraint(equalToConstant: 231),
            dailytasteCollectionView.heightAnchor.constraint(equalToConstant: 67),
            
            helplabel.topAnchor.constraint(equalTo: fourthView.topAnchor, constant: 33),
            helplabel.leadingAnchor.constraint(equalTo: fourthView.leadingAnchor, constant: 28),
            
            customer.topAnchor.constraint(equalTo: helplabel.bottomAnchor, constant: 21),
            customer.leadingAnchor.constraint(equalTo: helplabel.leadingAnchor, constant: 5),
            
            service.topAnchor.constraint(equalTo: customer.bottomAnchor, constant: 21),
            service.leadingAnchor.constraint(equalTo: helplabel.leadingAnchor, constant: 5),
            
            logout.topAnchor.constraint(equalTo: service.bottomAnchor, constant: 21),
            logout.leadingAnchor.constraint(equalTo: helplabel.leadingAnchor, constant: 5)
        ])
    }
}

extension MyViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "underTagCell", for: indexPath) as! underTagCell
            let textColor: UIColor = #colorLiteral(red: 1, green: 0.5921568627, blue: 0.1019607843, alpha: 1)
            let font: UIFont = UIFont(name: "Pretendard-SemiBold", size: 13)!
            cell.configure(text: tags[indexPath.item], textColor: textColor, font: font)
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dailytasteCell", for: indexPath) as! dailytasteCell
            let textColor: UIColor = #colorLiteral(red: 1, green: 0.5921568627, blue: 0.1019607843, alpha: 1)
            let font: UIFont = UIFont(name: "Pretendard-SemiBold", size: 14)!
            let backgound: UIColor = .white
            cell.configure(text: daily[indexPath.item], textColor: textColor, font: font, backgroundColor: backgound)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == tagUnderCollectionView{
            let tag = tags[indexPath.item]
            let font = UIFont(name: "Pretendard-SemiBold", size: 13)
            let attributes = [NSAttributedString.Key.font: font]
            let size = (tag as NSString).size(withAttributes: attributes)
            return CGSize(width: size.width + 3, height: size.height)
        }
        else{
            let tag = daily[indexPath.item]
            let font = UIFont(name: "Pretendard-SemiBold", size: 14)
            let attributes = [NSAttributedString.Key.font: font]
            let size = (tag as NSString).size(withAttributes: attributes)
            return CGSize(width: size.width + 18, height: 29)
        }
    }
    
    @objc func logoutButtonTapped() {
        // 로그아웃 확인 알림창 표시
        let alert = UIAlertController(title: "로그아웃", message: "정말 로그아웃 하시겠습니까?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "로그아웃", style: .destructive, handler: { _ in
            self.performLogout()
        }))
        
        present(alert, animated: true, completion: nil)
    }

    func performLogout() {
        // UserDefaults에서 로그인 상태 및 사용자 정보 삭제
        UserDefaultsManager.shared.setLoggedIn(false)
        UserDefaultsManager.shared.setUserId(nil)
        
        // 카카오 로그아웃
        UserApi.shared.logout {(error) in
            if let error = error {
                print(error)
            }
            else {
                print("카카오 logout() success.")
            }
        }
        
        // 로그인 화면으로 이동
        self.navigateToLoginScreen()
    }

    func navigateToLoginScreen() {
        let loginVC = KakaoLoginViewController()
        let navController = UINavigationController(rootViewController: loginVC)
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated: true, completion: nil)
    }
}

extension MyViewController: ModalImageSelectDelegate {
    func didSelectImage(withNumber number: Int) {
        self.selectedIndex = number
        let imageName = Model.ModelData[number].image
        userImage.image = UIImage(named: imageName)
    }
}

