//
//  Action.swift
//  NationalPokedex
//
//  Created by Akihiro Matsuyama on 2024/04/24.
//

import Foundation

enum Action {
    case requestMorePokemons([Pokemon])
    case selectedPokemon(Pokemon)
}
