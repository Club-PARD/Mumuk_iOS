//
//  exampleModel.swift
//  mumuk
//
//  Created by 유재혁 on 6/30/24.
//

//import UIKit
//
//struct exampleModel {
//    let name: String
//    let tags: [String]
//    let user: String
//    let image: String
//}
//
//extension exampleModel {
//    static let modeling = [
//        [
//            exampleModel(name: "맛있으면움", tags: ["#맵찔이", "#땅콩 알러지"], user: "애기 입맛 유저", image: "babe"),
//        ],
//        [   exampleModel(name: "김현중짱", tags: ["#맵마왕", "#해산물 알러지", "비건"], user: "맵살맵죽 유저", image: "hot"),
//
//        ],
//        [   exampleModel(name: "넌뭘먹고사니", tags: ["#채소극혐", "#샐러드 NO", "아무거나"], user: "고기 조아 유저", image: "lion"),
//        ],
//            [exampleModel(name: "니가밥골라와", tags: ["#달달구리X", "#인스턴트 NO"], user: "건강 최고 유저", image: "arm"),
//        ],
//    ]
//}


import Foundation

struct ExampleModel: Codable {
    let name: String
    let tags: [String]
    let user: String
    let image: String
}

class ExampleModelData {
    static var modeling: [[ExampleModel]] {
        get {
            if let data = UserDefaults.standard.data(forKey: "modelingData"),
               let decodedModeling = try? JSONDecoder().decode([[ExampleModel]].self, from: data) {
                return decodedModeling
            }
            return defaultModeling
        }
        set {
            if let encoded = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(encoded, forKey: "modelingData")
            }
        }
    }
    
    private static let defaultModeling: [[ExampleModel]] = [
        [
            ExampleModel(name: "맛있으면움", tags: ["#맵찔이", "#땅콩 알러지"], user: "애기 입맛 유저", image: "babe"),
        ],
        [
            ExampleModel(name: "김현중짱", tags: ["#맵마왕", "#해산물 알러지", "비건"], user: "맵살맵죽 유저", image: "hot"),
        ],
        [
            ExampleModel(name: "넌뭘먹고사니", tags: ["#채소극혐", "#샐러드 NO", "아무거나"], user: "고기 조아 유저", image: "lion"),
        ],
        [
            ExampleModel(name: "니가밥골라와", tags: ["#달달구리X", "#인스턴트 NO"], user: "건강 최고 유저", image: "arm"),
        ],
    ]
    
    static func saveModeling() {
        if let encoded = try? JSONEncoder().encode(modeling) {
            UserDefaults.standard.set(encoded, forKey: "modelingData")
        }
    }
    
    //일단 이걸 추가해서 앱을 킬 때 삭제된 항목 다시 되돌리려고 합니다.
    static func resetToDefault() {
        UserDefaults.standard.removeObject(forKey: "modelingData")
    }
}
