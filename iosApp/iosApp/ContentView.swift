import SwiftUI
import Shared

struct ContentView: View {
    
    let viewModel = HomeViewModel()
    
    var body: some View {
        Observing(viewModel.stateFlow) { state in
            HomeView(
                state: state,
                onInputChange: { newValue in
                    viewModel.onInputChanged(newValue: newValue)
                }
            )
        }
        .onAppear {
            viewModel.onCreate()
        }
    }
}

struct HomeView: View {
    let state: HomeViewState
    let onInputChange: (String) -> Void
    
    init(state: HomeViewState, onInputChange: @escaping (String) -> Void) {
        self.state = state
        self.onInputChange = onInputChange
    }
    
    var body: some View {
        NavigationView {
            contentView
                .navigationTitle(state.navigationTitle)
                .navigationBarTitleDisplayMode(.large)
        }
    }
        
    @ViewBuilder
    private var contentView: some View {
        VStack(alignment: .center) {
            textView
        }

    }
    
    private var textView: some View {
        VStack {
            Form {
                HStack {
                    Text("Email:")
                        .font(.headline)
                    TextField(
                        text: Binding(
                            get: {
                            state.input.inputText
                            },
                            set: { newValue in
                                onInputChange(
                                    newValue
                                )
                        }),
                        label: {
                            Text(state.input.placeHolder)
                        }
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
            HomeView(state: state.value, onInputChange: { _ in })
                .previewDisplayName(state.name)
        }
    }
}
