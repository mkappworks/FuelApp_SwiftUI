//
//  FuelApp_SwiftUIApp.swift
//  FuelApp_SwiftUI
//
//  Created by Malith Kuruppu on 2022-08-26.
//

import SwiftUI

@main
struct FuelApp_SwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            let viewContext = CoreDataManager.shared.persistenceStoreController.viewContext
            
            SplashView()
                .environment(\.managedObjectContext, viewContext)
        }
    }
}
