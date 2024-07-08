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
    
//    
//    init(name: String, imageId: Int, spicyType: Bool, todayKoreanFood: Int, todayJapaneseFood: Int, todayChineseFood: Int, todayWesternFood: Int, todaySoutheastAsianFood: Int, todayElseFood: Int, todayMeat: Int, todaySeafood: Int, todayCarbohydrate: Int, todayVegetable: Int, redFood: Int, notRedFood: Int, todayRice: Int, todayBread: Int, todayNoodle: Int, todayHeavy: Int, todayLight: Int, todaySoup: Int, todayNoSoup: Int, notToday: String, foodType: String, exceptionalFoods: [String], daily: Bool ) {
//        self.name =
//        self.imageId: Int
//        self.spicyType: Bool
//        self.todayKoreanFood: Int
//        self.todayJapaneseFood: Int
//        self.todayChineseFood: Int
//        self.todayWesternFood: Int
//        self.todaySoutheastAsianFood: Int
//        self.todayElseFood: Int
//        self.todayMeat: Int
//        self.todaySeafood: Int
//        self.todayCarbohydrate: Int
//        self.todayVegetable: Int
//        self.redFood: Int
//        self.notRedFood: Int
//        self.todayRice: Int
//        self.todayBread: Int
//        self.todayNoodle: Int
//        self.todayHeavy: Int
//        self.todayLight: Int
//        self.todaySoup: Int
//        self.todayNoSoup: Int
//        self.notToday: String
//        self.foodType: String
//        self.exceptionalFoods: [String]
//        self.daily: Bool
//    }
//    
//    
    //    //얘는 약간 초기함수처럼 쓰이는데 데이터 값 받아올 때 입력 되게 설정하는거임. id는 비어있어야하는데 값이 입력되면 안되니깐 이렇게 설정해서 nil 넣어주는거임
    //    init(name: String, image: Int, grouped: Bool = false, daily: Bool = false) {
    //        self.name = name
    //        self.imageId = image
    //        self.grouped = grouped
    //        self.daily = daily
    //    }
}
