//
//  GroupAPIService.swift
//  mumuk
//
//  Created by 김현중 on 7/5/24.
//

import Foundation

struct GroupUser: Codable {
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
}

struct GroupResponse: Codable {
    let users: [String: GroupUser]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        users = try container.decode([String: GroupUser].self)
    }
}

class APIService {
    static func fetchGroupData(groupId: String, completion: @escaping (Result<GroupResponse, Error>) -> Void) {
        let urlString = "https:/mumuk.store/with-pref/daily/group?groupId=\(groupId)"
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
