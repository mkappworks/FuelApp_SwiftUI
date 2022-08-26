//
//  VehicleFuelTransaction+Extensions.swift
//  FuelApp_SwiftUI
//
//  Created by Malith Kuruppu on 2022-08-26.
//

import Foundation
import CoreData

extension VehicleFuelTransaction: BaseModel{
    static var all: NSFetchRequest<VehicleFuelTransaction>{
        let request = VehicleFuelTransaction.fetchRequest()
        request.sortDescriptors = []
        return request
    }
}
