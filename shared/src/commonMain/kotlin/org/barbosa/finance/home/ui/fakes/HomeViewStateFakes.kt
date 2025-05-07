package org.barbosa.finance.home.ui.fakes

import org.barbosa.finance.home.ui.Expense
import org.barbosa.finance.home.ui.HomeViewState
import org.barbosa.finance.home.ui.PaymentMethod

public enum class HomeViewStateFakes(val value: HomeViewState) {
    EMPTY(value = emptyList),
    ONE_ELEMENT(value = oneElement),
    SEVERAL_ELEMENTS(value = severalElements)
}

private val emptyList = HomeViewState(
    navigationTitle = "Sem despesas",
    expenses = listOf(),
)

private val oneElement = HomeViewState(
    navigationTitle = "Lista de depesas",
    expenses = listOf(
        Expense(
            "Car",
            paymentMethod = PaymentMethod.CREDIT
        ),
    ),
)

private val severalElements = HomeViewState(
    navigationTitle = "Lista de depesas",
    expenses = listOf(
        Expense(
            "Car",
            paymentMethod = PaymentMethod.CREDIT
        ),
        Expense(
            "Bike",
            paymentMethod = PaymentMethod.DEBIT
        ),
        Expense(
            "Pc",
            paymentMethod = PaymentMethod.MONEY
        ),
    ),
)