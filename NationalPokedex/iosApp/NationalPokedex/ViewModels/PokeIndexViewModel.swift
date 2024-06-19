//
//  PokeIndexViewModel.swift
//  NationalPokedex
//
//  Created by Akihiro Matsuyama on 2024/04/05.
//

import Observation
import shared

@Observable final class PokeIndexViewModel {
    let model: PokeApiModelProtocol
    var pokemons: [Pokemon]
    var error: ApiError?

    init(model: PokeApiModel = PokeApiModel(), pokemons: [Pokemon] = [Pokemon](), error: ApiError? = nil) {
        self.model = model
        self.pokemons = pokemons
        self.error = error
    }

    func loadStart() {
        NativeFlow<AnyObject>(flow: Greeting().greet2()).watch { value in
            print(value)
        }
//        model.fetchPokeomns()
//        requestMorePokemons()
    }

    func requestMorePokemons() {
        Task {
//            let result = await model.getNewPokemons(pokemons: pokemons)
//            await MainActor.run {
//                switch result {
//                case .success(let updatedPokemons):
//                    pokemons = updatedPokemons
//                case .failure(let error):
//                    self.error = error
//                }
//            }
        }
    }
}
