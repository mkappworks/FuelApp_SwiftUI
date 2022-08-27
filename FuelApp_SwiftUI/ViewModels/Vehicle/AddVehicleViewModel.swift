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
    
    @Published var errorMessage: String = ""
    @Published var isError: Bool = false
    
    @Published var selectedQuota: QuotaViewModel?
    @Published var selectedFuelType: FuelTypeViewModel?
    
    @Published var quotas = [QuotaViewModel]()
    @Published var fuelTypes = [FuelTypeViewModel]()
    
    var context: NSManagedObjectContext
    
    
    init(context: NSManagedObjectContext){
        self.context = context
        
        self.errorMessage = ""
        self.isError = false
        
        self.getQuotas()
        
        self.getFuelTypes()
        
        if(self.errorMessage != ""){
            self.isError = true
        }
        
    }
    
    func save(){
        do{
            let vehicle = Vehicle(context: context)
            
            vehicle.vehicleId = self.vehicleId
            vehicle.date = Date.now
            
            
            vehicle.quotas = self.selectedQuota?.quotaEntity
            
            vehicle.fuelTypes = self.selectedFuelType?.fuelTypeEntity
            
            try vehicle.save()
        } catch{
            print(error)
        }
    }
    
    
    
    private func getQuotas(){
        do{
            let request = NSFetchRequest<Quota>(entityName: "Quota")
            
            let fetchedQuotas = try context.fetch(request)
            
            self.quotas = fetchedQuotas.map(QuotaViewModel.init)
            
            if(self.quotas.count == 0){
                errorMessage.append(contentsOf: "No Quotas found. Please add a Quota. ")
                return
            }
            
            self.selectedQuota = self.quotas[0]
            
        }catch{
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



