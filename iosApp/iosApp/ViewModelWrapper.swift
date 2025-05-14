//
//  ViewModelWrapper.swift
//  iosApp
//
//  Created by Jeovane Barbosa on 13/05/25.
//  Copyright © 2025 orgName. All rights reserved.
//

import Shared
import SwiftUI

// MARK: - ViewModelWrapper
class ViewModelWrapper: ObservableObject {
    let viewModel = HomeViewModel()
    
    @Published
    private(set) var state: HomeViewState = HomeViewState.companion.emptyState()
    
    @Published
    var inputText: String = ""
    
    var actions: HomeViewModel {
        self.viewModel
    }
    
    @MainActor
    func activate() async {
        for await state in viewModel.state {
            self.state = state
            self.inputText = state.input.inputText
        }
    }
}

// MARK: - View
struct ContentView: View {
    
    @StateObject var viewModel = ViewModelWrapper()
    
    var body: some View {
        HomeView(
            state: viewModel.state,
            inputText: $viewModel.inputText,
            onInputChange: { newValue in viewModel.actions.onInputChanged(newValue: newValue) }
        )
        .task {
            await viewModel.activate()
        }
    }
}


struct HomeView: View {
    let state: HomeViewState
    let onInputChange: (String) -> Void
    
    @Binding
    var inputText: String
    
    init(
        state: HomeViewState,
        inputText: Binding<String>,
        onInputChange: @escaping (String) -> Void
    ) {
        self.state = state
        self._inputText = inputText
        self.onInputChange = onInputChange
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
                    .onChange(of: inputText) { newValue in
                        self.onInputChange(newValue)
                    }
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
            HomeView(state: state.value, inputText: .constant(state.value.input.inputText), onInputChange: {_ in })
                .previewDisplayName(state.name)
        }
    }
}
