package com.akidon0000.nationalpokedex.Model

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Serializable
data class PokeIndividual(
    @SerialName("id")
    val id: Int,

    @SerialName("name")
    val name: String,

    @SerialName("sprites")
    val sprites: Sprites,

    @SerialName("height")
    val height: Int,

    @SerialName("weight")
    val weight: Int,

    @SerialName("types")
    val types: List<PokeType>
) {
    companion object {
        // フシギダネ
        val mock = PokeIndividual(
            id = 1,
            name = "bulbasaur",
            sprites = Sprites(
                backDefault = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/1.png",
                backFemale = null,
                backShiny = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/1.png",
                backShinyFemale = null,
                frontDefault = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png",
                frontFemale = null,
                frontShiny = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/1.png",
                frontShinyFemale = null
            ),
            height = 7,
            weight = 69,
            types = listOf(
                PokeType(id = 1, type = NameAndUrl(name = "grass", url = "https://pokeapi.co/api/v2/type/12/")),
                PokeType(id = 2, type = NameAndUrl(name = "poison", url = "https://pokeapi.co/api/v2/type/4/"))
            )
        )
    }
}

@Serializable
data class NameAndUrl(
    val name: String,
    val url: String
)

@Serializable
data class Sprites(
    @SerialName("back_default")
    val backDefault: String?,
    @SerialName("back_female")
    val backFemale: String?,
    @SerialName("back_shiny")
    val backShiny: String?,
    @SerialName("back_shiny_female")
    val backShinyFemale: String?,
    @SerialName("front_default")
    val frontDefault: String?,
    @SerialName("front_female")
    val frontFemale: String?,
    @SerialName("front_shiny")
    val frontShiny: String?,
    @SerialName("front_shiny_female")
    val frontShinyFemale: String?
)

@Serializable
data class PokeType(
    @SerialName("slot")
    val id: Int,
    val type: NameAndUrl
)