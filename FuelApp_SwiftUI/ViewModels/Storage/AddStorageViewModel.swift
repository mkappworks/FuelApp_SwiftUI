//
//  AddStorageViewModel.swift
//  FuelApp_SwiftUI
//
//  Created by Malith Kuruppu on 2022-08-26.
//

import Foundation
import CoreData

class AddStorageViewModel:   ObservableObject{
    @Published var storageId: String = ""
    @Published var storageCapacity: Double = 0.0
    @Published var fuelType: String = "FuelType.diesel"
    //@Published var fuelTypes = [FuelTypeViewModel]()
    
    var context: NSManagedObjectContext
 
    
    init(context: NSManagedObjectContext){
        self.context = context
        
        self.getFuelTypes()
    }
    
    func save(){
        do{
//            let storage = Storage(context: context)
//            
//            storage.storageId = storageId
//            storage.storageCapacity = storageCapacity
//            storage.fuelType = fuelType
//         //Todo:: add quota and fueltype entity
//            
//            try storage.save()
        } catch{
            print(error)
        }
    }

    
    
    private func getFuelTypes(){
        do{
//            let request = NSFetchRequest<Quota>(entityName: "FuelType")
//
//            let fetchedFuelTypes = try context.fetch(request)
//
//            self.storages = fetchedFuelTypes.map(FuelTypeViewModel.init)

        }catch{
            print(error)
        }

    }
    
    
}

