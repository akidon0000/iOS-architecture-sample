package com.akidon0000.nationalpokedex.Api

import com.akidon0000.nationalpokedex.Model.*
import io.ktor.client.HttpClient
import io.ktor.client.plugins.contentnegotiation.ContentNegotiation
import io.ktor.serialization.kotlinx.json.json
import io.ktor.client.request.*
import io.ktor.client.call.*
import kotlinx.serialization.json.Json
import kotlinx.serialization.serializer
import kotlin.reflect.KClass

interface PokeApiModelProtocol {
    suspend fun getNewPokemons(pokemons: List<Pokemon>): Result<List<Pokemon>, ApiError>
}

class PokeApiModel : PokeApiModelProtocol {
    enum class Endpoint(val path: String) {
        POKEMON("pokemon"),
        POKEMON_SPECIES("pokemon-species");

        companion object {
            const val BASE_URL = "https://pokeapi.co/api/v2/"
        }

        fun url(id: String): String {
            return "$BASE_URL${this.path}/$id"
        }
    }

    override suspend fun getNewPokemons(pokemons: List<Pokemon>): Result<List<Pokemon>, ApiError> {
        val startPokemonId = if (pokemons.isEmpty()) 1 else pokemons.last().id + 1
        val newPokemons = getMultiplePokemon(startId = startPokemonId, count = 20)
        return Result.success(newPokemons)
    }

    private suspend fun getMultiplePokemon(startId: Int, count: Int): List<Pokemon> {
        val pokemonList = mutableListOf<Pokemon>()

        for (id in startId until (startId + count)) {
            val result = getNewPokemon(id.toString())
            when (result) {
                is Result.success -> pokemonList.add(result.value)
                is Result.failure -> println("Failed to get Pokemon with id $id: ${result.error}")
            }
        }
        return pokemonList
    }

    private suspend fun getNewPokemon(id: String): Result<Pokemon, ApiError> {
        val individualResult: Result<PokeIndividual, ApiError> = getPokeData(id, Endpoint.POKEMON, PokeIndividual::class)
        val speciesResult: Result<PokeSpecies, ApiError> = getPokeData(id, Endpoint.POKEMON_SPECIES, PokeSpecies::class)

        return when {
            individualResult is Result.success && speciesResult is Result.success -> {
                Result.success(Pokemon(id = individualResult.value.id, individual = individualResult.value, species = speciesResult.value))
            }
            individualResult is Result.failure -> Result.failure(individualResult.error)
            speciesResult is Result.failure -> Result.failure(speciesResult.error)
            else -> Result.failure(ApiError.UrlError)
        }
    }

    @OptIn(kotlinx.serialization.InternalSerializationApi::class)
    private suspend fun <T> getPokeData(id: String, endpoint: Endpoint, type: KClass<T>): Result<T, ApiError> where T : Any {
        val url: String = endpoint.url(id)

        return try {
            val json = Json { ignoreUnknownKeys = true }
            val response: String = httpClient.get(url).body()
            val pokemon: T = json.decodeFromString(type.serializer() , response)
            Result.success(pokemon)
        } catch (e: Exception) {
            println("ERROR: $e")
            Result.failure(ApiError.JsonParseError(e.toString()))
        }
    }

    private val httpClient = HttpClient {
        install(ContentNegotiation) {
            json(Json {
                prettyPrint = true
                isLenient = true
                ignoreUnknownKeys = true
            })
        }
    }
}

