import SwiftUI
import Shared
import KMPNativeCoroutinesCombine
import Combine

// MARK: - UIModelWrapper

class UiModel: ObservableObject {
    private let viewModel: HomeViewModel
    private var cancellables = Set<AnyCancellable>()
    
    
    @Published var state: HomeViewState
    @Published var inputText: String = ""
    
    var actions: HomeViewModel { viewModel.self }

    init(viewModel: HomeViewModel, state: HomeViewState) {
        self.viewModel = viewModel
        self.state = state
        
        let publisher = createPublisher(for: viewModel.state)
        
        publisher
            .receive(on: DispatchQueue.main)
            .sink { _ in} receiveValue: { [weak self] state in
                self?.state = state
            }
            .store(in: &cancellables)
        
        $inputText
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink { newValue in
                viewModel.onInputChanged(newValue: newValue)
            }
            .store(in: &cancellables)
    }
}

// MARK: - View

struct ContentView: View {
    
    @StateObject private var viewModel = UiModel(
        viewModel: HomeViewModel(),
        state: .companion.emptyState(),
    )
    
    var body: some View {
        HomeView(
            state: viewModel.state,
            inputText: $viewModel.inputText
        )
        
    }
}

struct HomeView: View {
    let state: HomeViewState
    let inputText: Binding<String>
    
    init(state: HomeViewState, inputText: Binding<String>) {
        self.state = state
        self.inputText = inputText
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
                        text: inputText,
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
            HomeView(state: state.value, inputText: .constant(state.inputText))
                .previewDisplayName(state.name)
        }
    }
}
