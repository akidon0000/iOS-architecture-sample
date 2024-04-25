//
//  PokeIndexStore.swift
//  NationalPokedex
//
//  Created by Akihiro Matsuyama on 2024/04/24.
//

import Foundation

class PokeIndexStore: Store {
    static let shared = PokeIndexStore(dispatcher: .shared)
    @Published var pokemons = [Pokemon]()

    override func onDispatch(_ action: Action) {
        switch action {
        case .requestMorePokemons(let pokemons):
            self.pokemons = pokemons
        case .selectedPokemon(_):
            return
        }
    }
}
