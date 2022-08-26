//
//  BaseModel.swift
//  FuelApp_SwiftUI
//
//  Created by Malith Kuruppu on 2022-08-26.
//

import Foundation
import CoreData

protocol BaseModel{
    static var viewContext: NSManagedObjectContext {get}
    func save() throws
    func delete() throws
}

extension BaseModel where Self:NSManagedObject {
    static var viewContext: NSManagedObjectContext{
        CoreDataManager.shared.persistenceStoreController.viewContext
    }
    
    func save() throws {
        try Self.viewContext.save()
    }
    
    func delete() throws {
        Self.viewContext.delete(self)
        try save()
    }
    
}

enum FuelType: String, CaseIterable{
    case diesel = "Diesel"
    case petrol = "Petrol"
}

