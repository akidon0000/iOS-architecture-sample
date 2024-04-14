//
//  ApiError.swift
//  NationalPokedex
//
//  Created by Akihiro Matsuyama on 2024/04/05.
//

import Foundation

/// APIを叩く際に発生する可能性のあるエラー一覧
enum ApiError: Error {
    case urlError
    case responseError(Error)
    case responseDataEmpty
    case jsonParseError(String)

    var localizedDescription: String {
        switch self {
        case .urlError: return "URL変換失敗"
        case .responseError(let error): return "APIレスポンスエラー　詳細: （\(error)）"
        case .responseDataEmpty: return "APIのレスポンスデータがnil"
        case .jsonParseError(let message): return "JSONのパースに失敗しました。失敗したデータ: (\(message)"
        }
    }
}
