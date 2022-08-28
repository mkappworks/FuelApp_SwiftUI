//
//  AddVehicleFuelViewModel.swift
//  FuelApp_SwiftUI
//
//  Created by Malith Kuruppu on 2022-08-26.
//

import Foundation
import CoreData

@MainActor
class AddVehicleFuelViewModel:   ObservableObject{
    @Published var vehicleId: String = ""
    @Published var pumpedAmount: Double = 0.0
    
    @Published var isCloseView: Bool = false
    @Published var errorMessage: String = ""
    @Published var isError: Bool = false
    
    private var vehicle: Vehicle
    private var quota: Quota?
    private var storage: Storage?
    private var totalPumpedAmount: Double = 0.0
    
    var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext, vehicle: Vehicle){
        self.context = context
        self.vehicle = vehicle
        
        self.vehicleId = vehicle.vehicleId ?? ""
        
        self.quota = self.vehicle.quotas
        self.storage = self.vehicle.fuelTypes?.storages
        
        calculateTotalPumpedAmountInVehicle()
    }
    
    func save(){
        do{
            self.errorMessage = ""
            
            let newTotalPumpedValueToVehicle = self.totalPumpedAmount + self.pumpedAmount
            
            if(newTotalPumpedValueToVehicle > self.quota!.quotaAmount){
                errorMessage.append(contentsOf: "This vehicle has exceeded the montly quota limit. ")
                isError = true
                pumpedAmount = 0
                return
            }
            
            let newCurrentValueInStorage = self.storage!.currentAmount - self.pumpedAmount
            
            
            if(newCurrentValueInStorage < 0){
                errorMessage.append(contentsOf: "Pumped Amount entered exceeds the fuel remaining in the storage. ")
                isError = true
                pumpedAmount = 0
                return
            }
            
            let vehicleFuel = FuelTransaction(context: context)
            vehicleFuel.pumpedAmount = pumpedAmount
            vehicleFuel.date = Date.now
            vehicleFuel.vehicles = vehicle
            vehicleFuel.vehicles?.fuelTypes?.storages?.currentAmount = newCurrentValueInStorage
            
            try vehicleFuel.save()
        } catch{
            print(error)
        }
    }
    
    private func calculateTotalPumpedAmountInVehicle(){
        do{
            self.errorMessage = ""
            
            if( self.quota == nil ){
                self.errorMessage.append(contentsOf: "No Quotas found. Please enter Quota. ")
                isError = true
                isCloseView = true
                return
            }
            
            if( self.storage == nil ){
                self.errorMessage.append(contentsOf: "No Storage found. Please enter Storage. ")
                isError = true
                isCloseView = true
                return
            }
            
            let currentDate = Date.now
            let startDate = currentDate.startDateOfMonth
            let endDate = currentDate.endDateOfMonth
            
            let request = NSFetchRequest<FuelTransaction>(entityName: "FuelTransaction")
            request.sortDescriptors = []
            let vehicleIdPredicate = NSPredicate(format: "vehicles.vehicleId == %@", self.vehicle.vehicleId ?? "")
            let monthPredicate = NSPredicate(format: "(date >= %@) AND (date <= %@)",  startDate as NSDate, endDate as NSDate)
            
            let andPredicate = NSCompoundPredicate(type: .and, subpredicates: [vehicleIdPredicate, monthPredicate])
            request.predicate   = andPredicate
            
            let fetchedVehicleFuel = try context.fetch(request)
            
            let vehicleFuel = fetchedVehicleFuel.map(VehicleFuelViewModel.init)
            
            if(vehicleFuel.count > 0){
                self.totalPumpedAmount = vehicleFuel.map{ $0.pumpedAmount }.reduce(0, +)
            }
            print("after")
            print(self.totalPumpedAmount)
            
        }catch{
            print(error)
        }
    }
    
}


