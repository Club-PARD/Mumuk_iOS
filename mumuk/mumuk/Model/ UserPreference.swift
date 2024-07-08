//
//  UserPreference.swift
//  mumuk
//
//  Created by 유재혁 on 7/5/24.
//
import Foundation

    //json쓰려면 필요하니까 decodable(출력), encodable(입력)
struct UserPreference: Codable {
    let name: String
    let imageId: Int
    let spicyType: Bool
    let todayKoreanFood: Int?
    let todayJapaneseFood: Int?
    let todayChineseFood: Int?
    let todayWesternFood: Int?
    let todaySoutheastAsianFood: Int?
    let todayElseFood: Int?
    let todayMeat: Int?
    let todaySeafood: Int?
    let todayCarbohydrate: Int?
    let todayVegetable: Int?
    let redFood: Int?
    let notRedFood: Int?
    let todayRice: Int?
    let todayBread: Int?
    let todayNoodle: Int?
    let todayHeavy: Int?
    let todayLight: Int?
    let todaySoup: Int?
    let todayNoSoup: Int?
    let notToday: String?
    let foodType: String?
    let exceptionalFoods: [String]
    let daily: Bool
    
}
