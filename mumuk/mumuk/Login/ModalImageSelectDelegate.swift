//
//  ModalImageSelectDelegate.swift
//  mumuk
//
//  Created by 유재혁 on 6/26/24.
//

import Foundation

protocol ModalImageSelectDelegate: AnyObject {
    func didSelectImage(withNumber number: Int)
}
