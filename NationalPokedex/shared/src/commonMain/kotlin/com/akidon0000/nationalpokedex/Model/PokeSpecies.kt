package com.akidon0000.nationalpokedex.Model

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Serializable
data class PokeSpecies(
    val id: Int,
    val color: NameAndUrl,

    @SerialName("evolution_chain")
    val evolutionChain: EvolutionChain,
    val genera: List<Genera>,
    val names: List<Name>,

    @SerialName("flavor_text_entries")
    val flavorTextEntries: List<FlavorTextEntries>
) {
    companion object {
        // フシギダネ
        val mock = PokeSpecies(
            id = 1,
            color = NameAndUrl(name = "green", url = "https://pokeapi.co/api/v2/pokemon-color/5/"),
            evolutionChain = EvolutionChain(url = "https://pokeapi.co/api/v2/evolution-chain/1/"),
            genera = listOf(
                Genera(genus = "たねポケモン", language = NameAndUrl(name = "ja-Hrkt", url = "https://pokeapi.co/api/v2/language/1/"))
            ),
            names = listOf(
                Name(name = "フシギダネ", language = NameAndUrl(name = "ja", url = "https://pokeapi.co/api/v2/language/1/"))
            ),
            flavorTextEntries = listOf(
                FlavorTextEntries(
                    flavorText = "生まれて　しばらくの　あいだ 背中の　タネに　つまった 栄養を　とって　育つ。",
                    language = NameAndUrl(name = "ja", url = "https://pokeapi.co/api/v2/language/11/")
                )
            )
        )
    }
}

@Serializable
data class EvolutionChain(
    val url: String
)

@Serializable
data class Genera(
    val genus: String,
    val language: NameAndUrl
)

@Serializable
data class Name(
    val name: String,
    val language: NameAndUrl
)

@Serializable
data class FlavorTextEntries(
    @SerialName("flavor_text")
    val flavorText: String,
    val language: NameAndUrl
)