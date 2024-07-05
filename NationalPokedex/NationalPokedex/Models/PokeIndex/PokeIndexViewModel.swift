//
//  PokeIndexViewModel.swift
//  NationalPokedex
//
//  Created by Akihiro Matsuyama on 2024/04/05.
//

import Observation

@Observable
final class PokeIndexViewModel {
    let model: PokeApiInterface
    var pokemons: [Pokemon]
    var error: ApiError?

    init(model: PokeApi = PokeApi(), pokemons: [Pokemon] = [Pokemon](), error: ApiError? = nil) {
        self.model = model
        self.pokemons = pokemons
        self.error = error
    }

    func loadStart() {
        requestMorePokemons()
    }

    func requestMorePokemons() {
        Task {
            let result = await model.getNewPokemons(pokemons: pokemons)
            switch result {
            case .success(let updatedPokemons):
                pokemons = updatedPokemons
            case .failure(let error):
                self.error = error
            }
        }
    }
}