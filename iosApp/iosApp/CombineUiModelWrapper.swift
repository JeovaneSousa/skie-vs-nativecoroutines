//
//  UiModelWrapper.swift
//  iosApp
//
//  Created by Jeovane Barbosa on 09/05/25.
//  Copyright © 2025 orgName. All rights reserved.
//
import Shared
import SwiftUI
import KMPNativeCoroutinesCombine
import Combine
// MARK: - UiModelWrapper using Combine

final class CombineUiModel: ObservableObject {
    private let viewModel: HomeViewModel
    private var cancellable: AnyCancellable?

    @Published var state: HomeViewState

    init(viewModel: HomeViewModel = .init()) {
        self.viewModel = viewModel
        self.state = viewModel.state

        observeState()
    }
    
    private func observeState() {
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
