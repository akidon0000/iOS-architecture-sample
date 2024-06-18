package com.akidon0000.nationalpokedex

import com.akidon0000.nationalpokedex.Api.ProjectApi
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.flow

class Greeting {
    private val platform: Platform = getPlatform()

    private val api = ProjectApi()

    fun greet(): String {
        return "Hello, ${platform.name}!"
    }

    fun greet2(): Flow<String> = flow {
        emit(api.launchPhrase())
    }
}
