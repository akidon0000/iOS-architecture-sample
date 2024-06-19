//
//  PokeIndexView.swift
//  NationalPokedex
//
//  Created by Akihiro Matsuyama on 2024/04/05.
//

import SwiftUI
import shared

struct PokeIndexView: View {
    @State private var navigatePath = [Pokemon]()
    @State var viewModel: PokeIndexViewModel

    let gridLayout = [GridItem(.adaptive(minimum: 100))]

    init(viewModel: PokeIndexViewModel = PokeIndexViewModel()) {
        _viewModel = State(wrappedValue: viewModel)
    }

    var body: some View {
//        Text(Greeting().greet2().collect(collector: <#T##Kotlinx_coroutines_coreFlowCollector#>, completionHandler: <#T##(Error?) -> Void#>) as? String ?? "nilss")
        NavigationStack(path: $navigatePath) {
            ScrollView(showsIndicators: false) {
                if let error = viewModel.error {
                    Text(error.localizedDescription)
                    Button("Retry", action: viewModel.loadStart)
                } else {
                    LazyVGrid(columns: gridLayout) {
                        ForEach(0 ..< viewModel.pokemons.count) { index in
                            PokeRow(pokemon: viewModel.pokemons[index])
                                .onTapGesture {
                                    navigatePath.append(viewModel.pokemons[index])
                                }
                                .onAppear {
                                    // 取得済みの最後のポケモンが表示された場合、新たに取得してくる
                                    if viewModel.pokemons.last?.id == viewModel.pokemons[index].id {
                                        viewModel.requestMorePokemons()
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
                viewModel.loadStart()
            }
            .navigationDestination(for: Pokemon.self) { pokemon in
                PokeDetailView(viewModel: PokeDetailViewModel(pokemon: pokemon))
            }
        }
    }
}

struct PokeIndexView_Previews: PreviewProvider {
    static var previews: some View {
        PokeIndexView()
            .previewDisplayName("Default View")

        PokeIndexView(viewModel: PokeIndexViewModel(error: ApiError.responseDataEmpty))
            .previewDisplayName("Error View")
    }
}
