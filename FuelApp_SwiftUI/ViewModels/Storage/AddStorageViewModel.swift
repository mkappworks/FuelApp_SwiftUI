//
//  AddStorageViewModel.swift
//  FuelApp_SwiftUI
//
//  Created by Malith Kuruppu on 2022-08-26.
//

import Foundation
import CoreData

class AddStorageViewModel:   ObservableObject{
    @Published var storageCapacity: Double = 0.0
    @Published var fuelType: String = "FuelType.diesel"
    @Published var errorMessage: String = ""
    @Published var selectedFuelType: FuelTypeViewModel?

    @Published var fuelTypes = [FuelTypeViewModel]()

    var context: NSManagedObjectContext
 
    
    init(context: NSManagedObjectContext){
        self.context = context
        
        self.getFuelTypes()
    }
    
    func save(){
        do{
            let storage = Storage(context: context)
            storage.storageCapacity = self.storageCapacity
            storage.fuelTypes = self.selectedFuelType?.fuelTypeEntity
            
            try storage.save()
        } catch{
            print(error)
        }
    }

    
    
    private func getFuelTypes(){
        do{
            let request = NSFetchRequest<FuelType>(entityName: "FuelType")
            
            let fetchedFuelTypes = try context.fetch(request)
            
            self.fuelTypes = fetchedFuelTypes.map(FuelTypeViewModel.init)
            
            if(self.fuelTypes.count == 0){
                errorMessage.append(contentsOf: "No Fuel Types found. Please add a Fuel Type. ")
                return
            }
            
            self.selectedFuelType = self.fuelTypes[0]
            
            
        }catch{
            print(error)
        }
        
    }
    
    
}

