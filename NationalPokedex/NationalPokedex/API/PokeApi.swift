//
//  PokeApi.swift
//  NationalPokedex
//
//  Created by Akihiro Matsuyama on 2024/04/05.
//

import Foundation

protocol PokeApiInterface {
    /// 指定されたポケモンのリストを更新し、新しいポケモンのデータを非同期に取得する
    /// - Parameter pokemons: 現在のポケモンの配列
    /// - Returns: 更新後のポケモンの配列を含むResultオブジェクト
    func getNewPokemons(pokemons: [Pokemon]) async -> (Result<[Pokemon], ApiError>)
}

struct PokeApi: PokeApiInterface {
    enum Endpoint: String {
        case pokemon = "pokemon/"
        case pokemonSpecies = "pokemon-species/"

        static let baseURL = "https://pokeapi.co/api/"
        static let version = "v2/"

        /// 指定されたエンドポイントとIDに基づいてURLを生成する
        /// - Parameter id: ポケモンのID
        /// - Returns: 生成されたURL
        func url(for id: String) -> URL? {
            URL(string: "\(Endpoint.baseURL)\(Endpoint.version)\(self.rawValue)\(id)")
        }
    }

    /// 指定されたポケモンのリストを更新し、新しいポケモンのデータを非同期に取得する
    /// - Parameter pokemons: 現在のポケモンの配列
    /// - Returns: 更新後のポケモンの配列を含むResultオブジェクト
    func getNewPokemons(pokemons: [Pokemon]) async -> Result<[Pokemon], ApiError> {
        // ポケモン配列が0の場合は図鑑番号1番から、内容が存在する場合は最後のポケモン番号+1から
        let startPokemonId = pokemons.isEmpty ? 1 : pokemons.last!.id + 1
        let newPokemonsResult = await getMultiplePokemon(startId: startPokemonId, count: 20)

        switch newPokemonsResult {
        case .success(let newPokemons):
            return .success(pokemons + newPokemons)
        case .failure(let error):
            return .failure(error)
        }
    }

    /// 複数のポケモンのデータを非同期に取得する
    /// - Parameters:
    ///   - startId: 取得を開始するポケモンのID
    ///   - count: 取得するポケモンの数
    /// - Returns: 取得したポケモンの配列を含むResultオブジェクト
    private func getMultiplePokemon(startId: Int, count: Int) async -> Result<[Pokemon], ApiError> {
        var pokemonList: [Pokemon] = []
        var encounteredError: ApiError?

        for id in startId..<(startId + count) {
            let result = await getNewPokemon(id: id.description)
            switch result {
            case .success(let pokemon):
                pokemonList.append(pokemon)
            case .failure(let error):
                print("Failed to get Pokemon with id \(id): \(error)")
                encounteredError = error
            }
        }

        if let error = encounteredError {
            return .failure(error)
        } else {
            return .success(pokemonList)
        }
    }

    /// 指定されたIDのポケモンのデータを非同期に取得する
    /// - Parameter id: ポケモンのID
    /// - Returns: 取得したポケモンを含むResultオブジェクト
    private func getNewPokemon(id: String) async -> (Result<Pokemon, ApiError>) {
        // 個別のポケモンデータと種データを非同期に取得
        let individualResult: Result<PokeIndividual, ApiError> = await self.getPokeData(id: id, endpoint: .pokemon)
        let speciesResult: Result<PokeSpecies, ApiError> = await self.getPokeData(id: id, endpoint: .pokemonSpecies)

        // 両方のデータが成功した場合、ポケモンオブジェクトを作成
        switch (individualResult, speciesResult) {
        case (.success(let individualResult), .success(let speciesResult)):
            return .success(Pokemon(id: individualResult.id, individual: individualResult, species: speciesResult))

        case (.failure(let error), _), (_, .failure(let error)):
            return .failure(error)
        }
    }

    /// 指定されたエンドポイントとIDに基づいてデータを非同期に取得する
    /// - Parameters:
    ///   - id: ポケモンのID
    ///   - endpoint: エンドポイント
    /// - Returns: 取得したデータを含むResultオブジェクト
    private func getPokeData<T: Decodable>(id: String, endpoint: Endpoint) async -> Result<T, ApiError> {
        guard let url = endpoint.url(for: id) else {
            return .failure(.urlError)
        }

        do {
            let (data, _) = try await URLSession.shared.data(for: URLRequest(url: url))
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                return .success(decodedData)
            } catch {
                return .failure(.jsonParseError(String(data: data, encoding: .utf8) ?? "Invalid data"))
            }
        } catch {
            return .failure(.responseError(error))
        }
    }
}
