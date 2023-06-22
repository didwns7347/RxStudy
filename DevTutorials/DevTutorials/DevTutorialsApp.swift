//
//  DevTutorialsApp.swift
//  DevTutorials
//
//  Created by yangjs on 2023/06/21.
//

import SwiftUI

@main
struct DevTutorialsApp: App {
    let persistenceController = PersistenceController.shared
    @State private var scrums = DailyScrum.sampleData

    var body: some Scene {
        WindowGroup {
            ScrumView(scrums: $scrums)
        }
    }
}
