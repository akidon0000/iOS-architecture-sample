package com.akidon0000.nationalpokedex

import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.flow

class Greeting {
    private val platform: Platform = getPlatform()

    fun greet(): String {
        return "Hello, ${platform.name}!"
    }

    fun greet2(): Flow<String> = flow {
//        emit(api.launchPhrase())
    }

//    fun greet3(): Flow<>
}
