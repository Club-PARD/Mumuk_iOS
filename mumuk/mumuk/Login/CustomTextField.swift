//
//  CustomTextField.swift
//  mumuk
//
//  Created by 유재혁 on 6/24/24.
//

//닉네임 입력하는 칸
import UIKit

class CustomTextField: UITextField {

    private let bottomLine = CALayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        borderStyle = .none
        textColor = .black
        font = UIFont.systemFont(ofSize: 25) // 글자 크기를 25포인트로 설정
       
        // placeholder 텍스트 색상 변경
        let placeholderText = "닉네임을 입력하세요."
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.lightGray // 원하는 색상으로 설정
        ]
        attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
        
        bottomLine.backgroundColor = UIColor.lightGray.cgColor
        layer.addSublayer(bottomLine)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        bottomLine.frame = CGRect(x: 0, y: frame.height - 1, width: frame.width, height: 1)
    }
}

