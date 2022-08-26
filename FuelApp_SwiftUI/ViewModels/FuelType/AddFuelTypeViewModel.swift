//
//  AddFuelTypeViewModel.swift
//  FuelApp_SwiftUI
//
//  Created by Malith Kuruppu on 2022-08-26.
//

import Foundation
import CoreData

class AddFuelTypeViewModel:  ObservableObject{
    @Published var name: String = "diesel"
    
    var context: NSManagedObjectContext
 
    
    init(context: NSManagedObjectContext){
        self.context = context
    }
    
    func save(){
        do{
            let fuelType = FuelType(context: context)
            fuelType.name = name.lowercased()
            try fuelType.save()
        } catch{
            print(error)
        }
    }
}
