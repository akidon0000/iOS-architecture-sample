//
//  PokeRow.swift
//  NationalPokedex
//
//  Created by Akihiro Matsuyama on 2024/04/09.
//

import SwiftUI

struct PokeRow: View {
    let pokemon: Pokemon

    var body: some View {
        VStack {
            VStack {
                Text("No. \(pokemon.id)")
                    .font(.system(size: 14))
                Text(pokemon.species.names.first?.name ?? "名前取得エラー")
                    .bold()
            }

            if let imageUrl = pokemon.individual.sprites.frontDefault {
                AsyncImage(url: URL(string: imageUrl)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 100, height: 100)
                .scaleEffect(x: 1.5, y: 1.5, anchor: .center)
            }
        }
        .padding(10)
        .background(.gray.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct PokeRow_Previews: PreviewProvider {
    static var previews: some View {
        PokeRow(pokemon: Pokemon.mock)
    }
}
