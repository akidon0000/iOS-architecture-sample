package com.akidon0000.nationalpokedex.Api

import com.akidon0000.nationalpokedex.Model.PokeIndividual
import io.ktor.client.HttpClient
import io.ktor.client.plugins.contentnegotiation.ContentNegotiation
import io.ktor.serialization.kotlinx.json.json
import io.ktor.client.request.*
import io.ktor.client.call.*
import kotlinx.serialization.json.Json

class ProjectApi {

    private val httpClient = HttpClient {
        install(ContentNegotiation) {
            json(Json {
                prettyPrint = true
                isLenient = true
                ignoreUnknownKeys = true
            })
        }
    }

    suspend fun getTest(): String {
        return try {
            val json = Json { ignoreUnknownKeys = true }
            val response: String = httpClient.get(ApiModel.Endpoint.pokemon).body()
            val pokemon: PokeIndividual = json.decodeFromString(response)
            pokemon.toString()
        } catch (e: Exception) {
            println("ERROR: $e")
            "Error occurred"
        }
    }

    suspend fun launchPhrase(): String =
        try {
            "The last successful launch was on ${getTest()} 🚀"
        } catch (e: Exception) {
            println("ERROR: $e")
            "Error occurred"
        }
}