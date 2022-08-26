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
    @Published var fuelType: FuelType = FuelType.diesel
    @Published var quotas = [QuotaViewModel]()
    
    var context: NSManagedObjectContext
 
    
    init(context: NSManagedObjectContext){
        self.context = context
        
        self.getQuota()
    }
    
    func save(){
        do{
            let vehicle = Vehicle(context: context)
            
            vehicle.vehicleId = vehicleId
            vehicle.vehicleType = vehicleType.lowercased()
            vehicle.fuelType = fuelType.rawValue.lowercased()
            
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
    
}

