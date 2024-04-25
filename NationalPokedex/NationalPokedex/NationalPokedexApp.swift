//
//  NationalPokedexApp.swift
//  NationalPokedex
//
//  Created by Akihiro Matsuyama on 2024/04/05.
//

import SwiftUI

@main
struct NationalPokedexApp: App {
    private let actionCreator = ActionCreator()
    private let pokeIndexStore = PokeIndexStore.shared

    var body: some Scene {
        WindowGroup {
            PokeIndexView(actionCreator: actionCreator, pokeIndexStore: pokeIndexStore)
        }
    }
}
