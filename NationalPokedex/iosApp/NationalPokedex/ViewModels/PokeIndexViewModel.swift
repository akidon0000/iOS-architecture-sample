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
        requestMorePokemons()
    }

    func requestMorePokemons() {
        PokeApiModel().getNewPokemons(pokemons: pokemons) { result, error in
            if let result = result {
                switch result {
                case is ResultSuccess<NSArray>:
                    if let successResult = result as? ResultSuccess<NSArray> {
                        if let newPokemons = successResult.value as? [Pokemon] {
                            DispatchQueue.main.async {
                                self.pokemons.append(contentsOf: newPokemons)
                                print("Success: \(newPokemons)")
                            }
                        }
                    }
                case is ResultFailure<ApiError>:
                    if let failureResult = result as? ResultFailure<ApiError> {
                        DispatchQueue.main.async {
                            self.error = failureResult.error
                            print("Error: \(failureResult.error)")
                        }
                    }
                default:
                    print("Unknown result type")
                }
            } else if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
