//
//  ModalImageUpdate.swift
//  mumuk
//
//  Created by 유재혁 on 6/25/24.
//

import UIKit

class ModalImageUpdate: UIViewController {
    let cellidentifier = "cell"
    var selectedImage: UIImage?// 이미 설정된 이미지 불러오기위한 변수
    weak var delegate: ModalImageSelectDelegate?

    // 선택된 이미지의 인덱스와 모델 데이터 저장
    var selectedIndex: Int?
    var modelData: [Model] = Model.ModelData
    var uid: String = ""
    
    private var LoginTitle: UILabel =  {
        let label = UILabel()
        label.text = "프로필 이미지를 \n꾸며보세요"
        label.font = UIFont.systemFont(ofSize: 25, weight: .thin)
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()
    
    //화면 중앙에 뜨는 큰 이미지
    let selectedImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 60 // 적절한 반지름 값 설정
//        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.black.cgColor
        return imageView
    }()
    
    //collectionview생성
    let collectionview: UICollectionView = {
        let flowlayout = UICollectionViewFlowLayout()
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: flowlayout)
        collectionview.backgroundColor = .clear
        return collectionview
    }()
    
    //저장하기
    let selectButton: UIButton = {
        let button = UIButton()
        button.setTitle("저장", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 1, green: 0.5921088457, blue: 0.09662804753, alpha: 1)
        button.layer.cornerRadius = 28
        button.addTarget(self, action: #selector(selectButtonTapped), for: .touchUpInside)
        return button
     }()
    
    // 지우기 버튼
    let deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("지우기", for: .normal)
        button.setTitleColor(.orange, for: .normal)
        button.backgroundColor = #colorLiteral(red: 1, green: 0.9309261441, blue: 0.845400691, alpha: 1)
        button.layer.cornerRadius = 28
        button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        collectionview.dataSource = self
        collectionview.delegate = self
        collectionview.register(CustomCell.self, forCellWithReuseIdentifier: cellidentifier)
        
        view.addSubview(LoginTitle)
        view.addSubview(selectedImageView)
        view.addSubview(collectionview)
        view.addSubview(selectButton)
        view.addSubview(deleteButton)
        
        print(selectedImage)
        print(uid)
        
        setUI()
        
        //이미 고른 이미지 모달 창 열 때 불러오기
        if let image = selectedImage {
            selectedImageView.image = image
        }
    }
    
    func setUI() {
        LoginTitle.translatesAutoresizingMaskIntoConstraints = false
        selectedImageView.translatesAutoresizingMaskIntoConstraints = false
        collectionview.translatesAutoresizingMaskIntoConstraints = false
        selectButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.translatesAutoresizingMaskIntoConstraints = false

        
        NSLayoutConstraint.activate([
            LoginTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 32),
            LoginTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            LoginTitle.widthAnchor.constraint(equalToConstant: 164),
            LoginTitle.heightAnchor.constraint(equalToConstant: 70),
            
            selectedImageView.topAnchor.constraint(equalTo: LoginTitle.bottomAnchor, constant: 30),
            selectedImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            selectedImageView.widthAnchor.constraint(equalToConstant: 120),
            selectedImageView.heightAnchor.constraint(equalToConstant: 120),
            
            collectionview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            collectionview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            collectionview.heightAnchor.constraint(equalToConstant: 132),
            collectionview.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -160),
            
            selectButton.topAnchor.constraint(equalTo: collectionview.bottomAnchor, constant: 40),
            selectButton.trailingAnchor.constraint(equalTo: collectionview.trailingAnchor),
            selectButton.widthAnchor.constraint(equalToConstant: 186),
            selectButton.heightAnchor.constraint(equalToConstant: 56),
            
            deleteButton.topAnchor.constraint(equalTo: collectionview.bottomAnchor, constant: 40),
            deleteButton.leadingAnchor.constraint(equalTo: collectionview.leadingAnchor),
            deleteButton.widthAnchor.constraint(equalToConstant: 127),
            deleteButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }

    @objc func selectButtonTapped() {
        if let selectedIndex = selectedIndex {
            let selectedNumber = modelData[selectedIndex].number
            delegate?.didSelectImage(withNumber: selectedNumber)
            dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func deleteButtonTapped() {
//            delegate?.didSelectImage(withNumber: 0)
//            dismiss(animated: true, completion: nil)
        
        // 기본 이미지로 업데이트
        let defaultImage = UIImage(named: "default") // 여기에 기본 이미지 이름을 넣으세요
        updateSelectedImage(with: defaultImage, at: 0)
        
        }

    //프로필 누룰 때 마다 실행
    func updateSelectedImage(with image: UIImage?, at index: Int) {
        selectedImageView.image = image
        selectedIndex = index
    }
}

extension ModalImageUpdate: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Model.ModelData.count - 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellidentifier, for: indexPath) as? CustomCell else {
            print("error using collectionView")
            return UICollectionViewCell()
        }
        
        cell.backgroundColor = .clear
        let target = Model.ModelData[indexPath.item + 1]
        let image = UIImage(named: "\(target.image).jpeg")
        cell.imageView.image = image
        cell.imageView.tag = indexPath.item+1 // 태그를 사용하여 셀의 인덱스 저장
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let target = Model.ModelData[indexPath.item + 1]
        let image = UIImage(named: "\(target.image).jpeg")
        updateSelectedImage(with: image, at: indexPath.item+1)    //선택한 이미지 큰 곳에 전송
    }
}

extension ModalImageUpdate: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth: CGFloat = 62
        let itemHeight: CGFloat = 62
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 1, bottom: 0, right: 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}
