package com.akidon0000.nationalpokedex.Api

interface ApiModelInterface {
}

class ApiModel : ApiModelInterface {
    object Endpoint {
        private const val version =  "v2"
        const val pokemon = "https://pokeapi.co/api/$version/pokemon/1"
        const val pokemonSpecies = "https://pokeapi.co/api/$version/pokemon-species/"
    }
}