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
        HStack {
            if let imageUrl = pokemon.sprites.frontDefault {
                AsyncImage(url: URL(string: imageUrl)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 50, height: 50)
                .scaleEffect(x: 2, y: 2, anchor: .center)
            }

            Text("No. \(pokemon.id)")
            Text(pokemon.name)
                .padding()
        }
    }
}

struct PokeRow_Previews: PreviewProvider {
    static var previews: some View {
        PokeRow(pokemon: Pokemon.mockPokemon)
    }
}
