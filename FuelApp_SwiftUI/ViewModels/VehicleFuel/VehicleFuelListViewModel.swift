//
//  VehicleFuelListViewModel.swift
//  FuelApp_SwiftUI
//
//  Created by Malith Kuruppu on 2022-08-26.
//

import Foundation
import CoreData

@MainActor
class VehicleFuelListViewModel: NSObject, ObservableObject{
    
    @Published var vehicleFuels = [VehicleFuelViewModel]()
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
            
            guard let fetchedVehicleFuels = fetchedResultsController.fetchedObjects else{
                return
            }
            
            self.vehicleFuels = fetchedVehicleFuels.map(VehicleFuelViewModel.init)
        } catch{
            print(error)
        }

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
}

extension VehicleFuelListViewModel: NSFetchedResultsControllerDelegate{
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let fetchedVehicleFuels = controller.fetchedObjects as? [FuelTransaction] else{
            return
        }
        
        self.vehicleFuels = fetchedVehicleFuels.map(VehicleFuelViewModel.init)
        
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
    
    var vehicleId: String{
        vehicleFuel.vehicles?.vehicleId ?? ""
    }
    
    var date: Date{
        vehicleFuel.date!
    }
    
    var fuelType: FuelType?{
        vehicleFuel.vehicles!.fuelTypes
    }
    
}


