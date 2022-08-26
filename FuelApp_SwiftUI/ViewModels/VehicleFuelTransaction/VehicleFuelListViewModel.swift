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
    private let fetchedResultsController: NSFetchedResultsController<VehicleFuelTransaction>
    private (set) var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext){
        self.context = context
        fetchedResultsController = NSFetchedResultsController(
            fetchRequest: VehicleFuelTransaction.all,
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
            guard let vehicleFuel = try context.existingObject(with: vehicleFuelId) as? VehicleFuelTransaction
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
        guard let fetchedVehicleFuels = controller.fetchedObjects as? [VehicleFuelTransaction] else{
            return
        }
        
        self.vehicleFuels = fetchedVehicleFuels.map(VehicleFuelViewModel.init)
        
    }
}

struct VehicleFuelViewModel: Identifiable{
    private var vehicleFuel: VehicleFuelTransaction
    
    init(vehicleFuel: VehicleFuelTransaction){
        self.vehicleFuel = vehicleFuel
    }
    
    var id: NSManagedObjectID{
        vehicleFuel.objectID
    }
    
    var vehicleId: String{
        vehicleFuel.vehicleId ?? ""
    }
    
    
}


