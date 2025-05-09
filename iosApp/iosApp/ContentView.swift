import SwiftUI
import Shared
import KMPNativeCoroutinesCombine
import Combine

final class UiModel: ObservableObject {
    private let viewModel: HomeViewModel
    private var cancellable: AnyCancellable?

    @Published var state: HomeViewState

    init(viewModel: HomeViewModel = HomeViewModel()) {
        self.viewModel = viewModel
        self.state = viewModel.state

        let publisher = createPublisher(for: viewModel.stateFlow)
        self.cancellable = publisher
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { [weak self] newState in
                    self?.state = newState
                }
            )
    }
}

struct ContentView: View {
    
    @StateObject var uiModel: UiModel
    
    var body: some View {
        HomeView(state: uiModel.state)
    }
}

struct HomeView: View {
    let state: HomeViewState
    
    var body: some View {
        NavigationView {
            contentView
                .navigationTitle(state.navigationTitle)
                .navigationBarTitleDisplayMode(.large)
        }
    }
    
    @ViewBuilder
    private var contentView: some View {
        if state.expenses.isEmpty {
            emptyView
        } else {
            listView
        }
    }
    
    private var listView: some View {
        List(state.expenses, id: \.self) { expense in
            HStack {
                Text(expense.title)
                Spacer()
                getRightPaymentMethodIcon(method: expense.paymentMethod)
            }
        }
    }
    
    private var emptyView: some View {
        Text("Empty")
    }
    
    private func getRightPaymentMethodIcon(method: PaymentMethod) -> some View {
        switch method {
        case .credit:
            Image(systemName: "cart")
        case .debit:
            Image(systemName: "bag.badge.questionmark.ar")
        case .money:
            Image(systemName: "dollarsign.circle")
        }
        
    }
}

// MARK: - Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(HomeViewStateFakes.allCases, id: \.self) { state in
            HomeView(state: state.value).previewDisplayName(state.name)
        }
    }
}
