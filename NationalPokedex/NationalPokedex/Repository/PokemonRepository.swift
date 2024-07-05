//
//  PokemonRepository.swift
//  NationalPokedex
//
//  Created by Akihiro Matsuyama on 2024/07/06.
//

import Foundation

protocol PokemonRepositoryInterface {
    func fetchPokemons() -> [Pokemon]
    func addPokemon(_ pokemon: Pokemon)
}

final class PokemonRepository: PokemonRepositoryInterface {
    static var shared = PokemonRepository()

    private var pokemons: [Pokemon]

    init() {
        pokemons = []
    }

    func fetchPokemons() -> [Pokemon] {
        return Self.shared.pokemons
    }

    func addPokemon(_ pokemon: Pokemon) {
        return Self.shared.pokemons.append(pokemon)
    }
}
