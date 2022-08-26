//
//  AddVehicleFuelViewModel.swift
//  FuelApp_SwiftUI
//
//  Created by Malith Kuruppu on 2022-08-26.
//

import Foundation
import CoreData

class AddVehicleFuelViewModel:   ObservableObject{
    @Published var vehicleId: String = ""
    @Published var date: Date =  Date.now
    @Published var pumpedAmount: Double = 0.0
    
    @Published var isVehicleRegistered: Bool =  true
    @Published var hasVehicleExccededQuota: Bool = false
    
    private var vehicle = [VehicleViewModel]()
    private var quotas = [QuotaViewModel]()
    private var vehicles = [VehicleViewModel]()
    private var vehicleFuels = [VehicleFuelViewModel]()
    
    
    
    var context: NSManagedObjectContext
 
    
    init(context: NSManagedObjectContext){
        self.context = context
        
        self.isVehicleIdInCoreDate()
        
        if(!self.isVehicleRegistered){return}
        
//        self.getVehicle()
//
//        self.getQuota()
//
//        self.getVehicleFuel()
    }
    
//    func save(){
//        do{
//            let vehicleFuel = VehicleFuelTransaction(context: context)
//            vehicleFuel.vehicleId = vehicleId
//
//            try vehicleFuel.save()
//        } catch{
//            print(error)
//        }
//    }

    private func isVehicleIdInCoreDate(){
        self.getVehicle()
        
        self.isVehicleRegistered = vehicles.contains(where: {$0.vehicleId == self.vehicleId})
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
    
    private func getVehicle(){
        do{
            let request = NSFetchRequest<Vehicle>(entityName: "Vehicle")

            let fetchedVehicles = try context.fetch(request)

            self.vehicles = fetchedVehicles.map(VehicleViewModel.init)
        }catch{
            print(error)
        }

    }
    
    private func getFuelTransaction(){
        do{
            let request = NSFetchRequest<FuelTransaction>(entityName: "FuelTransaction")

            let fetchedVehicleFuels = try context.fetch(request)

            self.vehicleFuels = fetchedVehicleFuels.map(VehicleFuelViewModel.init)
        }catch{
            print(error)
        }

    }
    
}


