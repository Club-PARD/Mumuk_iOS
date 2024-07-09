//
//  underbordCell.swift
//  mumuk
//
//  Created by 유재혁 on 7/8/24.
//
import UIKit


//padding, 코너의 radius를 주기 위한 함수 추가

class underbordCell: UICollectionViewCell {

    let tagUnderline: PaddedLabelunder = {
        let label = PaddedLabelunder()
        label.textColor = #colorLiteral(red: 1, green: 0.5921568627, blue: 0.1019607843, alpha: 1)
        label.font = UIFont(name: "Pretendard-SemiBold", size: 13)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.cornerRadius = 14.5
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor(red: 1, green: 0.592, blue: 0.102, alpha: 1).cgColor
        label.setPadding(top: 6, left: 11, bottom: 6, right: 11)
        label.clipsToBounds = true
        
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.52
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(tagUnderline)
        NSLayoutConstraint.activate([
            tagUnderline.topAnchor.constraint(equalTo: contentView.topAnchor),
            tagUnderline.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            tagUnderline.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tagUnderline.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func configure(text: String, textColor: UIColor, font: UIFont) {
//        tagUnderline.text = text
//        tagUnderline.textColor = textColor // 텍스트 색상 설정
//        tagUnderline.font = font // 글씨체와 글씨 크기 설정
//    }
}


