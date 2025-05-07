package org.barbosa.finance.home.ui

data class HomeStrings(
    val navigationTitle: String = "Cadastre seu Email",
    val inputDataStrings: InputDataStrings = InputDataStrings()
)

data class InputDataStrings(
    val emptyInputText: String = "",
    val correctInputText: String = "Email Correto",
    val wrongInputText: String = "Seu email não é válido",
    val placeHolder: String = "Escreve seu email"
)