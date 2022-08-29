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
    
    @Published var vehicleId: String = ""{
        didSet {
            checkVehicleRegistered()
        }
    }
    
    @Published var vehicleFuels = [VehicleFuelViewModel]()
    
    @Published var vehicle: Vehicle?{
        didSet {
            setupFetchRequestPredicateAndFetch()
        }
    }
    
    @Published var errorMessage: String = ""
    @Published var isError: Bool = false
    @Published var canPumpFuel: Bool = false
    
    private (set) var context: NSManagedObjectContext
    private let fetchedResultsController: NSFetchedResultsController<FuelTransaction>
    
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
        
        setupFetchRequestPredicateAndFetch()
        
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
    
    
    private func setupFetchResultsController() {
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
    
    private func setupFetchRequestPredicateAndFetch() {
        if vehicle == nil {
            fetchedResultsController.fetchRequest.predicate = nil
        } else {
            let predicate = NSPredicate(format: "vehicles == %@", self.vehicle ?? "")
            fetchedResultsController.fetchRequest.predicate = predicate
            setupFetchResultsController()
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


