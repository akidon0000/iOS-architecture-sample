package com.akidon0000.nationalpokedex.Api

import kotlinx.serialization.Serializable

@Serializable
sealed class ApiError : Throwable() {
    object UrlError : ApiError()
    data class ResponseError(val error: Throwable) : ApiError()
    object ResponseDataEmpty : ApiError()
    data class JsonParseError(val json: String) : ApiError()

    override val message: String?
        get() = when (this) {
            is UrlError -> "URL変換失敗"
            is ResponseError -> "APIレスポンスエラー 詳細: (${error.toString()})"
            is ResponseDataEmpty -> "APIのレスポンスデータがnil"
            is JsonParseError -> "JSONのパースに失敗しました。失敗したデータ: ($json)"
        }
}
