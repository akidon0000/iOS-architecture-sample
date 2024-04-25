//
//  PokeDetailStore.swift
//  NationalPokedex
//
//  Created by Akihiro Matsuyama on 2024/04/25.
//

import Foundation

class PokeDetailStore: Store {
    static let shared = PokeDetailStore(dispatcher: .shared)
    @Published var pokemon: Pokemon = Pokemon.mock

    override func onDispatch(_ action: Action) {
        switch action {
        case .requestMorePokemons(_):
            return
        case .selectedPokemon(let pokemon):
            self.pokemon = pokemon
        }
    }
}
