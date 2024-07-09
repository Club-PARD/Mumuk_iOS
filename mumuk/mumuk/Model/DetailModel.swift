//
//  DetailModel.swift
//  mumuk
//
//  Created by 유재혁 on 7/3/24.
//

import Foundation

    //json쓰려면 필요하니까 decodable(출력), encodable(입력)
struct DetailModel: Decodable, Encodable {
    // 이건 데이터 형식만 설정해주는 부분
    let uid: String
    let name: String
    let image: Int?


}
