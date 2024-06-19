////
////  PokeSpecies.swift
////  NationalPokedex
////
////  Created by Akihiro Matsuyama on 2024/04/09.
////
//
//import Foundation
//
///// 種について
//struct PokeSpecies: Codable, Hashable {
//    let id: Int                         // 図鑑番号
//    let color: NameAndUrl               // ポケモンの色
//    let evolutionChain: EvolutionChain  // 名前
//    let genera: [Genera]                // 属
//    let names: [Name]                   // 多言語での名前
//    let flavorTextEntries: [FlavorTextEntries]
//
//    private enum CodingKeys: String, CodingKey {
//        case id
//        case color
//        case evolutionChain = "evolution_chain"
//        case genera
//        case names
//        case flavorTextEntries = "flavor_text_entries"
//    }
//}
//
//struct EvolutionChain: Codable, Hashable {
//    let url: String
//}
//
//struct Genera: Codable, Hashable {
//    let genus: String
//    let language: NameAndUrl
//}
//
//struct Name: Codable, Hashable {
//    let name: String
//    let language: NameAndUrl
//}
//
//struct FlavorTextEntries: Codable, Hashable {
//    let flavorText: String
//    let language: NameAndUrl
//
//    private enum CodingKeys: String, CodingKey {
//        case flavorText = "flavor_text"
//        case language
//    }
//}
//
//struct NameAndUrl:Codable, Hashable {
//    let name: String
//    let url: String
//}
//
//extension PokeSpecies {
//    // フシギダネ
//    static let mock = PokeSpecies(
//        id: 1,
//        color: NameAndUrl(name: "green",
//                          url: "https://pokeapi.co/api/v2/pokemon-color/5/"),
//        evolutionChain: EvolutionChain(url: "https://pokeapi.co/api/v2/evolution-chain/1/"),
//        genera: [
//            Genera(genus: "たねポケモン", language: NameAndUrl(name: "ja-Hrkt", url: "https://pokeapi.co/api/v2/language/1/"))],
//        names: [
//            Name(
//                name: "フシギダネ",
//                language: NameAndUrl(
//                    name: "ja",
//                    url: "https://pokeapi.co/api/v2/language/1/"
//                )
//            )
//        ],
//        flavorTextEntries: [FlavorTextEntries(
//            flavorText: "生まれて　しばらくの　あいだ 背中の　タネに　つまった 栄養を　とって　育つ。",
//            language: NameAndUrl(
//                name: "ja",
//                url: "https://pokeapi.co/api/v2/language/11/"
//            )
//        )]
//    )
//}
