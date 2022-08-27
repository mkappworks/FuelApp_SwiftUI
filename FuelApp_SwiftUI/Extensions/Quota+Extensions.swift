//
//  Quota+Extensions.swift
//  FuelApp_SwiftUI
//
//  Created by Malith Kuruppu on 2022-08-26.
//

import Foundation
import CoreData

extension Quota: BaseModel{
    static var all: NSFetchRequest<Quota>{
        let request = Quota.fetchRequest()
        request.sortDescriptors = []
        return request
    }
}
