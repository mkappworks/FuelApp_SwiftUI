//
//  VehicleListViewModel.swift
//  FuelApp_SwiftUI
//
//  Created by Malith Kuruppu on 2022-08-26.
//

import Foundation
import CoreData

@MainActor
class VehicleListViewModel: NSObject, ObservableObject{
    
    @Published var vehicles = [VehicleViewModel]()
    private let fetchedResultsController: NSFetchedResultsController<Vehicle>
    private (set) var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext){
        self.context = context
        fetchedResultsController = NSFetchedResultsController(
            fetchRequest: Vehicle.all,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        
        super.init()
        
        fetchedResultsController.delegate = self
        
        do{
            try fetchedResultsController.performFetch()
            
            guard let fetchedVehicles = fetchedResultsController.fetchedObjects else{
                return
            }
            
            self.vehicles = fetchedVehicles.map(VehicleViewModel.init)
        } catch{
            print(error)
        }

    }
    
    func deleteVehicle(vehicleId: NSManagedObjectID){
        do{
            guard let vehicle = try context.existingObject(with: vehicleId) as? Vehicle
            else{
                return
            }
            
            try vehicle.delete()
        }catch{
            print(error)
        }
    }
}

extension VehicleListViewModel: NSFetchedResultsControllerDelegate{
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let fetchedVehicles = controller.fetchedObjects as? [Vehicle] else{
            return
        }
        
        self.vehicles = fetchedVehicles.map(VehicleViewModel.init)
        
    }
}

struct VehicleViewModel: Identifiable, Hashable{
    private var vehicle: Vehicle
    
    init(vehicle: Vehicle){
        self.vehicle = vehicle
    }
    
    var id: NSManagedObjectID{
        vehicle.objectID
    }
    
    var vehicleId: String{
        vehicle.vehicleId ?? ""
    }
    
    var date: Date{
        vehicle.date!
    }
    
    var vehicleType: String{
        vehicle.quotas?.vehicleType ?? ""
    }

    var fuelType: String{
        vehicle.fuelTypes?.name ?? ""
    }
    
    
}

