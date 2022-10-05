//
//  AddStorageFuelViewModel.swift
//  FuelApp_SwiftUI
//
//  Created by Malith Kuruppu on 2022-08-26.
//

import Foundation
import CoreData

@MainActor
class AddStorageFuelViewModel:   ObservableObject{
    @Published var fuelTypeName: String = ""
    @Published var pumpedAmount: Double = 0.0
    
    @Published var isCloseView: Bool = false
    @Published var errorMessage: String = ""
    @Published var isError: Bool = false
    
    private var storage: Storage
    
    var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext, storage: Storage){
        self.context = context
        self.storage = storage
        
        self.fuelTypeName = storage.fuelTypes?.name ?? ""
    }
    
    func save(){
        do{
            self.errorMessage = ""
            
            let newCurrentValueInStorage = self.storage.currentAmount + self.pumpedAmount
            
            
            if(newCurrentValueInStorage > self.storage.storageCapacity){
                errorMessage.append(contentsOf: "Cannot Pumped Amount more than storage capacity. ")
                isError = true
                pumpedAmount = 0
                return
            }
            
            let storageFuel = FuelTransaction(context: context)
            storageFuel.pumpedAmount = pumpedAmount
            storageFuel.date = Date.now
            storageFuel.storages = storage
            storageFuel.storages?.currentAmount = newCurrentValueInStorage
            
            try storageFuel.save()
        } catch{
            print(error)
        }
    }
}


