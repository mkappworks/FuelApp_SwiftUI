//
//  CoreDataManager.swift
//  FuelApp_SwiftUI
//
//  Created by Malith Kuruppu on 2022-08-26.
//

import Foundation
import CoreData

class CoreDataManager{
    let persistenceStoreController: NSPersistentContainer
    static let shared = CoreDataManager()
    
    private init(){
        persistenceStoreController = NSPersistentContainer(name: "FuelApp_SwiftUI")
        persistenceStoreController.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to initialise core data \(error)")
            }
        }
    }
}
