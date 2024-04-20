//
//  PokeIndexView.swift
//  NationalPokedex
//
//  Created by Akihiro Matsuyama on 2024/04/05.
//

import SwiftUI

struct PokeIndexView: View {
    weak var delegate: ViewProtocol?
    var model: PokeApiModel

    let gridLayout = [GridItem(.adaptive(minimum: 100))]

    init(delegate: ViewProtocol?, model: PokeApiModel = PokeApiModel()) {
        self.delegate = delegate
        self.model = model
    }

    var body: some View {
        NavigationStack() {
            ScrollView(showsIndicators: false) {
                if let error = model.error {
                    Text(error.localizedDescription)
                    Button("Retry", action: model.loadStart)
                } else {
                    LazyVGrid(columns: gridLayout) {
                        ForEach(model.pokemons) { pokemon in
                            NavigationLink(
                                destination: PokeDetailView(delegate: self.delegate, pokemon: pokemon)
                            ) {
                                PokeRow(pokemon: pokemon)
                                    .onAppear {
                                        // 取得済みの最後のポケモンが表示された場合、新たに取得してくる
                                        if model.pokemons.last?.id == pokemon.id {
                                            model.requestMorePokemons()
                                        }
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
                model.loadStart()
            }
        }
    }
}

struct PokeIndexView_Previews: PreviewProvider {
    static let viewController = ViewController()
    static var previews: some View {
        PokeIndexView(delegate: viewController, model: PokeApiModel())
            .previewDisplayName("Default View")

        PokeIndexView(delegate: viewController, model: PokeApiModel(error: ApiError.responseDataEmpty))
            .previewDisplayName("Error View")
    }
}
