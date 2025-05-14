import SwiftUI
import Shared

struct ContentView: View {
    
    let viewModel = HomeViewModel()
    
    var body: some View {
        Observing(viewModel.state) { state in
            HomeView(
                state: state,
                inputText: Binding(
                    get: {
                        state.input.inputText
                    }, set: { newValue in
                        viewModel.onInputChanged(newValue: newValue)
                    }
                )
            )
        }
    }
}

//struct ContentView: View {
//    
//    let viewModel = HomeViewModel()
//    
//    @State private var state: HomeViewState = HomeViewState.companion.emptyState()
//    
//    var body: some View {
//        HomeView(
//            state: state,
//            inputText: Binding(
//                get: {
//                    state.input.inputText
//                }, set: { newValue in
//                    viewModel.onInputChanged(newValue: newValue)
//                }
//            )
//        )
//        .collect(flow: viewModel.state, into: $state)
//    }
//}

// MARK: - View

struct HomeView: View {
    let state: HomeViewState
    @Binding var inputText: String
    
    init(
        state: HomeViewState,
        inputText: Binding<String>
    ) {
        self.state = state
        self._inputText = inputText
    }
    
    var body: some View {
        NavigationView {
            textView
                .navigationTitle(state.navigationTitle)
                .navigationBarTitleDisplayMode(.large)
        }
    }
    
    private var textView: some View {
        VStack {
            Form {
                HStack {
                    Text("Email:")
                        .font(.headline)
                    TextField(
                        text: $inputText,
                        label: { Text(state.input.placeHolder) }
                    )
                }
                Text(state.input.inputMessage)
                    .fontWeight(.light)
                    .font(.body)
                    .foregroundStyle(
                        state.input.isInputValid ? .green : .red
                    )
            }
        }

    }
}

// MARK: - Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(HomeViewStateFakes.allCases, id: \.self) { state in
            HomeView(state: state.value, inputText: .constant(state.value.input.inputText))
                .previewDisplayName(state.name)
        }
    }
}
