//
//  AddVehicleViewModel.swift
//  FuelApp_SwiftUI
//
//  Created by Malith Kuruppu on 2022-08-26.
//

import Foundation
import CoreData

class AddVehicleViewModel:   ObservableObject{
    @Published var vehicleId: String = ""
    @Published var vehicleType: String = ""
    @Published var fuelType: String = "FuelType.diesel"
    @Published var quotas = [QuotaViewModel]()
    //@Published var fuelTypes = [FuelTypeViewModel]()
    
    var context: NSManagedObjectContext
 
    
    init(context: NSManagedObjectContext){
        self.context = context
        
        self.getQuota()
    }
    
    func save(){
        do{
            let vehicle = Vehicle(context: context)
            
            vehicle.vehicleId = vehicleId
       
         //Todo:: add quota and fueltype entity
            
            try vehicle.save()
        } catch{
            print(error)
        }
    }

    
    
    private func getQuota(){
        do{
            let request = NSFetchRequest<Quota>(entityName: "Quota")

            let fetchedQuotas = try context.fetch(request)

            self.quotas = fetchedQuotas.map(QuotaViewModel.init)

        }catch{
            print(error)
        }

    }
    
//    private func getFuelTypes(){
//        do{
//            let request = NSFetchRequest<Quota>(entityName: "FuelType")
//
//            let fetchedFuelTypes = try context.fetch(request)
//
//            self.quotas = fetchedFuelTypes.map(QuotaViewModel.init)
//
//        }catch{
//            print(error)
//        }
//
//    }
    
}

