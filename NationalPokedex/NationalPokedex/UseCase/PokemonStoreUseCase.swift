//
//  PokemonStoreUseCase.swift
//  NationalPokedex
//
//  Created by Akihiro Matsuyama on 2024/07/06.
//

import Foundation

protocol PokemonStoreUseCaseInterface {
    func fetchPokemons() -> [Pokemon]
    func addPokemon(_ pokemon: Pokemon)
}

struct PokemonStoreUseCase: PokemonStoreUseCaseInterface {
    private let pokemonRepository: PokemonRepositoryInterface

    init(pokemonRepository: PokemonRepositoryInterface) {
        self.pokemonRepository = pokemonRepository
    }

    func fetchPokemons() -> [Pokemon] {
        return pokemonRepository.fetchPokemons()
    }

    func addPokemon(_ pokemon: Pokemon) {
        return pokemonRepository.addPokemon(pokemon)
    }
}
