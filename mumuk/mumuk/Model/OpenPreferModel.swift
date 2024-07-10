<<<<<<< HEAD


import Foundation

struct OpenPreferModel : Codable{
    
    var exceptionalFoods: [String]
    
    var spicyType : Bool
    
    var koreanFood : Int
    var westernFood : Int
    var chineseFood : Int
    var japaneseFood : Int
    var southeastAsianFood : Int
    var elseFood : Int
    
    var foodTypeId : Int
    

    
=======
import Foundation

struct OpenPreferModel: Codable {
    var exceptionalFoods: [String]
    var spicyType: Bool
    var koreanFood: Int
    var westernFood: Int
    var chineseFood: Int
    var japaneseFood: Int
    var southeastAsianFood: Int
    var elseFood: Int
    var foodTypeId: Int

    init(
        exceptionalFoods: [String] = [],
        spicyType: Bool = false,
        koreanFood: Int = 0,
        westernFood: Int = 0,
        chineseFood: Int = 0,
        japaneseFood: Int = 0,
        southeastAsianFood: Int = 0,
        elseFood: Int = 0,
        foodTypeId: Int = 0
    ) {
        self.exceptionalFoods = exceptionalFoods
        self.spicyType = spicyType
        self.koreanFood = koreanFood
        self.westernFood = westernFood
        self.chineseFood = chineseFood
        self.japaneseFood = japaneseFood
        self.southeastAsianFood = southeastAsianFood
        self.elseFood = elseFood
        self.foodTypeId = foodTypeId
    }

//    enum CodingKeys: String, CodingKey {
//        case exceptionalFoods, spicyType, koreanFood, westernFood, chineseFood, japaneseFood, southeastAsianFood, elseFood, foodTypeId
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.exceptionalFoods = try container.decodeIfPresent([String].self, forKey: .exceptionalFoods) ?? []
//        self.spicyType = try container.decodeIfPresent(Bool.self, forKey: .spicyType) ?? false
//        self.koreanFood = try container.decodeIfPresent(Int.self, forKey: .koreanFood) ?? 0
//        self.westernFood = try container.decodeIfPresent(Int.self, forKey: .westernFood) ?? 0
//        self.chineseFood = try container.decodeIfPresent(Int.self, forKey: .chineseFood) ?? 0
//        self.japaneseFood = try container.decodeIfPresent(Int.self, forKey: .japaneseFood) ?? 0
//        self.southeastAsianFood = try container.decodeIfPresent(Int.self, forKey: .southeastAsianFood) ?? 0
//        self.elseFood = try container.decodeIfPresent(Int.self, forKey: .elseFood) ?? 0
//        self.foodTypeId = try container.decodeIfPresent(Int.self, forKey: .foodTypeId) ?? 0
//    }
>>>>>>> hj_branch
}
