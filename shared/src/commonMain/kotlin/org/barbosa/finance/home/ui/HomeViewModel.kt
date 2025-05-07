package org.barbosa.finance.home.ui

import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.delay
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.launch
import org.barbosa.finance.home.ui.fakes.HomeViewStateFakes
import kotlin.time.Duration.Companion.seconds

public class HomeViewModel{
    private val _state = MutableStateFlow(
        HomeViewState(
            expenses = listOf(),
        )
    )

    val stateFlow: StateFlow<HomeViewState> = _state.asStateFlow()

    public fun onCreate() {
        CoroutineScope(Dispatchers.Default).launch {
            _state.value = HomeViewStateFakes.EMPTY.value
            delay(duration = 5.seconds)
            _state.value = HomeViewStateFakes.ONE_ELEMENT.value
            delay(duration = 5.seconds)
            _state.value = HomeViewStateFakes.SEVERAL_ELEMENTS.value
        }
    }
}

