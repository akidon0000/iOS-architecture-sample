package com.akidon0000.nationalpokedex.Model

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Serializable
data class Pokemon(
    @SerialName("id")
    val id: Int,

    @SerialName("individual")
    var individual: PokeIndividual,

    @SerialName("species")
    var species: PokeSpecies
) {
    companion object {
        // フシギダネ
        val mock = Pokemon(
            id = 1,
            individual = PokeIndividual.mock,
            species = PokeSpecies.mock
        )
    }
}
