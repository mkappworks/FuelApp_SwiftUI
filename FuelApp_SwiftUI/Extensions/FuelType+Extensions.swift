//
//  FuelType+Extensions.swift
//  FuelApp_SwiftUI
//
//  Created by Malith Kuruppu on 2022-08-26.
//

import Foundation
import CoreData

extension FuelType: BaseModel{
    static var all: NSFetchRequest<FuelType>{
        let request = FuelType.fetchRequest()
        request.sortDescriptors = []
        return request
    }
}
