//
//  PokeDetail.swift
//  NationalPokedex
//
//  Created by Akihiro Matsuyama on 2024/04/14.
//

import Foundation

/// 個体情報と種情報をまとめたポケモンデータ
/// HashableはNavigationStackでパスをハッシュ化するのに使用
struct Pokemon: Identifiable, Codable, Hashable{
    let id: Int
    var individual: PokeIndividual
    var species: PokeSpecies
}

extension Pokemon {
    // フシギダネ
    static let mock = Pokemon(id: 1,
                              individual: PokeIndividual.mock,
                              species: PokeSpecies.mock)
}
