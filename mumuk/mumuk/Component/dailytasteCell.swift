//
//  dailytasteCell.swift
//  mumuk
//
//  Created by 유재혁 on 7/4/24.
//

import UIKit

class dailytasteCell: UICollectionViewCell {

    let dailytaste: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont(name: "Pretendard-SemiBold", size: 13)
        label.layer.backgroundColor = UIColor(red: 1, green: 0.592, blue: 0.102, alpha: 1).cgColor
        label.layer.cornerRadius = 14.5

        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.layer.cornerRadius = 14.5
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor(red: 1, green: 0.592, blue: 0.102, alpha: 1).cgColor
        return label
    }()
    
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(dailytaste)
        NSLayoutConstraint.activate([
            dailytaste.topAnchor.constraint(equalTo: contentView.topAnchor),
            dailytaste.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            dailytaste.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dailytaste.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure(text: String, textColor: UIColor, font: UIFont, backgroundColor: UIColor) {
        dailytaste.text = text
        dailytaste.textColor = textColor // 텍스트 색상 설정
        dailytaste.font = font // 글씨체와 글씨 크기 설정
        dailytaste.backgroundColor = backgroundColor
    }
}
