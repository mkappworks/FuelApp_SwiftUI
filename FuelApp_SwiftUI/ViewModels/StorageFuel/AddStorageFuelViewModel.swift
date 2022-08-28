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
        
//        self.quota = self.vehicle.quotas
//        self.storage = self.storage.fuelTypes?.storages
        
     //   calculateTotalPumpedAmountInStorage()
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
    
//    private func calculateTotalPumpedAmountInStorage(){
//        do{
//            self.errorMessage = ""
//            
//            if( self.quota == nil ){
//                self.errorMessage.append(contentsOf: "No Quotas found. Please enter Quota. ")
//                isError = true
//                isCloseView = true
//                return
//            }
//            
//            if( self.storage == nil ){
//                self.errorMessage.append(contentsOf: "No Storage found. Please enter Storage. ")
//                isError = true
//                isCloseView = true
//                return
//            }
//            
//            let currentDate = Date.now
//            let startDate = currentDate.startDateOfMonth
//            let endDate = currentDate.endDateOfMonth
//            
//            let request = NSFetchRequest<FuelTransaction>(entityName: "FuelTransaction")
//            request.sortDescriptors = []
//            let vehicleIdPredicate = NSPredicate(format: "vehicles.vehicleId == %@", self.vehicle.vehicleId ?? "")
//            let monthPredicate = NSPredicate(format: "(date >= %@) AND (date <= %@)",  startDate as NSDate, endDate as NSDate)
//            
//            let andPredicate = NSCompoundPredicate(type: .and, subpredicates: [vehicleIdPredicate, monthPredicate])
//            request.predicate   = andPredicate
//            
//            let fetchedVehicleFuel = try context.fetch(request)
//            
//            let vehicleFuel = fetchedVehicleFuel.map(VehicleFuelViewModel.init)
//            
//            if(vehicleFuel.count > 0){
//                self.totalPumpedAmount = vehicleFuel.map{ $0.pumpedAmount }.reduce(0, +)
//            }
//            print("after")
//            print(self.totalPumpedAmount)
//            
//        }catch{
//            print(error)
//        }
//    }
    
}


