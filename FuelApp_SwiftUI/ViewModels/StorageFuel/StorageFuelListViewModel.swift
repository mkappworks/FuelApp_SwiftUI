//
//  StorageFuelListViewModel.swift
//  FuelApp_SwiftUI
//
//  Created by Malith Kuruppu on 2022-08-26.
//

import Foundation
import CoreData

@MainActor
class StorageFuelListViewModel: ObservableObject{
    
    @Published var errorMessage: String = ""
    @Published var isError: Bool = false
    
    @Published var selectedStorage: StorageViewModel?
    @Published var storages = [StorageViewModel]()
    @Published var storageFuels = [StorageFuelViewModel]()
    @Published var storage: Storage?
    
    var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext){
        self.context = context
        
        self.getStorages()
        
        self.getFuelTransactionByStorage()
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
            
            storage = fetchedStorages.first
            storages = fetchedStorages.map(StorageViewModel.init)
            
            if(storages.count == 0){
                errorMessage.append(contentsOf: "No Storages found. Please add a Storage. ")
                isError = true
                return
            }
            
            selectedStorage = storages.first
            
        }catch{
            print(error)
        }
        
    }
    
    func getFuelTransactionByStorage(){
        if(storages.count == 0){return}
        
        storage = selectedStorage?.storageEntity
        
        let fetchStorageFuels = selectedStorage?.storageEntity.fuelTransactions?.allObjects as! [FuelTransaction]
    
        storageFuels = fetchStorageFuels.map(StorageFuelViewModel.init)
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


