//
//  HomeView.swift
//  FuelApp_SwiftUI
//
//  Created by Malith Kuruppu on 2022-08-26.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.managedObjectContext) var viewContext
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 75){
                
                NavigationLink( destination: VehicleListView(vm: VehicleListViewModel(context: viewContext)) ){
                    Text("View Vehicles")
                }
                
                NavigationLink( destination: StorageListView(vm: StorageListViewModel(context: viewContext)) ){
                    Text("View Storages")
                }
                
                NavigationLink( destination: VehicleFuelListView(vm: VehicleFuelListViewModel(context: viewContext)) ){
                    Text("View Vehicle Fuel History")
                }
                
                NavigationLink( destination: StorageFuelListView(vm: StorageFuelListViewModel(context: viewContext)) ){
                    Text("View Storage Fuel History")
                }
                
                NavigationLink( destination: FuelTypeListView(vm: FuelTypeListViewModel(context: viewContext)) ){
                    Text("View Fuel Types")
                }
                
                
                NavigationLink( destination: QuotaListView(vm: QuotaListViewModel(context: viewContext)) ){
                    Text("View Vehicle Quotas")
                }
                
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
