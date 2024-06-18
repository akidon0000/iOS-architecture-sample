package com.akidon0000.nationalpokedex




sealed class KmpResponse<out T> {
    object Loading : KmpResponse<Nothing>()
    data class Success<T>(val data: T) : KmpResponse<T>()
    data class Error(val exception: Exception) : KmpResponse<Nothing>()
}