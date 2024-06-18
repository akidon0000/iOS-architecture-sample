package com.akidon0000.nationalpokedex

import com.akidon0000.nationalpokedex.Model.PokeIndividual
import com.akidon0000.nationalpokedex.Model.Pokemon

sealed class PokemonResponse {
    object Loading : PokemonResponse()
    data class Error(val e: Exception) : PokemonResponse()
    data class Success(val data: List<PokeIndividual>) : PokemonResponse()
}