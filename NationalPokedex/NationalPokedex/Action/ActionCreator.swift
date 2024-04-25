//
//  ActionCreator.swift
//  NationalPokedex
//
//  Created by Akihiro Matsuyama on 2024/04/24.
//

import Foundation

final class ActionCreator {
    private let dispatcher: Dispatcher
    private let model: PokeApiModelProtocol

    init(dispatcher: Dispatcher = .shared,
         model: PokeApiModelProtocol = PokeApiModel()) {
        self.dispatcher = dispatcher
        self.model = model
    }
}

extension ActionCreator {
    func requestMorePokemons(pokemons: [Pokemon]) {
        Task {
            let result = await model.getNewPokemons(pokemons: pokemons)
            await MainActor.run {
                switch result {
                case .success(let updatedPokemons):
                    self.dispatcher.dispatch(.requestMorePokemons(updatedPokemons))
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}

extension ActionCreator {
    func selectedPokemon(pokemon: Pokemon) {
        dispatcher.dispatch(.selectedPokemon(pokemon))
    }
}
