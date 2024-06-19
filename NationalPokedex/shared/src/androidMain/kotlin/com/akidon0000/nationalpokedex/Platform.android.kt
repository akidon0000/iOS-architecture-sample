package com.akidon0000.nationalpokedex

import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.collect
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch

actual class NativeFlow<T> actual constructor(private val flow: Flow<T>) {
    actual fun watch(block: (T) -> Unit) {
        GlobalScope.launch {
            flow.collect { value ->
                // Androidではメインスレッドでの操作が必要な場合、Handlerなどを使用
                block(value)
            }
        }
    }
}

class AndroidPlatform : Platform {
    override val name: String = "Android ${android.os.Build.VERSION.SDK_INT}"
}

actual fun getPlatform(): Platform = AndroidPlatform()