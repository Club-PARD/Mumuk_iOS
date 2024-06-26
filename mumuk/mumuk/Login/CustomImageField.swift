//
//  CustomImageField.swift
//  mumuk
//
//  Created by 유재혁 on 6/25/24.
//

//
import UIKit

class CustomImageField: UIView {

    private var circleView: UIView!
    private var imageView: UIImageView!

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
    
    private func setupViews() {
        // 원 모양의 UIView 생성
        circleView = UIView()
        circleView.backgroundColor = UIColor.clear
        circleView.layer.cornerRadius = 59 // 반지름을 59로 설정 (직경 118)
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
            circleView.widthAnchor.constraint(equalToConstant: 118),
            circleView.heightAnchor.constraint(equalToConstant: 118),

            // imageView 제약 조건 설정
            imageView.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: circleView.centerYAnchor),
            imageView.widthAnchor.constraint(equalTo: circleView.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: circleView.heightAnchor)
        ])
    }
    
    func setImageWithName(_ name: Int) {
        print(name)
        var imageName = "default" // Default image name
        
        // Find the model with the corresponding number
        if let model = Model.ModelData.first(where: { $0.number == name }) {
            imageName = model.image
        }
        
        image = UIImage(named: imageName)
        print(imageName)
    }
}
