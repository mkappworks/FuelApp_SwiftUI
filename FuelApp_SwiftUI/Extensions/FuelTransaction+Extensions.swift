//
//  FuelTransaction+Extensions.swift
//  FuelApp_SwiftUI
//
//  Created by Malith Kuruppu on 2022-08-26.
//

import Foundation
import CoreData

extension FuelTransaction: BaseModel{
    static var all: NSFetchRequest<FuelTransaction>{
        let request = FuelTransaction.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        return request
    }
}

