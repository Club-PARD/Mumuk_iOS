//
//  Model.swift
//  mumuk
//
//  Created by 유재혁 on 6/25/24.
//

//프로필 사진들
import Foundation


struct Model{
    var number : Int
    var image : String
}

#if DEBUG

extension Model{
    
    static var ModelData = [
        Model(number: 0, image: "default"),
        Model(number: 1, image: "red"),
        Model(number: 2, image: "blue"),
        Model(number: 3, image: "예시"),
        Model(number: 4, image: "default"),
        Model(number: 5, image: "red"),
        Model(number: 6, image: "blue"),
        Model(number: 7, image: "예시"),
        Model(number: 8, image: "default"),
        Model(number: 9, image: "red"),
        Model(number: 10, image: "blue"),
        Model(number: 11, image: "blue"),
        Model(number: 12, image: "예시"),
        Model(number: 13, image: "default"),
        Model(number: 14, image: "red"),
        Model(number: 15, image: "blue"),
    ]
}
#endif
