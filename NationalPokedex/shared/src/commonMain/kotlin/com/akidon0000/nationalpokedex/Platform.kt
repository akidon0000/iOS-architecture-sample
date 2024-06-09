package com.akidon0000.nationalpokedex

interface Platform {
    val name: String
}

expect fun getPlatform(): Platform