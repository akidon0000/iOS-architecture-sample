//
//  PokeIndexView.swift
//  NationalPokedex
//
//  Created by Akihiro Matsuyama on 2024/04/05.
//

import SwiftUI

struct PokeIndexView: View {

    @State private var navigatePath = [Pokemon]()
    @StateObject var viewModel: PokeSearchViewModel

    init(viewModel: PokeSearchViewModel = PokeSearchViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationStack(path: $navigatePath) {
            if let error = viewModel.error {
                Text(error.localizedDescription)
            } else {
                List(viewModel.pokemons) { pokemon in
                    PokeRow(pokemon: pokemon)
                        .onAppear() {
                            if pokemon.id == viewModel.pokemons.last?.id {
                                viewModel.loadStart()
                            }
                        }
                        .onTapGesture {
                            navigatePath.append(pokemon)
                        }
                }
                .navigationTitle("Pokémon Index")
                .navigationDestination(for: Pokemon.self) { pokemon in
                    PokeDetailView(pokemon: pokemon)
                }
                .onAppear {
                    viewModel.loadStart()
                }
            }
        }
    }
}

#Preview {
    NavigationView {
        PokeIndexView()
            .previewDisplayName("Default View")
    }
}
