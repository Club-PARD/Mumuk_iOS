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

extension Model{
    
    public static var ModelData = [
        Model(number: 0, image: "default"),
        Model(number: 1, image: "tory_1"),
        Model(number: 2, image: "tory_2"),
        Model(number: 3, image: "tory_3"),
        Model(number: 4, image: "mu1"),
        Model(number: 5, image: "mu2"),
        Model(number: 6, image: "mu3"),
    ]
}
