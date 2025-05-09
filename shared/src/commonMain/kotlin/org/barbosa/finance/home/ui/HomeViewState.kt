package org.barbosa.finance.home.ui

public data class HomeViewState(
    val navigationTitle: String = "",
    val input: InputData = InputData(),
    val expenses: List<Expense> = listOf(),
) {
   companion object {
       public fun emptyState() = HomeViewState()
   }
}

public data class InputData(
    val isInputValid: Boolean = false,
    val inputMessage: String = "",
    val placeHolder: String = ""
)

public data class Expense(
    val title: String,
    val paymentMethod: PaymentMethod,
)

public enum class PaymentMethod(val description: String) {
    MONEY(description = "Cash"),
    DEBIT(description = "Debit"),
    CREDIT(description = "Credit"),
}