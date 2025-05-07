package org.barbosa.finance

interface Platform {
    val name: String
}

expect fun getPlatform(): Platform