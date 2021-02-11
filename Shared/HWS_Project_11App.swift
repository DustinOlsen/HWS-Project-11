//
//  HWS_Project_11App.swift
//  Shared
//
//  Created by Dustin Olsen on 2/11/21.
//

import SwiftUI

@main
struct HWS_Project_11App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
