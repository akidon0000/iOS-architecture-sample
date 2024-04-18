//
//  PokeApiModel.swift
//  NationalPokedex
//
//  Created by Akihiro Matsuyama on 2024/04/05.
//

import Foundation

protocol PokeApiModelProtocol {
    /// 指定されたポケモンのリストを更新し、新しいポケモンのデータを非同期に取得する
    /// - Parameter pokemons: 現在のポケモンの配列
    /// - Returns: 更新後のポケモンの配列を含むResultオブジェクト
    func getNewPokemons(pokemons: [Pokemon]) async -> (Result<[Pokemon], ApiError>)
}

struct PokeApiModel: PokeApiModelProtocol {
    enum Endpoint: String {
        case pokemon = "pokemon"
        case pokemonSpecies = "pokemon-species"

        static let baseURL = "https://pokeapi.co/api/v2/"

        func url(for id: String) -> URL? {
            URL(string: "\(Endpoint.baseURL)\(self.rawValue)/\(id)")
        }
    }

    /// 指定されたURLからデータを非同期に取得する
    /// - Parameter url: データを取得するURL
    /// - Returns: 取得したデータまたはエラーを含むResultオブジェクト
    @MainActor
    private func get(url: URL) async -> Result<Data, Error> {
        do {
            let (data, _) = try await URLSession.shared.data(for: URLRequest(url: url))
            return .success(data)
        } catch {
            return .failure(error)
        }
    }

    /// 指定されたIDとエンドポイントを使用して、APIからポケモンデータを取得する
    /// - Parameters:
    ///   - id: ポケモンのID
    ///   - endpoint: 使用するAPIエンドポイント
    /// - Returns: デコードされたデータまたはエラーを含むResultオブジェクト
    private func getPokeData<T: Decodable>(id: String, endpoint: Endpoint) async -> Result<T, ApiError> {
        guard let url = endpoint.url(for: id) else {
            return .failure(.urlError)
        }

        let result = await get(url: url)
        switch result {
        case .success(let data):
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                return .success(decodedData)
            } catch {
                return .failure(.jsonParseError(String(data: data, encoding: .utf8) ?? "Invalid data"))
            }
        case .failure(let error):
            return .failure(.responseError(error))
        }
    }

    /// 指定されたポケモンのリストを更新し、新しいポケモンのデータを非同期に取得する
    /// - Parameter pokemons: 現在のポケモンの配列
    /// - Returns: 更新後のポケモンの配列を含むResultオブジェクト
    func getNewPokemons(pokemons: [Pokemon]) async -> (Result<[Pokemon], ApiError>) {
        // ポケモン配列が0の場合は図鑑番号1番から、内容が存在する場合は最後のポケモン番号+1から　拡張性を考えてcountは使用しない
        let startPokemonId = pokemons.isEmpty ? 1 : pokemons.last!.id + 1
        let endPokemonId = startPokemonId + 20 // 1回の更新で20体のポケモンを取得してくる
        var newPokemons = pokemons

        await withTaskGroup(of: Result<(PokeIndividual, PokeSpecies), ApiError>.self) { group in
            for i in startPokemonId..<endPokemonId {
                group.addTask {
                    // 1つのポケモンにはIndividual(個体)とSpecies(種&多言語)の2種類の情報を持つ
                    async let individualResult: Result<PokeIndividual, ApiError> = self.getPokeData(id: i.description, endpoint: .pokemon)
                    async let speciesResult: Result<PokeSpecies, ApiError> = self.getPokeData(id: i.description, endpoint: .pokemonSpecies)

                    switch await (individualResult, speciesResult) {
                    case (.success(let individualResult), .success(let speciesResult)):
                        return .success((individualResult, speciesResult))

                    case (.failure(let error), _), (_, .failure(let error)):
                        return .failure(error)
                    }
                }
            }
            for await result in group {
                switch result {
                case .success(let (individual, species)):
                    let pokemon = Pokemon(id: individual.id, individual: individual, species: species)
                    newPokemons.append(pokemon)
                case .failure(let error):
                    print("API通信エラー: \(error)")
                }
            }
        }
        return .success(newPokemons.sorted{ $0.id < $1.id})
    }
}
