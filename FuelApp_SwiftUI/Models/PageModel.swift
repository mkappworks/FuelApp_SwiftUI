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
        PageModel(name: "Welcome to Fuel Management App!", description: "The best app to get started with managing your fuel station", imageUrl: "SplashIcon", tag: 0),
        PageModel(name: "Register Vehicle", description: "You can register vehicle using the camera from the Home Tab", imageUrl: "VehicleRegistrationImg", tag: 1),
        PageModel(name: "Register Storage", description: "You can register storage from the Home Tab", imageUrl: "StorageImg", tag: 2),
        PageModel(name: "Fuel Analysis", description: "You can make prediction from Analysis Tab best app to get started with managing your fuel station", imageUrl: "FuelAnalysisImg", tag: 3),
        
    ]
}

