////
////  PokeIndividualData.swift
////  NationalPokedex
////
////  Created by Akihiro Matsuyama on 2024/04/05.
////
//
//import Foundation
//
///// 個体について
//struct PokeIndividual: Codable, Hashable {
//    let id: Int              // 図鑑番号
//    let name: String         // 名前
//    let sprites: Sprites     // 画像
//    let height: Int          // 身長 cm
//    let weight: Int          // 体重 cg
//    let types: [PokeType]    // ポケモンタイプ
//
//    private enum CodingKeys: String, CodingKey {
//        case id
//        case name
//        case sprites
//        case height
//        case weight
//        case types
//    }
//}
//
//struct Sprites: Codable, Hashable {
//    // ポケモンそれぞれの角度からの画像
//    let backDefault: String?
//    let backFemale: String?
//    let backShiny: String?
//    let backShinyFemale: String?
//    let frontDefault: String?
//    let frontFemale: String?
//    let frontShiny: String?
//    let frontShinyFemale: String?
//
//    private enum CodingKeys: String, CodingKey {
//        case backDefault = "back_default"
//        case backFemale = "back_female"
//        case backShiny = "back_shiny"
//        case backShinyFemale = "back_shiny_female"
//        case frontDefault = "front_default"
//        case frontFemale = "front_female"
//        case frontShiny = "front_shiny"
//        case frontShinyFemale = "front_shiny_female"
//    }
//}
//
//struct PokeType: Identifiable, Codable, Hashable {
//    let id: Int
//    let type: NameAndUrl
//
//    private enum CodingKeys: String, CodingKey {
//        case id = "slot"
//        case type
//    }
//}
//
//extension PokeIndividual {
//    // フシギダネ
//    static let mock = PokeIndividual(id: 1,
//                                     name: "bulbasaur",
//                                     sprites: Sprites(backDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/1.png",
//                                                      backFemale: nil,
//                                                      backShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/1.png",
//                                                      backShinyFemale: nil,
//                                                      frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png",
//                                                      frontFemale: nil,
//                                                      frontShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/1.png",
//                                                      frontShinyFemale: nil),
//                                     height: 7,
//                                     weight: 69,
//                                     types: [
//                                        PokeType(id: 1, type: NameAndUrl(name: "grass", url: "https://pokeapi.co/api/v2/type/12/")),
//                                        PokeType(id: 2, type: NameAndUrl(name: "poison", url: "https://pokeapi.co/api/v2/type/4/"))
//                                     ])
//}
