package org.barbosa.finance.home.ui

import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.delay
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.update
import kotlinx.coroutines.launch
import kotlin.time.Duration.Companion.seconds

public class HomeViewModel{
    private val strings = HomeStrings()

    private val _state = MutableStateFlow(
        HomeViewState(
            expenses = listOf(),
        )
    )

    val state: StateFlow<HomeViewState> = _state.asStateFlow()

    init {
        onCreate()
    }

    public fun onCreate() {
        CoroutineScope(Dispatchers.Default).launch {
              _state.update {
                  it.copy(
                      navigationTitle = strings.navigationTitle
                  )
              }
            delay(5.seconds)
            _state.update {
                it.copy(
                    navigationTitle = "New title! Bam!"
                )
            }
        }
    }

    public fun onInputChanged(newValue: String) {
        val isInputValid = validadeInput(newValue)
        
        _state.update {
            it.copy(
                input = InputData(
                    inputText = newValue,
                    isInputValid = isInputValid,
                    inputMessage = setInputMessage(isValidInput = isInputValid, input = newValue),
                    placeHolder = strings.inputDataStrings.placeHolder
                )
            )
        }
    }

    private fun validadeInput(input: String): Boolean {
        return input.contains("@")
    }

    private fun setInputMessage(isValidInput: Boolean, input: String): String {
        if (input.isEmpty()) { return ""}
        return when (isValidInput) {
            true -> strings.inputDataStrings.correctInputText
            false -> strings.inputDataStrings.wrongInputText
        }
    }
}

