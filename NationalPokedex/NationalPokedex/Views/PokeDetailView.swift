//
//  PokeDetailView.swift
//  NationalPokedex
//
//  Created by Akihiro Matsuyama on 2024/04/08.
//

import SwiftUI

struct PokeDetailView: View {
    private let actionCreator: ActionCreator
    @StateObject var pokeDetailStore: PokeDetailStore
    @State private var navigatePath = [Pokemon]()

    let gridLayout = [GridItem(.adaptive(minimum: 100))]

    init(actionCreator: ActionCreator = ActionCreator(),
         pokeDetailStore: PokeDetailStore = .shared) {
        self.actionCreator = actionCreator
        _pokeDetailStore = StateObject(wrappedValue: pokeDetailStore)
    }

    var body: some View {
        VStack {
            if let imageUrlStr = pokeDetailStore.pokemon.individual.sprites.frontDefault {
                AsyncImage(url: URL(string: imageUrlStr)) { image in
                    image.resizable()
                        .scaleEffect(1.2)
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 250, height: 250)
                .padding(20) // 枠線の角が欠けてしまうため
                .background(
                    RoundedRectangle(cornerRadius: 150)
                        .stroke(Color.black, lineWidth: 5)
                        .padding(3)
                )
            }

            Text(pokeDetailStore.pokemon.species.names.filter{
                $0.language.name == "ja"
            }.first?.name ?? "名前取得エラー")
                .font(.system(size: 40))
                .fontWeight(.bold)

            Divider()

            Text("図鑑番号 No. \(pokeDetailStore.pokemon.id.description)")

            Text(pokeDetailStore.pokemon.species.genera.filter{
                $0.language.name == "ja"
            }.first?.genus ?? "属の取得エラー")

            HStack {
                ForEach(pokeDetailStore.pokemon.individual.types) { type in
                    Text("\(type.type.name)")
                }
            }

            Divider()

            Text(pokeDetailStore.pokemon.species.flavorTextEntries.filter{
                $0.language.name == "ja"
            }.first?.flavorText ?? "生態情報取得エラー")

            Divider()

            HStack(spacing: 100) {
                VStack(spacing: 20) {
                    Text("おもさ")
                    Text("\((Double(pokeDetailStore.pokemon.individual.weight) / 10).description) kg")
                }

                VStack(spacing: 20) {
                    Text("たかさ")
                    Text("\((Double(pokeDetailStore.pokemon.individual.height) / 10).description) m")
                }
            }
        }
    }
}

struct PokeDetailView_Previews: PreviewProvider {
    static let actionCreator = ActionCreator()
    static let pokeDetailStore = PokeDetailStore.shared

    static var previews: some View {
        NavigationView {
            PokeDetailView()
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
    }
}
