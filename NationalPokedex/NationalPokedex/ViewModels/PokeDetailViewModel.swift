//
//  PokeDetailViewModel.swift
//  NationalPokedex
//
//  Created by Akihiro Matsuyama on 2024/04/08.
//

import Combine

class PokeDetailViewModel: ObservableObject {
    let model: PokeApiModel
    @Published var pokemon: Pokemon
    @Published var pokemonSpecies: PokemonSpecies
    @Published var isLoading: Bool
    @Published var error: ApiError?

    init(model: PokeApiModel = PokeApiModel(),
         pokemon: Pokemon = Pokemon.mockPokemon, pokemonSpecies: PokemonSpecies = PokemonSpecies.mockPokemonSpecies, isLoading: Bool = true, error: ApiError? = nil) {
        self.model = model
        self.pokemon = pokemon
        self.pokemonSpecies = pokemonSpecies
        self.isLoading = isLoading
        self.error = error
    }

    /// Modelにロード開始を要求する
    func loadStart(nameOrId: String) {
        isLoading = true
        error = nil

        model.getPokemon(name: nameOrId) { [weak self] result in
            switch result {
            case .success(let pokemon):
                self?.pokemon = pokemon
            case .failure(let error):
                self?.error = error
            }
            self?.isLoading = false
        }

        model.getPokemonSpecies(name: nameOrId) { [weak self] result in
            switch result {
            case .success(let pokemonSpecies):
                self?.pokemonSpecies = pokemonSpecies
            case .failure(let error):
                self?.error = error
            }
            self?.isLoading = false
        }
    }
}
