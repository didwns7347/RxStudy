//
//  DevTutorialsApp.swift
//  DevTutorials
//
//  Created by yangjs on 2023/06/21.
//

import SwiftUI

@main
struct DevTutorialsApp: App {
    @StateObject private var store = ScrumStore()
    let persistenceController = PersistenceController.shared
    @State private var scrums = DailyScrum.sampleData
    @State private var errorWrapper : ErrorWrapper?
    
    var body: some Scene {
        WindowGroup {
            ScrumView(scrums: $store.scrums){
                Task {
                    do {
                        try await store.save(scrums: store.scrums)
                    }catch {
//                        fatalError(error.localizedDescription)
                        errorWrapper = ErrorWrapper(error: error, guidance: "Try again later.")
                    }
                }
            }
            .task{
                do {
                    try await store.load()
                }catch {
//                    fatalError(error.localizedDescription)
                    errorWrapper = ErrorWrapper(error: error, guidance: "Scrumdinger will load sample data and continue.")
                }
            }
            .sheet(
                item: $errorWrapper,
                onDismiss: {
                    store.scrums = DailyScrum.sampleData
                },
                content: {wrapper in
                    ErrorView(errorWrapper: wrapper)
                }
            )
        }
        
    }
}
