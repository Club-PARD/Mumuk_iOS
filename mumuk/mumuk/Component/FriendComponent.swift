//
//  FriendComponent.swift
//  mumuk
//
//  Created by 유재혁 on 6/30/24.
//

import UIKit

//padding을 주기 위한 함수 추가
class PaddedLabel: UILabel {
    var insets = UIEdgeInsets.zero
    
    override func drawText(in rect: CGRect) {
        let paddedRect = rect.inset(by: insets)
        super.drawText(in: paddedRect)
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + insets.left + insets.right,
                      height: size.height + insets.top + insets.bottom)
    }

    func setPadding(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) {
        self.insets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        setNeedsDisplay()
    }
}



class FriendComponent: UITableViewCell {
    let name = UILabel()
    let tag1 = UILabel()
    let tag2 = UILabel()
    let user = UILabel()
    let image = UIImageView()
    
    private var tags: [String] = []

    
//    weak var delegate: FriendComponentDelegate? //버튼 눌렀을 때 액션 delegate
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "FriendComponent")
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
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
//    //#첫번째
//    var tag1Label: PaddedLabel! = {
//        var label = PaddedLabel()
//        label.textColor = UIColor(red: 1, green: 0.592, blue: 0.102, alpha: 1)
//        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
//        label.textAlignment = .center
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.setPadding(top: 7, left: 12, bottom: 7, right: 12)  // 패딩을 0으로 설정
//
//        // labelview의 외부 데코레이션
//        label.layer.cornerRadius = 8
//        label.layer.borderWidth = 1
//        label.layer.backgroundColor = UIColor(red: 1, green: 0.592, blue: 0.102, alpha: 0.06).cgColor
//        label.layer.borderColor = UIColor(red: 1, green: 0.592, blue: 0.102, alpha: 1).cgColor
//        label.clipsToBounds = true  // 이 줄은 레이블의 코너 반경을 적용하는 데 필요합니다
//        return label
//    }()
//    
//
//    
//    var tag2Label: PaddedLabel! = {
//        var label = PaddedLabel()
//        label.textColor = UIColor(red: 1, green: 0.592, blue: 0.102, alpha: 1)
//        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
//        label.textAlignment = .center
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.setPadding(top: 7, left: 12, bottom: 7, right: 12)  // 패딩을 0으로 설정
//        
//        // labelview의 외부 데코레이션
//        label.layer.cornerRadius = 8
//        label.layer.borderWidth = 1
//        label.layer.backgroundColor = UIColor(red: 1, green: 0.592, blue: 0.102, alpha: 0.06).cgColor
//        label.layer.borderColor = UIColor(red: 1, green: 0.592, blue: 0.102, alpha: 1).cgColor
//        label.clipsToBounds = true  // 이 줄은 레이블의 코너 반경을 적용하는 데 필요합니다
//        return label
//    }()
    

    
    //이미지 들어가는 테두리
    var userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
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
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    
    
 
    
    //    var userLabel: PaddedLabel! = {
    //        var label = PaddedLabel()
    //        label.textColor = UIColor.white
    //        label.font = UIFont.systemFont(ofSize: 10, weight: .bold)
    //        label.translatesAutoresizingMaskIntoConstraints = false
    //        label.setPadding(top: 0, left: 8, bottom: 0, right: 8)  // 패딩을 0으로 설정
    //
    //        // labelview의 외부 데코레이션
    //        label.layer.cornerRadius = 10
    //        label.layer.backgroundColor = #colorLiteral(red: 1, green: 0.5921568627, blue: 0.1019607843, alpha: 1)
    //        label.clipsToBounds = true  // 이 줄은 레이블의 코너 반경을 적용하는 데 필요합니다
    //        return label
    //    }()
    
    
    let profileDetailButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(DetailButtonnPressed), for: .touchUpInside)
        
        // PaddedLabel 생성
        let label = PaddedLabel()
        label.text = "프로필 상세 〉"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 10, weight: .bold)
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
        layer.shadowOffset = CGSize(width: 0, height: 0)    //그림자 위치. 아래쪽으로 4
        layer.shadowRadius = 5     //흐림반경. 값 클수록 넓고 흐릿
        layer.shadowOpacity = 1   //그림자의 투명도. 0.0(투명) ~ 1.0(불투명)
        layer.masksToBounds = false //경계 벗어나도록
    }
    
    private func setupUI() {
        self.backgroundColor = .clear
        contentView.backgroundColor = .white // contentView의 배경색 설정
        
        contentView.addSubview(userImageView)
        contentView.addSubview(nameLabel)
//        contentView.addSubview(tag1Label)
//        contentView.addSubview(tag2Label)
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
            userImage.widthAnchor.constraint(equalToConstant: 35),
            userImage.heightAnchor.constraint(equalToConstant: 35),
                     
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 33),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            nameLabel.heightAnchor.constraint(equalToConstant: 22),
                     
//            tag1Label.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
//            tag1Label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -23),
//                     
//            tag2Label.leadingAnchor.constraint(equalTo: tag1Label.trailingAnchor, constant: 12),
//            tag2Label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -23),
                     
            profileDetailButton.centerXAnchor.constraint(equalTo: userImageView.centerXAnchor, constant: 0),
            profileDetailButton.heightAnchor.constraint(equalToConstant: 20),
            profileDetailButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -23),
            
            tagCollectionView.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            tagCollectionView.trailingAnchor.constraint(equalTo: userImageView.leadingAnchor, constant: -40),
            tagCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -23),
            tagCollectionView.heightAnchor.constraint(equalToConstant: 30)
            
        ])
    }
    
//    func configure(with memo: FriendModel) {
//        print("configure 실행")
////        partLabel.text = "[\(memo.part)]"
////        nameLabel.text = memo.name
//    }
    
    //이거 tags로 뭉친거 해보는 중
    func configure(with friend: ExampleModel) {
        nameLabel.text = friend.name
        tags = friend.tags
        userImage.image = UIImage(named: friend.image)
        
        tagCollectionView.reloadData()
    }
    
    //tag1, tag2 할 때 쓰던거
//    func configure(with friend: exampleModel) {
//        nameLabel.text = friend.name
//        tag1Label.text = friend.tag1
//        tag2Label.text = friend.tag2
////        userLabel.text = friend.user
//        userImage.image = UIImage(named: friend.image)
//        
//        if let image = UIImage(named: friend.image) {
//            userImage.image = image
//        }
//    }
    
    //서버용으로 만든거
//    func configure(with friend: FriendModel) {
//        nameLabel.text = friend.name
//        tag1Label.text = friend.tag1
//        tag2Label.text = friend.tag2
//
//        // ModelData에서 friend.image 값에 해당하는 이미지 찾기
//        if let model = Model.ModelData.first(where: { $0.number == friend.image }) {
//            userImage.image = UIImage(named: model.image)
//        } else {
//            userImage.image = nil // 적절한 기본 이미지를 설정할 수 있음
//        }
//    }
    
    
    //버튼 누르면 모달 뜨게 하기 위해서 뷰컨 연결하려고 추가 FriendViewController에서 불러서 쓸 수 있음
    weak var detailController: UIViewController?

    @objc private func DetailButtonnPressed() {
        print("디테일 눌림")
        let detailVC = DetailViewController()
        detailVC.modalPresentationStyle = .formSheet // 어떻게 모달 띄울지 설정
        detailController?.present(detailVC, animated: true, completion: nil)
    }
    
    
}

//// Protocol to notify button press to the controller
//protocol FriendComponentDelegate: AnyObject {
//    func didTapDetailButton(with cell: FriendComponent)
//}




//이거 collectionview 도전중
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
        let font = UIFont.systemFont(ofSize: 12, weight: .light)
        let attributes = [NSAttributedString.Key.font: font]
        let size = (tag as NSString).size(withAttributes: attributes)
        return CGSize(width: size.width + 24, height: 30) // 패딩 고려
    }
}
