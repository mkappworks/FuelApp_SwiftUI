//
//  Vehicle+Extensions.swift
//  FuelApp_SwiftUI
//
//  Created by Malith Kuruppu on 2022-08-26.
//

import Foundation
import CoreData

extension Vehicle: BaseModel{
    static var all: NSFetchRequest<Vehicle>{
        let request = Vehicle.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        return request
    }
}
