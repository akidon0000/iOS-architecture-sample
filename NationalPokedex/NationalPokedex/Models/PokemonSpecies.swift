//
//  PokemonSpecies.swift
//  NationalPokedex
//
//  Created by Akihiro Matsuyama on 2024/04/09.
//

import Foundation

// 種について
struct PokemonSpecies: Codable {
    let id: Int                         // 図鑑番号
    let color: NameAndUrl               // ポケモンの色
    let evolutionChain: EvolutionChain  // 名前
    let genera: [Genera]                // 属
    let names: [Name]                   // 多言語での名前

    private enum CodingKeys: String, CodingKey {
        case id
        case color
        case evolutionChain = "evolution_chain"
        case genera
        case names
    }
}

struct EvolutionChain: Codable {
    let url: String
}

struct Genera: Codable {
    let genus: String
    let language: NameAndUrl
}

struct Name: Codable {
    let name: String
    let language: NameAndUrl
}

struct NameAndUrl:Hashable, Codable {
    let name: String
    let url: String
}

extension PokemonSpecies {
    static let mockPokemonSpecies = PokemonSpecies(id: 1,
                                                   color: NameAndUrl(name: "green",
                                                                     url: "https://pokeapi.co/api/v2/pokemon-color/5/"),
                                                   evolutionChain: EvolutionChain(url: "https://pokeapi.co/api/v2/evolution-chain/1/"),
                                                   genera: [
                                                    Genera(genus: "たねポケモン", language: NameAndUrl(name: "ja-Hrkt", url: "https://pokeapi.co/api/v2/language/1/"))],
                                                   names: [
                                                    Name(name: "フシギダネ", language: NameAndUrl(name: "ja-Hrkt", url: "https://pokeapi.co/api/v2/language/1/"))
                                                   ])
}
