//
//  AddQuotaViewModel.swift
//  FuelApp_SwiftUI
//
//  Created by Malith Kuruppu on 2022-08-26.
//

import Foundation
import CoreData

class AddQuotaViewModel:  ObservableObject{
    @Published var vehicleType: String = ""
    @Published var quotaAmount: Double = 0.0
    
    var context: NSManagedObjectContext
 
    
    init(context: NSManagedObjectContext){
        self.context = context
    }
    
    func save(){
        do{
            let quota = Quota(context: context)
            quota.vehicleType = vehicleType.lowercased()
            quota.quotaAmount = quotaAmount
            try quota.save()
        } catch{
            print(error)
        }
    }
}

