//
//  FuelApp_SwiftUIApp.swift
//  FuelApp_SwiftUI
//
//  Created by Malith Kuruppu on 2022-08-26.
//

import SwiftUI

@main
struct FuelApp_SwiftUIApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
