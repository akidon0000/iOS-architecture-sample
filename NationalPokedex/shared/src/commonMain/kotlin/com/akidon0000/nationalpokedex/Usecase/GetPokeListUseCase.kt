package com.akidon0000.nationalpokedex.Usecase

import com.akidon0000.nationalpokedex.Api.ApiModel



object GetPokeListUseCase {
    private val repo = ApiModel()

//    suspend operator fun invoke(): PokemonResponse  {
//        return try {
//            PokemonResponse.Success(repo.getPokeList())
//        } catch (e: Exception) {
//            PokemonResponse.Error(e)
//        }
//    }

//    fun sendGetRequest(url: String): String {
//        val url = URL(url)
//        val connection = url.openConnection() as HttpURLConnection
//        connection.requestMethod = "GET"
//
//        val responseCode = connection.responseCode
//        println("Response Code: $responseCode")
//
//        val response = StringBuilder()
//        BufferedReader(InputStreamReader(connection.inputStream)).use { reader ->
//            var line: String?
//            while (reader.readLine().also { line = it } != null) {
//                response.append(line)
//            }
//        }
//
//        return response.toString()
//    }
}