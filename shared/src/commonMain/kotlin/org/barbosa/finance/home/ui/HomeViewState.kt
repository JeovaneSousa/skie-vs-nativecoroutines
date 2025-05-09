package org.barbosa.finance.home.ui

public data class HomeViewState(
    val navigationTitle: String = "",
    val input: InputData = InputData(),
)

public data class InputData(
    val inputText: String = "",
    val isInputValid: Boolean = false,
    val inputMessage: String = "",
    val placeHolder: String = ""
)