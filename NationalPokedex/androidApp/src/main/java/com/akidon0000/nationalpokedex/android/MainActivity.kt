package com.akidon0000.nationalpokedex.android

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.Column
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import com.akidon0000.nationalpokedex.Api.ApiModel
import com.akidon0000.nationalpokedex.Greeting
import com.akidon0000.nationalpokedex.Usecase.GetPokeListUseCase
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.flow.collect
import kotlinx.coroutines.launch

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            MyApplicationTheme {
                Surface(
                    modifier = Modifier.fillMaxSize(),
                    color = MaterialTheme.colorScheme.background
                ) {
                    GreetingView()
                }
            }
        }
    }
}

@Composable
fun GreetingView() {
    var text by remember { mutableStateOf("Hello, Android!") }

    Column(
        modifier = Modifier.padding(16.dp)
    ) {
        Text(text = text)
        Button(
            onClick = {
                CoroutineScope(Dispatchers.IO).launch {
                    Greeting().greet2().collect { res ->
                        text = res
                    }
                    // APIを呼び出すコードをここに記述
//                    val response = Greeting().greet3()
//                    text = response.toString() // 結果を表示
                }
            },
            modifier = Modifier.padding(top = 16.dp)
        ) {
            Text(text = "APIを呼び出す")
        }
    }
}

@Preview
@Composable
fun DefaultPreview() {
    MyApplicationTheme {
        GreetingView()
    }
}
