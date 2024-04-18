//
//  PokeDetailViewModel.swift
//  NationalPokedex
//
//  Created by Akihiro Matsuyama on 2024/04/08.
//

import Combine

class PokeDetailViewModel: ObservableObject {
    @Published var pokemon: Pokemon

    init(pokemon: Pokemon = Pokemon.mock) {
        self.pokemon = pokemon
    }
}
