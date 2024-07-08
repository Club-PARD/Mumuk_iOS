//
//  underTagCell.swift
//  mumuk
//
//  Created by 유재혁 on 7/4/24.
//

import UIKit


//padding, 코너의 radius를 주기 위한 함수 추가
class PaddedLabelunder: UILabel {
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
    //    밑줄
    override var text: String? {
        didSet {
            guard let text = text else { return }
            let attributedText = NSMutableAttributedString(string: text)
            let range = NSRange(location: 0, length: attributedText.length)
            attributedText.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range)
            self.attributedText = attributedText
        }
    }
}
    
class underTagCell: UICollectionViewCell {

    let tagUnderline: PaddedLabelunder = {
        let label = PaddedLabelunder()
        label.textColor = UIColor(red: 0.58, green: 0.58, blue: 0.58, alpha: 1)
        label.font = UIFont(name: "Pretendard-SemiBold", size: 12)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setPadding(top: 1, left: 1, bottom: 1, right: 1)
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
    
    func configure(text: String, textColor: UIColor, font: UIFont) {
        tagUnderline.text = text
        tagUnderline.textColor = textColor // 텍스트 색상 설정
        tagUnderline.font = font // 글씨체와 글씨 크기 설정
    }
}


