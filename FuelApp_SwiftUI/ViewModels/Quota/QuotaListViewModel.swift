//
//  QuotaListViewModel.swift
//  FuelApp_SwiftUI
//
//  Created by Malith Kuruppu on 2022-08-26.
//

import Foundation
import CoreData

@MainActor
class QuotaListViewModel: NSObject, ObservableObject{
    
    @Published var quotas = [QuotaViewModel]()
    private let fetchedResultsController: NSFetchedResultsController<Quota>
    private (set) var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext){
        self.context = context
        fetchedResultsController = NSFetchedResultsController(
            fetchRequest: Quota.all,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        
        super.init()
        
        fetchedResultsController.delegate = self
        
        do{
            try fetchedResultsController.performFetch()
            
            guard let fetchedQuotas = fetchedResultsController.fetchedObjects else{
                return
            }
            
            self.quotas = fetchedQuotas.map(QuotaViewModel.init)
        } catch{
            print(error)
        }

    }
    
    func deleteQuota(quotaId: NSManagedObjectID){
        do{
            guard let quota = try context.existingObject(with: quotaId) as? Quota else{
                return
            }
            
            try quota.delete()
        }catch{
            print(error)
        }
    }
}

extension QuotaListViewModel: NSFetchedResultsControllerDelegate{
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let fetchedQuotas = controller.fetchedObjects as? [Quota] else{
            return
        }
        
        self.quotas = fetchedQuotas.map(QuotaViewModel.init)
    }
}

struct QuotaViewModel: Identifiable, Hashable{
    private var quota: Quota
    
    init(quota: Quota){
        self.quota = quota
    }
    
    var id: NSManagedObjectID{
        quota.objectID
    }
    
    var vehicleType: String{
        quota.vehicleType ?? ""
    }
    
    var quotaAmount: Double{
        quota.quotaAmount
    }
    
    var quotaEntity: Quota{
        quota
    }
    
}

