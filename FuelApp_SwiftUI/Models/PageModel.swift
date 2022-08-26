//
//  PageModel.swift
//  FuelApp_SwiftUI
//
//  Created by Malith Kuruppu on 2022-08-26.
//

import Foundation

/**
 Mainly used in the HelpView
 */
struct PageModel: Identifiable, Equatable {
    let id = UUID()
    var name: String
    var description: String
    var imageUrl: String
    var tag: Int
    
    static var helpPages: [PageModel] = [
        PageModel(name: "Welcome to Fuel Management App!", description: "The best app to get started with managing your fuel station", imageUrl: "", tag: 0),
        PageModel(name: "Page 2", description: "The best app to get started with managing your fuel station", imageUrl: "", tag: 1),
        
    ]
}

