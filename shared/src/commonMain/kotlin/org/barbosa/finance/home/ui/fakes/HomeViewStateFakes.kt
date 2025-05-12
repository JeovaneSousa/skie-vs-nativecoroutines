package org.barbosa.finance.home.ui.fakes

import org.barbosa.finance.home.ui.HomeStrings
import org.barbosa.finance.home.ui.HomeViewState
import org.barbosa.finance.home.ui.InputData

public enum class HomeViewStateFakes(val value: HomeViewState, val inputText: String) {
    EMPTY(value = emptyList, inputText = ""),
    VALID(value = oneElement, inputText = "jeovane.barbosa@aiqfome.com"),
    INVALID(value = severalElements, inputText = "jeovane.barbosaqfome-tralala.com")
}

private val strings = HomeStrings()

private val emptyList = HomeViewState(
    navigationTitle = strings.navigationTitle,

    input = InputData(
        placeHolder = strings.inputDataStrings.placeHolder
    )
)

private val oneElement = HomeViewState(
    navigationTitle = strings.navigationTitle,
    input = InputData(
        isInputValid = true,
        inputMessage = strings.inputDataStrings.correctInputText,
        placeHolder = strings.inputDataStrings.placeHolder
    )
)

private val severalElements = HomeViewState(
    navigationTitle = strings.navigationTitle,
    input = InputData(
        isInputValid = false,
        inputMessage = strings.inputDataStrings.wrongInputText,
        placeHolder = strings.inputDataStrings.placeHolder
    )
)