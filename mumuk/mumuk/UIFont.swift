//
//  UIFont.swift
//  mumuk
//
//  Created by 김현중 on 6/30/24.
//

import UIKit

extension UIFont {
    enum PretendardStyle: String {
        case black = "Pretendard-Black"
        case bold = "Pretendard-Bold"
        case extraBold = "Pretendard-ExtraBold"
        case extraLight = "Pretendard-ExtraLight"
        case light = "Pretendard-Light"
        case medium = "Pretendard-Medium"
        case regular = "Pretendard-Regular"
        case semiBold = "Pretendard-SemiBold"
        case thin = "Pretendard-Thin"
    }
    
    static func pretendard(_ style: PretendardStyle = .regular, size: CGFloat = UIFont.systemFontSize) -> UIFont {
        return UIFont(name: style.rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
