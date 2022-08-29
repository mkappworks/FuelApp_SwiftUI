//
//  StorageFuelListViewModel.swift
//  FuelApp_SwiftUI
//
//  Created by Malith Kuruppu on 2022-08-26.
//

import Foundation
import CoreData

@MainActor
class StorageFuelListViewModel: NSObject, ObservableObject{
    
    @Published var errorMessage: String = ""
    @Published var isError: Bool = false
    
    @Published var selectedStorage: StorageViewModel? {
        didSet {
            storage = selectedStorage?.storageEntity
            setupFetchRequestPredicateAndFetch()
        }
    }
    
    @Published var storages = [StorageViewModel]()
    @Published var storageFuels = [StorageFuelViewModel]()
    @Published var storage: Storage?
    
    private let fetchedResultsController: NSFetchedResultsController<FuelTransaction>
    
    var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext){
        self.context = context
        
        fetchedResultsController = NSFetchedResultsController(
            fetchRequest: FuelTransaction.all,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        
        super.init()
        
        fetchedResultsController.delegate = self
        
        setupFetchResultsController()
        
        getStorages()
    }
    
    func deleteStorageFuel(storageFuelId: NSManagedObjectID){
        do{
            guard let storageFuel = try context.existingObject(with: storageFuelId) as? FuelTransaction
            else{
                return
            }
            
            try storageFuel.delete()
        }catch{
            print(error)
        }
    }
    
    private func getStorages(){
        do{
            let request = NSFetchRequest<Storage>(entityName: "Storage")
            
            let fetchedStorages = try context.fetch(request)
            
            storages = fetchedStorages.map(StorageViewModel.init)
            
            if(storages.count == 0){
                errorMessage.append(contentsOf: "No Storages found. Please add a Storage. ")
                isError = true
                return
            }
            
            storage = fetchedStorages.first
            selectedStorage = storages.first
            
        }catch{
            print(error)
        }
        
    }
    
    private func setupFetchResultsController() {
        do{
            try fetchedResultsController.performFetch()
            
            guard let fetchedStorageFuels = fetchedResultsController.fetchedObjects else{
                return
            }
            
            self.storageFuels = fetchedStorageFuels.map(StorageFuelViewModel.init)
        } catch{
            print(error)
        }
    }
    
    private func setupFetchRequestPredicateAndFetch() {
        if selectedStorage == nil {
            fetchedResultsController.fetchRequest.predicate = nil
        } else {
            let predicate = NSPredicate(format: "storages == %@", self.selectedStorage?.storageEntity ?? "")
            fetchedResultsController.fetchRequest.predicate = predicate
        }
        
        setupFetchResultsController()
    }
}



extension StorageFuelListViewModel: NSFetchedResultsControllerDelegate{
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let fetchedStorageFuels = controller.fetchedObjects as? [FuelTransaction] else{
            return
        }
        
        self.storageFuels = fetchedStorageFuels.map(StorageFuelViewModel.init)
        
    }
}



struct StorageFuelViewModel: Identifiable{
    private var storageFuel: FuelTransaction
    
    init(storageFuel: FuelTransaction){
        self.storageFuel = storageFuel
    }
    
    var id: NSManagedObjectID{
        storageFuel.objectID
    }
    
    var date: Date{
        storageFuel.date!
    }
    
    var pumpedAmount: Double{
        storageFuel.pumpedAmount
    }
    
    var fuelType: String{
        storageFuel.storages?.fuelTypes?.name ?? ""
    }
    
}


