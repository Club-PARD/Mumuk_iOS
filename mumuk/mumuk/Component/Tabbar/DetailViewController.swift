//  DetailViewController.swift
//  mumuk
//
//  Created by 유재혁 on 7/1/24.
//

import UIKit

//padding, 코너의 radius를 주기 위한 함수 추가
class PaddedLabelround: UILabel {
    var topInset: CGFloat = 0.0
    var bottomInset: CGFloat = 0.0
    var leftInset: CGFloat = 0.0
    var rightInset: CGFloat = 0.0
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }
    
    func setPadding(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) {
        topInset = top
        leftInset = left
        bottomInset = bottom
        rightInset = right
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    //    코너 둥글게
        override func layoutSubviews() {
            super.layoutSubviews()
            roundCorners(corners: [.bottomLeft, .bottomRight], radius: 20)
        }
}

class DetailViewController: UIViewController {

    var selectedIndex : Int = 0
    var label : String = ""        //foodtype
    var name : String = ""
    var tags: [String] = []    // 언더라인 태그
    var daily: [String] = [] // 오늘 내 입맛은?
    var yesterdayFood: String = ""  // 어제 먹은 음식은
    var spicyType: Bool = false     //언더라인 태그에 삽입
    
    func deepProfile() {
        print("상세 데이터 불러오기 시작")
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
            "가지": "#가지 NO", "내장류": "#내장류", "갑각류": "#갑각류", "해산물": "#해산물",
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
        back.backgroundColor = #colorLiteral(red: 0.9813271165, green: 0.9813271165, blue: 0.9813271165, alpha: 1)
        back.layer.cornerRadius = 15
        return back
    }()
    
    let background: UILabel = {
        let back = UILabel()
        back.translatesAutoresizingMaskIntoConstraints = false
        back.backgroundColor = .white
        back.layer.cornerRadius = 30
        back.layer.masksToBounds = true
        return back
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
    
    let existButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.background.backgroundColor = .clear
        config.imagePlacement = .all

        if let image = UIImage(named: "cancel") {
            let size = CGSize(width: 72, height: 72)
            UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
            image.draw(in: CGRect(origin: .zero, size: size))
            let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()

            config.image = scaledImage
        }

        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)

        return button
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear

        tagUnderCollectionView.dataSource = self
        tagUnderCollectionView.delegate = self
        tagUnderCollectionView.register(underbordCell.self, forCellWithReuseIdentifier: "underbordCell")
        
        dailytasteCollectionView.dataSource = self
        dailytasteCollectionView.delegate = self
        dailytasteCollectionView.register(dailytasteCell.self, forCellWithReuseIdentifier: "dailytasteCell")
        
        let backgroundView = UIView(frame: view.bounds)
        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.addSubview(backgroundView)

        deepProfile()
        setUI()

    }

    func setUI() {
        view.addSubview(existButton)
        view.addSubview(background)
        background.addSubview(boundary)
        boundary.addSubview(userImage)
        boundary.addSubview(status)
        background.addSubview(nickname)
        view.addSubview(tagUnderCollectionView)
        background.addSubview(backlabel)
        backlabel.addSubview(yesterday)
        backlabel.addSubview(dailytaste)
        backlabel.addSubview(yesterdayeat)
        view.addSubview(dailytasteCollectionView)
        
        NSLayoutConstraint.activate([
            background.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            background.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            background.topAnchor.constraint(equalTo: view.topAnchor, constant: 109),
            background.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -170),
            
            boundary.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            boundary.topAnchor.constraint(equalTo: background.topAnchor, constant: 25),
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
            
            backlabel.topAnchor.constraint(equalTo: boundary.bottomAnchor, constant: 92.5),
            backlabel.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 35),
            backlabel.heightAnchor.constraint(equalToConstant: 135),
            backlabel.widthAnchor.constraint(equalToConstant: 275),
            
            yesterday.topAnchor.constraint(equalTo: backlabel.topAnchor, constant: 20.22),
            yesterday.leadingAnchor.constraint(equalTo: backlabel.leadingAnchor, constant: 21.5),
        
            yesterdayeat.leadingAnchor.constraint(equalTo: yesterday.trailingAnchor, constant: 18),
            yesterdayeat.centerYAnchor.constraint(equalTo: yesterday.centerYAnchor),
            yesterdayeat.heightAnchor.constraint(equalToConstant: 29),
            
            dailytaste.topAnchor.constraint(equalTo: backlabel.topAnchor, constant: 55.77),
            dailytaste.leadingAnchor.constraint(equalTo: backlabel.leadingAnchor, constant: 21.5),
            dailytaste.widthAnchor.constraint(equalToConstant: 80),
            dailytaste.heightAnchor.constraint(equalToConstant: 17),
            
            dailytasteCollectionView.leadingAnchor.constraint(equalTo: dailytaste.trailingAnchor, constant: 30),
            dailytasteCollectionView.topAnchor.constraint(equalTo: dailytaste.topAnchor, constant: -8),
            dailytasteCollectionView.trailingAnchor.constraint(equalTo: backlabel.trailingAnchor, constant: -18),
            dailytasteCollectionView.heightAnchor.constraint(equalToConstant: 70),

            existButton.topAnchor.constraint(equalTo: background.bottomAnchor, constant: 35),
            existButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    @objc private func closeButtonTapped() {
        print("창 닫기 버튼 눌림")
        dismiss(animated: true, completion: nil)
    }
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
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
