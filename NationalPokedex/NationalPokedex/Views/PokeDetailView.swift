//
//  PokeDetailView.swift
//  NationalPokedex
//
//  Created by Akihiro Matsuyama on 2024/04/08.
//

import SwiftUI

struct PokeDetailView: View {
    weak var delegate: ViewProtocol?
    let pokemon: Pokemon

    init(delegate: ViewProtocol?, pokemon: Pokemon) {
        self.delegate = delegate
        self.pokemon = pokemon
    }

    var body: some View {
        VStack {
            if let imageUrlStr = pokemon.individual.sprites.frontDefault {
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

            Text(pokemon.species.names.filter{
                $0.language.name == "ja"
            }.first?.name ?? "名前取得エラー")
                .font(.system(size: 40))
                .fontWeight(.bold)

            Divider()

            Text("図鑑番号 No. \(pokemon.id.description)")

            Text(pokemon.species.genera.filter{
                $0.language.name == "ja"
            }.first?.genus ?? "属の取得エラー")

            HStack {
                ForEach(pokemon.individual.types) { type in
                    Text("\(type.type.name)")
                }
            }

            Divider()

            Text(pokemon.species.flavorTextEntries.filter{
                $0.language.name == "ja"
            }.first?.flavorText ?? "生態情報取得エラー")

            Divider()

            HStack(spacing: 100) {
                VStack(spacing: 20) {
                    Text("おもさ")
                    Text("\((Double(pokemon.individual.weight) / 10).description) kg")
                }

                VStack(spacing: 20) {
                    Text("たかさ")
                    Text("\((Double(pokemon.individual.height) / 10).description) m")
                }
            }
        }
    }
}

struct PokeDetailView_Previews: PreviewProvider {
    static let viewController = ViewController()
    static var previews: some View {
        NavigationView {
            PokeDetailView(delegate: viewController, pokemon: Pokemon.mock)
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
