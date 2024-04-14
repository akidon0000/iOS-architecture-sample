//
//  PokeApiModel.swift
//  NationalPokedex
//
//  Created by Akihiro Matsuyama on 2024/04/05.
//

import Foundation

protocol PokeApiModelProtocol {
    func getPokemon(name: String, completion: @escaping (Result<Pokemon, ApiError>) -> Void)
    func getPokemons(name: String) async -> Result<Pokemon, ApiError>
    func getPokemonSpecies(name: String, completion: @escaping (Result<PokemonSpecies, ApiError>) -> Void)
}

struct PokeApiModel: PokeApiModelProtocol {
    private var endpoint: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "pokeapi.co"
        return components
    }

    @MainActor
    private func get(url: URL) async -> Result<Data, Error> {
        do {
            let (data, _) = try await URLSession.shared.data(for: URLRequest(url: url))
            return .success(data)
        } catch {
            return .failure(error)
        }
    }

    func getPokeDex(completion: @escaping (Result<PokeDex, ApiError>) -> Void) {
        var urlComponents = endpoint
        urlComponents.path = "/api/v2/pokedex/1/"

        guard let url = urlComponents.url else {
            completion(.failure(.urlError))
            return
        }

        Task {
            let result = await get(url: url)

            switch result {
            case .success(let data):
                guard let repositories = try? JSONDecoder().decode(PokeDex.self, from: data) else {
                    completion(.failure(.jsonParseError(String(data: data, encoding: .utf8) ?? "")))
                    return
                }
                completion(.success(repositories))
            case .failure(let error):
                completion(.failure(.responseError(error)))
            }
        }
    }

    func getPokemon(name: String, completion: @escaping (Result<Pokemon, ApiError>) -> Void) {
        var urlComponents = endpoint
        urlComponents.path = "/api/v2/pokemon/\(name)"

        guard let url = urlComponents.url else {
            completion(.failure(.urlError))
            return
        }

        Task {
            let result = await get(url: url)

            switch result {
            case .success(let data):
                guard let repositories = try? JSONDecoder().decode(Pokemon.self, from: data) else {
                    completion(.failure(.jsonParseError(String(data: data, encoding: .utf8) ?? "")))
                    return
                }
                completion(.success(repositories))
            case .failure(let error):
                completion(.failure(.responseError(error)))
            }
        }
    }

    @MainActor
    func getPokemons(name: String) async -> Result<Pokemon, ApiError> {
        var urlComponents = endpoint
        urlComponents.path = "/api/v2/pokemon/\(name)"

        guard let url = urlComponents.url else {
            return .failure(.urlError)
        }

        let result = await get(url: url)
        switch result {
        case .success(let data):
            do {
                let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                return .success(pokemon)
            } catch {
                return .failure(.jsonParseError(String(data: data, encoding: .utf8) ?? "Invalid data"))
            }
        case .failure(let error):
            return .failure(.responseError(error))
        }
    }


    func getPokemonSpecies(name: String, completion: @escaping (Result<PokemonSpecies, ApiError>) -> Void) {
        var urlComponents = endpoint
        urlComponents.path = "/api/v2/pokemon-species/\(name)"

        guard let url = urlComponents.url else {
            completion(.failure(.urlError))
            return
        }

        Task {
            let result = await get(url: url)

            switch result {
            case .success(let data):
                guard let repositories = try? JSONDecoder().decode(PokemonSpecies.self, from: data) else {
                    print(String(data: data, encoding: .utf8) ?? "")
                    completion(.failure(.jsonParseError(String(data: data, encoding: .utf8) ?? "")))
                    return
                }
                completion(.success(repositories))
            case .failure(let error):
                completion(.failure(.responseError(error)))
            }
        }
    }

//    enum Lang {
//        case ja
//        case en
//    }
//
//    private convertLang(word: String, to: Lang) -> String {
//
//    }
}
