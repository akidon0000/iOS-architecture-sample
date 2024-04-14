//
//  PokeDetailView.swift
//  NationalPokedex
//
//  Created by Akihiro Matsuyama on 2024/04/08.
//

import SwiftUI

struct PokeDetailView: View {
    @StateObject var viewModel: PokeDetailViewModel

    init(viewModel: PokeDetailViewModel = PokeDetailViewModel(), pokemon: Pokemon) {
        _viewModel = StateObject(wrappedValue: viewModel)
        viewModel.pokemon = pokemon
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Text("No. \(viewModel.pokemon.id.description)  \(viewModel.pokemonSpecies.names[0].name)")
                        .font(.title)
                        .fontWeight(.bold)

                    if let imageUrlStr = viewModel.pokemon.sprites.frontDefault {
                        AsyncImage(url: URL(string: imageUrlStr)) { image in
                            image.resizable()
                                .scaleEffect(2.5)
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 250, height: 250)
                        .padding()
                    }
                    Text(viewModel.pokemonSpecies.genera[0].genus)

                    HStack(spacing: 100) {
                        VStack(spacing: 20) {
                            Text("おもさ:")
                            Text("たかさ:")
                            Text("タイプ:")
                        }

                        VStack(spacing: 20) {
                            Text("\(viewModel.pokemon.weight.description) cg")
                            Text("\(viewModel.pokemon.height.description) cm")

                            HStack {
                                ForEach(viewModel.pokemon.types) { type in
                                    Text("\(type.type.name)")
                                }
                            }
                        }
                    }

                    Spacer()

                    if let error = viewModel.error {
                        Text(error.localizedDescription)
                    } else {
                        if viewModel.isLoading {
                            ProgressView()
                                .scaleEffect(x: 3, y: 3, anchor: .center)
                                .onAppear {
                                    viewModel.loadStart(nameOrId: viewModel.pokemon.name)
                                }
                        }
                    }
                }
            }
        }
        .navigationBarTitle("", displayMode: .inline)
    }
}

struct PokeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        
        NavigationView {
            PokeDetailView(pokemon: Pokemon.mockPokemon)
                .previewDisplayName("Default View")

                // プレビューでは、ナビゲーションバーや遷移前に戻るボタンの表示がされないので、力技
                .navigationTitle("")

                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {}, label: {
                            HStack {
                                Image(systemName: "chevron.left")
                                Text("Pokémon Index")
                            }
                        })
                        .tint(.accentColor)
                    }
                }
        }

        NavigationView {
            PokeDetailView(viewModel: PokeDetailViewModel(pokemon: Pokemon.mockPokemon, pokemonSpecies: PokemonSpecies.mockPokemonSpecies, isLoading: false), pokemon: Pokemon.mockPokemon)
                .previewDisplayName("Mock DI View")
                .navigationTitle("")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {}, label: {
                            HStack {
                                Image(systemName: "chevron.left")
                                Text("Pokémon Index")
                            }
                        })
                        .tint(.accentColor)
                    }
                }
        }

        NavigationView {
            PokeDetailView(viewModel: PokeDetailViewModel(error: .jsonParseError("invalid text")), pokemon: Pokemon.mockPokemon)
                .previewDisplayName("Error View")
                .navigationTitle("")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {}, label: {
                            HStack {
                                Image(systemName: "chevron.left")
                                Text("Pokémon Index")
                            }
                        })
                        .tint(.accentColor)
                    }
                }
        }
    }
}
