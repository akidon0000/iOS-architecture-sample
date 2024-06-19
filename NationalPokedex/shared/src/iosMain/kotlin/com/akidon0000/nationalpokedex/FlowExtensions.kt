package com.akidon0000.nationalpokedex

// FlowExtensions.kt
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.collect
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch
import platform.darwin.dispatch_async
import platform.darwin.dispatch_get_main_queue

actual class NativeFlow<T> actual constructor(private val flow: Flow<T>) {
    actual fun watch(block: (T) -> Unit) {
        GlobalScope.launch {
            flow.collect { value ->
                dispatch_async(dispatch_get_main_queue()) {
                    block(value)
                }
            }
        }
    }
}