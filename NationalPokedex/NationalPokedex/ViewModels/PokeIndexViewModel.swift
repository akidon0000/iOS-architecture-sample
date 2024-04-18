//
//  PokeIndexViewModel.swift
//  NationalPokedex
//
//  Created by Akihiro Matsuyama on 2024/04/05.
//

import Combine

class PokeIndexViewModel: ObservableObject {
    let model: PokeApiModelProtocol

    @Published var pokemons: [Pokemon]
    @Published var error: ApiError?

    init(model: PokeApiModel = PokeApiModel(), pokemons: [Pokemon] = [Pokemon](), error: ApiError? = nil) {
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
