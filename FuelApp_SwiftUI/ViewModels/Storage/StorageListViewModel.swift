//
//  StorageListViewModel.swift
//  FuelApp_SwiftUI
//
//  Created by Malith Kuruppu on 2022-08-26.
//

import Foundation
import CoreData

@MainActor
class StorageListViewModel: NSObject, ObservableObject{
    
    @Published var storages = [StorageViewModel]()
    private let fetchedResultsController: NSFetchedResultsController<Storage>
    private (set) var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext){
        self.context = context
        fetchedResultsController = NSFetchedResultsController(
            fetchRequest: Storage.all,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        
        super.init()
        
        fetchedResultsController.delegate = self
        
        do{
            try fetchedResultsController.performFetch()
            
            guard let fetchedStorages = fetchedResultsController.fetchedObjects else{
                return
            }
            
            self.storages = fetchedStorages.map(StorageViewModel.init)
        } catch{
            print(error)
        }
        
    }
    
    func deleteStorage(storageId: NSManagedObjectID){
        do{
            guard let storage = try context.existingObject(with: storageId) as? Storage
            else{
                return
            }
            
            try storage.delete()
        }catch{
            print(error)
        }
    }
}

extension StorageListViewModel: NSFetchedResultsControllerDelegate{
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let fetchedStorages = controller.fetchedObjects as? [Storage] else{
            return
        }
        
        self.storages = fetchedStorages.map(StorageViewModel.init)
        
    }
}

struct StorageViewModel: Identifiable, Hashable{
    private var storage: Storage
    
    init(storage: Storage){
        self.storage = storage
    }
    
    var id: NSManagedObjectID{
        storage.objectID
    }
    
    var storageCapacity: Double{
        storage.storageCapacity
    }
    
    var currentAmount: Double{
        storage.currentAmount
    }
    var fuelType: String{
        storage.fuelTypes?.name ?? ""
    }
    
}
