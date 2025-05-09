import SwiftUI
import Shared

// MARK: - WrapperView
struct ContentView: View {
    
    let viewModel: HomeViewModel
    
    init(
        viewModel: HomeViewModel = .init(),
    ) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Observing(viewModel.state) { state in
            HomeView(
                state: state,
                onInputChange: { newValue in
                    viewModel.onInputChanged(newValue: newValue)
                }
            )
        }
    }
}

// MARK: - ActualView
struct HomeView: View {
    let state: HomeViewState
    let onInputChange: (String) -> Void
    @Binding var inputText: String
    
    init(
        state: HomeViewState,
        onInputChange: @escaping (String) -> Void
    ) {
        self.state = state
        self.onInputChange = onInputChange
        
        _inputText = Binding(
            get: { state.input.inputText },
            set: { newValue in onInputChange(newValue) }
        )
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
        VStack {
            Form {
                HStack {
                    Text("Email:").font(.headline)
                    textView
                }
                placeHolderView
            }
        }
    }
    
    private var textView: some View {
        TextField(
            text: $inputText,
            label: {
                Text(state.input.placeHolder)
            }
        )
        .autocorrectionDisabled()
        .textInputAutocapitalization(.never)
    }
    
    private var placeHolderView: some View {
        Text(state.input.inputMessage)
            .fontWeight(.light)
            .font(.body)
            .foregroundStyle(
                state.input.isInputValid ? .green : .red
            )
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
