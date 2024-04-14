//
//  PokeDex.swift
//  NationalPokedex
//
//  Created by Akihiro Matsuyama on 2024/04/10.
//

import Foundation

struct PokeDex: Codable {
    let pokemonEntries: [PokemonEntries]

    private enum CodingKeys: String, CodingKey {
        case pokemonEntries = "pokemon_entries"
    }
}

struct PokemonEntries: Identifiable, Codable {
    let id: Int
    let pokemonSpecies: NameAndUrl

    private enum CodingKeys: String, CodingKey {
        case id = "entry_number"
        case pokemonSpecies = "pokemon_species"
    }
}
