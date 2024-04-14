//
//  PokeDetail.swift
//  NationalPokedex
//
//  Created by Akihiro Matsuyama on 2024/04/14.
//

import Foundation

// 「Pokemon」と「PokemonSpecies」の合成
struct PokeDetail: Codable {
    let id: Int              // 図鑑番号
    let name: String         // 名前
    let sprites: Sprites     // 画像
    let height: Int          // 身長 cm
    let weight: Int          // 体重 cg
    let types: [PokeType]    // ポケモンタイプ
    let color: NameAndUrl               // ポケモンの色
    let evolutionChain: EvolutionChain  // 名前
    let genera: [Genera]                // 属
    let names: [Name]
}
