//
//  VehicleFuelListViewModel.swift
//  FuelApp_SwiftUI
//
//  Created by Malith Kuruppu on 2022-08-26.
//

import Foundation
import CoreData

@MainActor
class VehicleFuelListViewModel: ObservableObject{
    
    @Published var vehicleId: String = ""
    @Published var vehicleFuels = [VehicleFuelViewModel]()
    @Published var vehicle: Vehicle?
    private (set) var context: NSManagedObjectContext
    
    @Published var errorMessage: String = ""
    @Published var isError: Bool = false
    @Published var canPumpFuel: Bool = false
    
    init(context: NSManagedObjectContext){
        self.context = context
        
    }
    
    func deleteVehicleFuel(vehicleFuelId: NSManagedObjectID){
        do{
            guard let vehicleFuel = try context.existingObject(with: vehicleFuelId) as? FuelTransaction
            else{
                return
            }
            
            try vehicleFuel.delete()
        }catch{
            print(error)
        }
    }
    
    func checkVehicleRegistered(){
        do{
            self.errorMessage = ""
            
            let request = NSFetchRequest<Vehicle>(entityName: "Vehicle")
            request.sortDescriptors = []
            request.predicate = NSPredicate(format: "vehicleId == %@", self.vehicleId)
            
            let fetchedVehicle = try context.fetch(request).first
            
            if(fetchedVehicle == nil){
                self.errorMessage.append(contentsOf: "Vehicle not registered. ")
                self.isError = true
                self.canPumpFuel = false
                return
            }
            
            self.isError = false
            self.canPumpFuel = true
            self.vehicle = fetchedVehicle
            
        }catch{
            print(error)
        }
    }
    
}


struct VehicleFuelViewModel: Identifiable{
    private var vehicleFuel: FuelTransaction
    
    init(vehicleFuel: FuelTransaction){
        self.vehicleFuel = vehicleFuel
    }
    
    var id: NSManagedObjectID{
        vehicleFuel.objectID
    }
    
    var date: Date{
        vehicleFuel.date!
    }
    
    var pumpedAmount: Double{
        vehicleFuel.pumpedAmount
    }
    
    var vehicleId: String{
        vehicleFuel.vehicles?.vehicleId ?? ""
    }
    
    var fuelType: String{
        vehicleFuel.vehicles?.fuelTypes?.name ?? ""
    }
    
}


