//
//  CustomCell.swift
//  mumuk
//
//  Created by 유재혁 on 6/25/24.
//

//프로필 이미지 꾸미기 할 때 가져올 이미지들 형식
import UIKit

class CustomCell: UICollectionViewCell {
    var circleView: UIView!
    var imageView: UIImageView!

    var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    func configuration(with image: UIImage){
        imageView.image = image
    }
    
    private func setupViews() {
        // 원 모양의 UIView 생성
        circleView = UIView()
        circleView.backgroundColor = UIColor.clear
        circleView.layer.cornerRadius = 31 // 반지름을 31로 설정 (직경 62)
        circleView.clipsToBounds = true

        // UIImageView를 원 안에 맞춰서 추가
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit  // 이미지를 원 안에 맞춰서 표시

        // Add imageView as subview of circleView
        circleView.addSubview(imageView)
        addSubview(circleView)

        // Auto Layout 설정
        circleView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            // circleView 제약 조건 설정
            circleView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            circleView.widthAnchor.constraint(equalToConstant: 62),
            circleView.heightAnchor.constraint(equalToConstant: 62),

            // imageView 제약 조건 설정
            imageView.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: circleView.centerYAnchor),
            imageView.widthAnchor.constraint(equalTo: circleView.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: circleView.heightAnchor)
        ])
    }
}
