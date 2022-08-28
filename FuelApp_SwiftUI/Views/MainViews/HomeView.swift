//
//  HomeView.swift
//  FuelApp_SwiftUI
//
//  Created by Malith Kuruppu on 2022-08-26.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.managedObjectContext) var viewContext
    
    let hv_vehicles:LocalizedStringKey = "hv_vehicles"
    let hv_storages:LocalizedStringKey = "hv_storages"
    let hv_storage_history:LocalizedStringKey = "hv_storage_history"
    let hv_vehicle_history:LocalizedStringKey = "hv_vehicle_history"
    let hv_fuel_types:LocalizedStringKey = "hv_fuel_types"
    let hv_quotas:LocalizedStringKey = "hv_quotas"

    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 75){
                
                NavigationLink( destination: VehicleListView(vm: VehicleListViewModel(context: viewContext)) ){
                    Text(hv_vehicles)
                }
                
                NavigationLink( destination: StorageListView(vm: StorageListViewModel(context: viewContext)) ){
                    Text(hv_storages)
                }
                

                NavigationLink( destination: VehicleFuelListView(vm: VehicleFuelListViewModel(context: viewContext)) ){
                    Text(hv_vehicle_history)
                }
                             
                NavigationLink( destination: StorageFuelListView(vm: StorageFuelListViewModel(context: viewContext)) ){
                    Text(hv_storage_history)
                }
                
                NavigationLink( destination: FuelTypeListView(vm: FuelTypeListViewModel(context: viewContext)) ){
                    Text(hv_fuel_types)
                }
                
                
                NavigationLink( destination: QuotaListView(vm: QuotaListViewModel(context: viewContext)) ){
                    Text(hv_quotas)
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
