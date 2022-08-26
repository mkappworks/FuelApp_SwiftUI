
//  FuelTransactionListViewModel.swift
//  FuelManagement_SwiftUI (iOS)
//
//  Created by asiri indatissa on 2022-08-25.
//

import Foundation
import CoreData

@MainActor
class FuelTransactionListViewModel: NSObject, ObservableObject{
    
    @Published var fuelTransactions = [FuelTransactionViewModel]()
    private let fetchedResultsController: NSFetchedResultsController<FuelTransaction>
    private (set) var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext){
        self.context = context
        fetchedResultsController = NSFetchedResultsController(
            fetchRequest: FuelTransaction.all,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        
        super.init()
        
        fetchedResultsController.delegate = self
        
        do{
            try fetchedResultsController.performFetch()
            
            guard let fetchedFuelTransactions = fetchedResultsController.fetchedObjects else{
                return
            }
            
            self.fuelTransactions = fetchedFuelTransactions.map(FuelTransactionViewModel.init)
        } catch{
            print(error)
        }

    }
    func deleteFuelTransaction(fuelType: fuelTransactionId){
        do{
            guard let fuelTransaction = try context.existingObject(with: fuelType) as? fuelTransaction
            else{
                return
            }
            
            try fuelTransaction.delete()
        }catch{
            print(error)
        }
    }
    
}

extension FuelTransactionListViewModel: NSFetchedResultsControllerDelegate{
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let fetchedFuelTransactions = controller.fetchedObjects as? [FuelTransaction] else{
            return
        }
        
        self.fuelTransactions = fetchedFuelTransactions.map(FuelTransactionViewModel.init)
        
    }
}

struct FuelTransactionViewModel: Identifiable{
    private var fuelTransaction: FuelTransaction
    
    init(fuelTransaction: FuelTransaction){
        self.fuelTransaction = fuelTransaction
    }
    
    var id: fuelTransactionId{
        fuelTransaction.objectID
    }
    
    var fuelType: String{
        fuelTransaction.fuelType ?? ""
    }
    
    var pumpedAmount: Double{
        fuelTransaction.pumpedAmount ?? 0.0
    }
    var date: Date{
        fuelTransaction.date ?? Date.now
    }
    
    var currentAmount: Double{
        fuelTransaction.currentAmount ?? 0.0
    }
    
    
}
