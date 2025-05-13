package org.barbosa.finance.home.ui

public data class HomeViewState(
    val navigationTitle: String = "",
    val expenses: List<Expense> = listOf(),
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