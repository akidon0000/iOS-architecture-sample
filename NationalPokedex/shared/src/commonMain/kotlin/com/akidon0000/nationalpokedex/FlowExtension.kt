package com.akidon0000.nationalpokedex

// FlowExtensions.kt
import kotlinx.coroutines.flow.Flow

expect class NativeFlow<T>(flow: Flow<T>) {
    fun watch(block: (T) -> Unit)
}