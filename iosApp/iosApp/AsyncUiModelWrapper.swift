//
//  AsyncUiModelWrapper.swift
//  iosApp
//
//  Created by Jeovane Barbosa on 09/05/25.
//  Copyright © 2025 orgName. All rights reserved.
//
import Shared
import KMPNativeCoroutinesAsync
import SwiftUI

// MARK: - UiModelWrapper using Combine
@MainActor
final class AsyncUiModel: ObservableObject {
    private let viewModel: HomeViewModel
    private var observationTask: Task<Void, Never>?
    
    @Published var state: HomeViewState
    
    init(viewModel: HomeViewModel = .init()) {
        self.viewModel = viewModel
        self.state = viewModel.state
        
        observeState()
    }
    
    private func observeState() {
        observationTask = Task {
            do {
                let sequence = asyncSequence(for: viewModel.stateFlow)
                for try await newState in sequence {
                    self.state = newState
                }
            } catch {
                print("Observation failed: \(error)")
            }
        }
    }
}
