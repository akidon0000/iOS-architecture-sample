//
//  PokeIndexView.swift
//  NationalPokedex
//
//  Created by Akihiro Matsuyama on 2024/04/05.
//

import SwiftUI

struct PokeIndexView: View {
    @State var presenter: PokeIndexPresenter
    @State private var navigatePath = [Pokemon]()

    let gridLayout = [GridItem(.adaptive(minimum: 100))]

    init(presenter: PokeIndexPresenter = PokeIndexPresenter()) {
        _presenter = State(wrappedValue: presenter)
    }

    var body: some View {
        NavigationStack(path: $navigatePath) {
            ScrollView(showsIndicators: false) {
                if let error = presenter.error {
                    Text(error.localizedDescription)
                    Button("Retry", action: presenter.loadStart)
                } else {
                    LazyVGrid(columns: gridLayout) {
                        ForEach(presenter.pokemons) { pokemon in
                            PokeRow(pokemon: pokemon)
                                .onTapGesture {
                                    navigatePath.append(pokemon)
                                }
                                .onAppear {
                                    // 取得済みの最後のポケモンが表示された場合、新たに取得してくる
                                    if presenter.pokemons.last?.id == pokemon.id {
                                        presenter.requestMorePokemons()
                                    }
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
                presenter.loadStart()
            }
            .navigationDestination(for: Pokemon.self) { pokemon in
                PokeDetailView(presenter: PokeDetailPresenter(pokemon: pokemon))
            }
        }
    }
}

struct PokeIndexView_Previews: PreviewProvider {
    static var previews: some View {
        PokeIndexView()
            .previewDisplayName("Default View")

        PokeIndexView()
            .previewDisplayName("Error View")
    }
}
