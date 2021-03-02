//
//  RunicApp.swift
//  Shared
//
//  Created by Travis Luckenbaugh on 3/1/21.
//

import SwiftUI

@main
struct RunicApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            Runes()
        }
    }
}
