//
//  PokeDetailViewModel.swift
//  NationalPokedex
//
//  Created by Akihiro Matsuyama on 2024/04/08.
//

import Observation

@Observable final class PokeDetailViewModel {
    var pokemon: Pokemon

    init(pokemon: Pokemon = Pokemon.mock) {
        self.pokemon = pokemon
    }
}
