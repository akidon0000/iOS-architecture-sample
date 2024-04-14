//
//  PokeSearchViewModel.swift
//  NationalPokedex
//
//  Created by Akihiro Matsuyama on 2024/04/05.
//

import Combine

class PokeSearchViewModel: ObservableObject {
    let model: PokeApiModelProtocol
    private(set) var objectWillChange = ObservableObjectPublisher()
    @Published var pokemons: [Pokemon]
    @Published var pokeDetails: [PokeDetail]
    @Published var isNotFound: Bool
    @Published var error: ApiError?

    init(model: PokeApiModel = PokeApiModel(),
         pokemons: [Pokemon] = [Pokemon](), pokeDetails: [PokeDetail] = [PokeDetail](), isNotFound: Bool = false, error: ApiError? = nil) {
        self.model = model
        self.pokemons = pokemons
        self.pokeDetails = pokeDetails
        self.isNotFound = isNotFound
        self.error = error
    }

    func compose(pokemon: Pokemon, pokemonSpecies: PokemonSpecies) -> PokeDetail {
        return PokeDetail(id:pokemon.id,
                          name: pokemonSpecies.names[0].name,
                          sprites: pokemon.sprites,
                          height: pokemon.height,
                          weight: pokemon.weight,
                          types: pokemon.types,
                          color: pokemonSpecies.color,
                          evolutionChain: pokemonSpecies.evolutionChain,
                          genera: pokemonSpecies.genera,
                          names: pokemonSpecies.names)
    }

    func getNewPokemons(pokemons: [Pokemon], numberToAdd: Int = 20) async -> [Pokemon] {
        var updatedPokemons = pokemons
        var nextPokemonId = pokemons.count
        if nextPokemonId != 0 {
            nextPokemonId += 1
        }
        let endPokemonId = nextPokemonId + 20

        await withTaskGroup(of: Result<Pokemon, ApiError>.self) { group in
            for i in nextPokemonId...endPokemonId {
                group.addTask {
                    await self.model.getPokemons(name: i.description)
                }
            }

            for await result in group {
                switch result {
                case .success(let pokemon):
                    updatedPokemons.append(pokemon)
                case .failure(let error):
                    print("Failed to fetch pokemon: \(error)")
                }
            }
        }

        return updatedPokemons
    }

    @MainActor
    func loadStart() {
        Task {
            pokemons = await getNewPokemons(pokemons: pokemons).sorted{ $0.id < $1.id}
            self.objectWillChange.send()
        }
    }

    func additionalLoading() {

    }
}
