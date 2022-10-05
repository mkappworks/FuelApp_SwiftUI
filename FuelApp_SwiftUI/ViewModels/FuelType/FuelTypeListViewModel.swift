//
//  FuelTypeListViewModel.swift
//  FuelApp_SwiftUI
//
//  Created by Malith Kuruppu on 2022-08-26.
//

import Foundation
import CoreData

@MainActor
class FuelTypeListViewModel: NSObject, ObservableObject{
    
    @Published var fuelTypes = [FuelTypeViewModel]()
    private let fetchedResultsController: NSFetchedResultsController<FuelType>
    private (set) var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext){
        self.context = context
        fetchedResultsController = NSFetchedResultsController(
            fetchRequest: FuelType.all,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        
        super.init()
        
        fetchedResultsController.delegate = self
        
        do{
            try fetchedResultsController.performFetch()
            
            guard let fetchedFuelTypes = fetchedResultsController.fetchedObjects else{
                return
            }
            
            self.fuelTypes = fetchedFuelTypes.map(FuelTypeViewModel.init)
        } catch{
            print(error)
        }

    }
    
    func deleteFuelType(fuelTypeId: NSManagedObjectID){
        do{
            guard let fuelType = try context.existingObject(with: fuelTypeId) as? FuelType else{
                return
            }
            
            try fuelType.delete()
        }catch{
            print(error)
        }
    }
}

extension FuelTypeListViewModel: NSFetchedResultsControllerDelegate{
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let fetchedFuelTypes = controller.fetchedObjects as? [FuelType] else{
            return
        }
        
        self.fuelTypes = fetchedFuelTypes.map(FuelTypeViewModel.init)
    }
}

struct FuelTypeViewModel: Identifiable, Hashable{
    private var fuelType: FuelType
    
    init(fuelType: FuelType){
        self.fuelType = fuelType
    }
    
    var id: NSManagedObjectID{
        fuelType.objectID
    }
    
    var name: String{
        fuelType.name ?? ""
    }
    
    var fuelTypeEntity: FuelType{
        fuelType
    }
    
}


