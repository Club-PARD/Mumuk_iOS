//
//  FriendComponent.swift
//  mumuk
//
//  Created by 유재혁 on 6/30/24.
//

import UIKit

//padding, 코너의 radius를 주기 위한 함수 추가
class PaddedLabel: UILabel {
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
}

class FriendComponent: UITableViewCell {
    var name: String = ""
    let user = UILabel()
    let image = UIImageView()

    var exceptional: [String] = []
    var spicy: Bool = false
    var style: String = ""

    var tags: [String] = [] // 위에서 받은 tag들 여기로 다 모음
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "FriendComponent")
        self.name = ""  // 초기값 설정
        selectionStyle = .none // 셀이 선택되었을 때 색이 변하지 않도록 설정
        setupUI()
        setView() //이걸로 cell의 둥근정도와 간격 조정
        
        tagCollectionView.dataSource = self
        tagCollectionView.delegate = self
        tagCollectionView.register(TagCell.self, forCellWithReuseIdentifier: "TagCell")
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        selectionStyle = .none // 셀이 선택되었을 때 색이 변하지 않도록 설정
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //cell 상하좌우 간격조절
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 32, bottom: 10, right: 32))
    }
    
    //가로 collectionview 생성
    private let tagCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 8  //cell간격
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    //이름
    var nameLabel: UILabel =  {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-Bold", size: 24)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //이미지 들어가는 테두리
    var userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 35 // 반지름을 이미지 뷰의 절반으로 설정하여 원형으로 만듦
        imageView.layer.borderWidth = 2 // 테두리 두께 설정
        imageView.layer.borderColor = #colorLiteral(red: 1, green: 0.5921568627, blue: 0.1019607843, alpha: 1) // 테두리 색상 설정
        imageView.clipsToBounds = true // 이미지가 경계를 넘지 않도록 함
        return imageView
    }()

    //이미지 삽입하는 곳
    var userImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    
    let profileDetailButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(DetailButtonnPressed), for: .touchUpInside)
        
        // PaddedLabel 생성
        let label = PaddedLabel()
        label.text = "프로필 상세 〉"
        label.textColor = .white
        label.font = UIFont(name: "Pretendard-Regular", size: 10)
        label.textAlignment = .center
        label.setPadding(top: 3, left: 8, bottom: 3, right: 8)
        
        // 레이블의 배경 설정
        label.layer.cornerRadius = 10
        label.layer.backgroundColor = #colorLiteral(red: 1, green: 0.5921568627, blue: 0.1019607843, alpha: 1).cgColor
        label.clipsToBounds = true
        
        // 버튼에 레이블 추가
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
    
    func setView() {
        // Cell 둥근 모서리 적용(값이 커질수록 둥글)
        contentView.layer.cornerRadius = 15
        contentView.layer.masksToBounds = true // 이 줄을 추가하여 내용이 모서리를 벗어나지 않도록 합니다.
        
        // 그림자 효과 추가
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)    //그림자 위치.
        layer.shadowRadius = 5     //흐림반경. 값 클수록 넓고 흐릿
        layer.shadowOpacity = 1   //그림자의 투명도. 0.0(투명) ~ 1.0(불투명)
        layer.masksToBounds = false //경계 벗어나도록
    }
    
    private func setupUI() {
        self.backgroundColor = .clear
        contentView.backgroundColor = .white // contentView의 배경색 설정
        
        contentView.addSubview(userImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(profileDetailButton)
        contentView.addSubview(tagCollectionView)
        userImageView.addSubview(userImage)
        
        NSLayoutConstraint.activate([
            userImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -22),
            userImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25),
            userImageView.widthAnchor.constraint(equalToConstant: 70),
            userImageView.heightAnchor.constraint(equalToConstant: 70),
            
            userImage.centerXAnchor.constraint(equalTo: userImageView.centerXAnchor),
            userImage.centerYAnchor.constraint(equalTo: userImageView.centerYAnchor),
            userImage.widthAnchor.constraint(equalToConstant: 70),
            userImage.heightAnchor.constraint(equalToConstant: 70),
                     
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 33),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            nameLabel.heightAnchor.constraint(equalToConstant: 22),
                     
            profileDetailButton.centerXAnchor.constraint(equalTo: userImageView.centerXAnchor, constant: 0),
            profileDetailButton.heightAnchor.constraint(equalToConstant: 20),
            profileDetailButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -23),
            
            tagCollectionView.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            tagCollectionView.trailingAnchor.constraint(equalTo: userImageView.leadingAnchor, constant: -40),
            tagCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -23),
            tagCollectionView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
//    서버용으로 만든거
    func configure(with friend: FriendModel) {
        self.name = friend.name
        nameLabel.text = self.name
        
        // ModelData에서 friend.imageId 값에 해당하는 이미지 찾기
        if let model = Model.ModelData.first(where: { $0.number == friend.imageId }) {
            userImage.image = UIImage(named: model.image)
        } else {
            userImage.image = nil // 적절한 기본 이미지를 설정할 수 있음
        }
        
        self.exceptional = friend.exceptionalFoods.map {"#\($0) NO"}   //배열이라서 map함수로 새로운 배열 생성함
        self.spicy = friend.spicyType
        self.style = friend.foodTypes
        
        // tags 배열 초기화
        self.tags.removeAll()

        // spicy가 true일 경우 "매운 음식" 태그 추가
        if self.spicy {
            self.tags.append("#맵고수")
        } else {
            self.tags.append("#맵찔이")
        }

        // exceptional과 style을 tags 배열에 추가
        self.tags.append(contentsOf: self.exceptional)
        self.tags.append("#\(self.style)")  //애는 배열이 아니여서 그냥 이렇게 넣어도 됨
        
        tagCollectionView.reloadData()
    }

    
    //버튼 누르면 모달 뜨게 하기 위해서 뷰컨 연결하려고 추가 FriendViewController에서 불러서 쓸 수 있음
    weak var detailController: UIViewController?

    @objc private func DetailButtonnPressed() {
        print("디테일 눌림")
        let detailVC = DetailViewController()
        detailVC.modalPresentationStyle = .overFullScreen // 어떻게 모달 띄울지 설정
        detailVC.name = self.name
        detailController?.present(detailVC, animated: true, completion: nil)
    }
    
    
}

//이거 collectionview
extension FriendComponent: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCell", for: indexPath) as! TagCell
        cell.tagLabel.text = tags[indexPath.item]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let tag = tags[indexPath.item]
        let font = UIFont(name: "Pretendard-Regular", size: 12)
        let attributes = [NSAttributedString.Key.font: font]
        let size = (tag as NSString).size(withAttributes: attributes)
        return CGSize(width: size.width + 24, height: 30) // 패딩 고려
    }
}
