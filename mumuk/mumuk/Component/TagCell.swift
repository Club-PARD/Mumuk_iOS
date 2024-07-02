//
//  TagCell.swift
//  mumuk
//
//  Created by 유재혁 on 7/2/24.
//

//tag 라벨설정
import UIKit

class TagCell: UICollectionViewCell {
    let tagLabel: PaddedLabel = {
        let label = PaddedLabel()
        label.textColor = UIColor(red: 1, green: 0.592, blue: 0.102, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setPadding(top: 4, left: 7, bottom: 4, right: 7)
        label.layer.cornerRadius = 8
        label.layer.borderWidth = 1
        label.layer.backgroundColor = UIColor(red: 1, green: 0.592, blue: 0.102, alpha: 0.06).cgColor
        label.layer.borderColor = UIColor(red: 1, green: 0.592, blue: 0.102, alpha: 1).cgColor
        label.clipsToBounds = true
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(tagLabel)
        NSLayoutConstraint.activate([
            tagLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            tagLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
//            tagLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            tagLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
