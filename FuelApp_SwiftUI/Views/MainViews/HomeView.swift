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
            VStack(spacing: 100){
                
                NavigationLink( destination: VehicleListView(vm: VehicleListViewModel(context: viewContext)) ){
                    Text("View Vehicle")
                }
                
                NavigationLink( destination: VehicleFuelListView() ){
                    Text("View Vehicle Fuel History")
                }
                
                NavigationLink( destination: FuelTransactionListView() ){
                    Text("View Storage Fuel History")
                }
                
                NavigationLink( destination: QuotaListView(vm: QuotaListViewModel(context: viewContext)) ){
                    Text("View Quota")
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
