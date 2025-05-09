package org.barbosa.finance.home.ui.fakes

import org.barbosa.finance.home.ui.HomeStrings
import org.barbosa.finance.home.ui.HomeViewState
import org.barbosa.finance.home.ui.InputData

public enum class HomeViewStateFakes(val value: HomeViewState) {
    EMPTY(value = emptyList),
    VALID(value = oneElement),
    INVALID(value = severalElements)
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
        inputText = "jeovane.barbosa@aiqfome.com",
        isInputValid = true,
        inputMessage = strings.inputDataStrings.correctInputText,
        placeHolder = strings.inputDataStrings.placeHolder
    )
)

private val severalElements = HomeViewState(
    navigationTitle = strings.navigationTitle,
    input = InputData(
        inputText = "jeovane.barbosa--Tralala.com",
        isInputValid = false,
        inputMessage = strings.inputDataStrings.wrongInputText,
        placeHolder = strings.inputDataStrings.placeHolder
    )
)