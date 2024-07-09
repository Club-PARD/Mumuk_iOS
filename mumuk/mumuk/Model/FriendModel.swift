//
//  FriendModel.swift
//  mumuk
//
//  Created by 유재혁 on 6/30/24.
//

import Foundation

    //json쓰려면 필요하니까 decodable(출력), encodable(입력)
struct FriendModel: Decodable, Encodable {
    // 이건 데이터 형식만 설정해주는 부분
    let name: String
    let imageId: Int
    let spicyType: Bool
    let foodTypes: String
    let exceptionalFoods: [String]
}
