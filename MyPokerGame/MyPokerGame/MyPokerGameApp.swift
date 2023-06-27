//
//  MyPokerGameApp.swift
//  MyPokerGame
//
//  Created by yangjs on 2023/06/27.
//

import SwiftUI

@main
struct MyPokerGameApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
