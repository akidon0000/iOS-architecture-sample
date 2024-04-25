//
//  PokeIndexView.swift
//  NationalPokedex
//
//  Created by Akihiro Matsuyama on 2024/04/05.
//

import SwiftUI

struct PokeIndexView: View {
    private let actionCreator: ActionCreator
    @StateObject var pokeIndexStore: PokeIndexStore
    @State private var navigatePath = [Pokemon]()

    let gridLayout = [GridItem(.adaptive(minimum: 100))]

    init(actionCreator: ActionCreator = ActionCreator(),
         pokeIndexStore: PokeIndexStore = .shared) {
        self.actionCreator = actionCreator
        _pokeIndexStore = StateObject(wrappedValue: pokeIndexStore)
    }

    var body: some View {
        NavigationStack(path: $navigatePath) {
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: gridLayout) {
                    ForEach(pokeIndexStore.pokemons) { pokemon in
                        PokeRow(pokemon: pokemon)
                            .onTapGesture {
                                navigatePath.append(pokemon)
                            }
                            .onAppear {
                                // 取得済みの最後のポケモンが表示された場合、新たに取得してくる
                                if pokeIndexStore.pokemons.last?.id == pokemon.id {
                                    actionCreator.requestMorePokemons(pokemons: pokeIndexStore.pokemons)
                                }
                            }
                    }
                }
            }
            .navigationTitle("Pokémon Index")
            .navigationBarTitleDisplayMode(.inline)
            .background(.white)
            .padding(10)
            .ignoresSafeArea(edges: .bottom)
            .onAppear {
                actionCreator.requestMorePokemons(pokemons: pokeIndexStore.pokemons)
            }
            .navigationDestination(for: Pokemon.self) { pokemon in
                PokeDetailView()
                    .onAppear {
                        actionCreator.selectedPokemon(pokemon: pokemon)
                    }
            }
        }
    }
}

struct PokeIndexView_Previews: PreviewProvider {
    static var previews: some View {
        PokeIndexView()
            .previewDisplayName("Default View")
    }
}
