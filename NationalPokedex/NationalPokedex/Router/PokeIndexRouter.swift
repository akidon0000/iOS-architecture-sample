//
//  PokeIndexRouter.swift
//  NationalPokedex
//
//  Created by Akihiro Matsuyama on 2024/04/23.
//

import SwiftUI

struct PokeIndexRouter {
    func navigationLink(pokemon: Pokemon) -> some View {
        return NavigationLink(destination: PokeIndexView()) {
            PokeRow(pokemon: pokemon)
        }
    }
}

struct PokeIndexRouter_Previews: PreviewProvider {
    static var previews: some View {
        PokeIndexRouter().navigationLink(pokemon: Pokemon.mock)
    }
}
