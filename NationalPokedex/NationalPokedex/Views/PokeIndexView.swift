//
//  PokeIndexView.swift
//  NationalPokedex
//
//  Created by Akihiro Matsuyama on 2024/04/05.
//

import SwiftUI

struct PokeIndexView: View {
    weak var delegate: PokeIndexPresenterProtocol?

    let gridLayout = [GridItem(.adaptive(minimum: 100))]

    let type: StateType
    enum StateType {
        case display([Pokemon])
        case notFound
        case error(ApiError)
    }

    var body: some View {
        NavigationStack() {
            ScrollView(showsIndicators: false) {
                switch type {
                case .display(let pokemons):
                    LazyVGrid(columns: gridLayout) {
                        ForEach(pokemons) { pokemon in
                            NavigationLink(
                                destination: delegate?.navigate(.detail(pokemon))
                            ) {
                                PokeRow(pokemon: pokemon)
                                    .onAppear {
                                        // 取得済みの最後のポケモンが表示された場合、新たに取得してくる
                                        if pokemons.last?.id == pokemon.id {
                                            delegate?.requestMorePokemons(pokemons: pokemons)
                                        }
                                    }
                            }
                        }
                    }
                case .error(let error):
                    Text(error.localizedDescription)
                    Button("Retry", action: delegate?.loadStart ?? {})
                case .notFound:
                    Text("NotFound")
                    Button("Retry", action: delegate?.loadStart ?? {})
                }
            }
            .navigationTitle("Pokémon Index")
            .navigationBarTitleDisplayMode(.inline)
            .background(.white)
            .padding(10)
            .ignoresSafeArea(edges: .bottom)
            .onAppear {
                // ナビゲーションから戻ってきた場合のみ、処理をスキップ
                if !(delegate?.isNavigating ?? false) {
                    self.delegate?.loadStart()
                }
                delegate?.isNavigating = false
            }
            .onDisappear {
                // ナビゲーションへ移動するときに状態を設定
                delegate?.isNavigating = true
            }
        }
    }
}

struct PokeIndexView_Previews: PreviewProvider {
    static var pokeIndexPresenter: PokeIndexPresenter {
        let presenter = PokeIndexPresenter()
        let view = PokeIndexView(delegate: presenter,type: .display([]))
        let model = PokeApiModel()
        presenter.inject(view: view, model: model)
        return presenter
    }

    static var previews: some View {
        PokeIndexView(type: .display([Pokemon.mock]))
            .previewDisplayName("Default View")

        PokeIndexView(type: .notFound)
            .previewDisplayName("Error View")
    }
}
