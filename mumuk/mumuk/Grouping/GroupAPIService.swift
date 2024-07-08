//
//  GroupAPIService.swift
//  mumuk
//
//  Created by 김현중 on 7/5/24.
//

import Foundation

struct GroupUser: Codable, Equatable {
    let name: String
    let imageId: Int
    let spicyType: Bool
    let daily: Bool
    let foodType: String?
    let foodTypes: String?
    let exceptionalFoods: [String]
    
    // Daily true인 경우의 추가 필드들
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
    
    // Daily false인 경우의 추가 필드들
    let koreanFood: Int?
    let japaneseFood: Int?
    let chineseFood: Int?
    let westernFood: Int?
    let southeastAsianFood: Int?
    let elseFood: Int?

    // Equatable 프로토콜 준수를 위해 == 연산자 구현
    static func == (lhs: GroupUser, rhs: GroupUser) -> Bool {
        return lhs.name == rhs.name &&
               lhs.imageId == rhs.imageId &&
               lhs.spicyType == rhs.spicyType &&
               lhs.daily == rhs.daily &&
               lhs.foodType == rhs.foodType &&
               lhs.foodTypes == rhs.foodTypes &&
               lhs.exceptionalFoods == rhs.exceptionalFoods &&
               lhs.todayKoreanFood == rhs.todayKoreanFood &&
               lhs.todayJapaneseFood == rhs.todayJapaneseFood &&
               lhs.todayChineseFood == rhs.todayChineseFood &&
               lhs.todayWesternFood == rhs.todayWesternFood &&
               lhs.todaySoutheastAsianFood == rhs.todaySoutheastAsianFood &&
               lhs.todayElseFood == rhs.todayElseFood &&
               lhs.todayMeat == rhs.todayMeat &&
               lhs.todaySeafood == rhs.todaySeafood &&
               lhs.todayCarbohydrate == rhs.todayCarbohydrate &&
               lhs.todayVegetable == rhs.todayVegetable &&
               lhs.redFood == rhs.redFood &&
               lhs.notRedFood == rhs.notRedFood &&
               lhs.todayRice == rhs.todayRice &&
               lhs.todayBread == rhs.todayBread &&
               lhs.todayNoodle == rhs.todayNoodle &&
               lhs.todayHeavy == rhs.todayHeavy &&
               lhs.todayLight == rhs.todayLight &&
               lhs.todaySoup == rhs.todaySoup &&
               lhs.todayNoSoup == rhs.todayNoSoup &&
               lhs.notToday == rhs.notToday &&
               lhs.koreanFood == rhs.koreanFood &&
               lhs.japaneseFood == rhs.japaneseFood &&
               lhs.chineseFood == rhs.chineseFood &&
               lhs.westernFood == rhs.westernFood &&
               lhs.southeastAsianFood == rhs.southeastAsianFood &&
               lhs.elseFood == rhs.elseFood
    }
}

struct GroupResponse: Codable, Equatable {
    let users: [String: GroupUser]
    
    init(users: [String: GroupUser]) {
        self.users = users
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        users = try container.decode([String: GroupUser].self)
    }
    
    // Equatable 프로토콜 준수를 위해 == 연산자 구현
    static func == (lhs: GroupResponse, rhs: GroupResponse) -> Bool {
        return lhs.users == rhs.users
    }
}


class APIService {
    static func fetchGroupData(groupId: String, completion: @escaping (Result<GroupResponse, Error>) -> Void) {
        let urlString = "http://172.30.1.44:8080/with-pref/daily/group?groupId=\(groupId)"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let groupResponse = try decoder.decode(GroupResponse.self, from: data)
                completion(.success(groupResponse))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
