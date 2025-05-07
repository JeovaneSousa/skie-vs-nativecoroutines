import SwiftUI
import Shared

struct ContentView: View {
    
    let viewModel = HomeViewModel()
    
    var body: some View {
        Observing(viewModel.stateFlow) { state in
            HomeView(state: state)
                .onAppear {
                    viewModel.onCreate()
                }
        }
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
