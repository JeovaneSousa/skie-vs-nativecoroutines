package org.barbosa.finance.home.ui

import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.launch

public class HomeViewModel{
    private val strings = HomeStrings()

    private val _state = MutableStateFlow(
        HomeViewState(
            expenses = listOf(),
        )
    )

    val stateFlow: StateFlow<HomeViewState> = _state.asStateFlow()

    public fun onCreate() {
        CoroutineScope(Dispatchers.Default).launch {
              _state.value = stateFlow.value.copy(
                  navigationTitle = strings.navigationTitle
              )
        }
    }

    public fun onInputChanged(newValue: String) {
        val isInputValid = validadeInput(newValue)
        _state.value = _state.value.copy(
            input = InputData(
                inputText = newValue,
                isInputValid = isInputValid,
                inputMessage = setInputMessage(isValidInput = isInputValid, input = newValue),
                placeHolder = strings.inputDataStrings.placeHolder
            )
        )
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

