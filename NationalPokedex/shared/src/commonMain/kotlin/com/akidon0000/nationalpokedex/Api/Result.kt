package com.akidon0000.nationalpokedex.Api

import kotlinx.serialization.Serializable

@Serializable
sealed class Result<out T, out E> {
    data class success<out T>(val value: T) : Result<T, Nothing>()
    data class failure<out E>(val error: E) : Result<Nothing, E>()
}