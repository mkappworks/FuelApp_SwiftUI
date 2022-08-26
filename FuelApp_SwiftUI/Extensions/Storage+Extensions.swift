//
//  Storage+Extensions.swift
//  FuelApp_SwiftUI
//
//  Created by Malith Kuruppu on 2022-08-26.
//

import Foundation
import CoreData

extension Storage: BaseModel{
    static var all: NSFetchRequest<Storage>{
        let request = Storage.fetchRequest()
        request.sortDescriptors = []
        return request
    }
}
