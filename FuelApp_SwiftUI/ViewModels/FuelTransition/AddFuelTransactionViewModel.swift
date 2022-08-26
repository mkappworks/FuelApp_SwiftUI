//
//  AddFuelTransactionViewModel.swift
//  FuelManagement_SwiftUI (iOS)
//
//  Created by asiri indatissa on 2022-08-25.
//

import Foundation
import CoreData

class AddFuelTransactionViewModel:   ObservableObject{
    @Published var pumpedAmount: Double = 0.0
    @Published var fuelType: FuelType = FuelType.diesel
    @Published var fuelTransactions = [FuelTransactionViewModel]()
    @Published var currentAmount = [FuelTransactionViewModel]()

    var context: NSManagedObjectContext
 
    
    init(context: NSManagedObjectContext){
        self.context = context
        self.getFuelTransaction()
        self.getCurrentAmount()
    }
    //need to fetch
    private func getCurrentAmount(){
        do{
            let request = NSFetchRequest<FuelTransaction>(entityName: "FuelTransaction")

            let pred = NSPredicate(format: "fuelType == %@", fuelType)
            request.predicate = pred
            let sort = NSSortDescriptor(key: "date", ascending: false)
            request.sortDescriptors = [sort]
            request.fetchLimit = 1;
            let fetchedFuelTansactions = try context.fetch(request)

            self.currentAmount = fetchedFuelTansactions.map(FuelTransactionViewModel.init)

        }catch{
            print(error)
        }

    }
    
    func save(){
        do{
            let fuelTransaction = FuelTransaction(context: context)
            
            fuelTransaction.currentAmount = currentAmount
            fuelTransaction.pumpedAmount = pumpedAmount
            fuelTransaction.date = Date.now
            fuelTransaction.fuelType = fuelType.rawValue.lowercased()
            
            try fuelTransaction.save()
        } catch{
            print(error)
        }
    }
    //get fuel list and filter out
    
    private func getFuelTransaction(){
        do{
            let request = NSFetchRequest<FuelTransaction>(entityName: "FuelTransaction")

            let fetchedFuelTansactions = try context.fetch(request)

            self.fuelTransactions = fetchedFuelTansactions.map(FuelTransactionViewModel.init)

        }catch{
            print(error)
        }

    }

    
}


