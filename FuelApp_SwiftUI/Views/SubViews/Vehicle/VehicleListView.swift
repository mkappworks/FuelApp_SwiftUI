//
//  VehicleListView.swift
//  FuelApp_SwiftUI
//
//  Created by Malith Kuruppu on 2022-08-26.
//

import SwiftUI

struct VehicleListView: View {
    @State private var isPresented: Bool = false
    @Environment(\.managedObjectContext) var viewContext
    @ObservedObject private var vehicleListVM: VehicleListViewModel
    
    let vehicles:LocalizedStringKey = "vehicles"
    let add_new_vehicle:LocalizedStringKey = "add_new_vehicle"

    init(vm: VehicleListViewModel){
        self.vehicleListVM = vm
    }
    
    private func deleteVehicle(at offsets: IndexSet){
        offsets.forEach { index in
            let vehicle = vehicleListVM.vehicles[index]
            vehicleListVM.deleteVehicle(vehicleId: vehicle.id)
        }
    }
    
    var body: some View {
        NavigationView{
            VStack{
                List{
                    ForEach(vehicleListVM.vehicles){vehicle in
                        VStack(alignment: .leading){
                            Text("Vehicle Number : \(vehicle.vehicleId)")
                            Text("Registered Date : \(vehicle.date, style: .date)")
                            Text("Vehicle Type : \(vehicle.vehicleType.uppercased())")
                            Text("Fuel Type : \(vehicle.fuelType.uppercased())")
                        }
                    }
                    .onDelete(perform: deleteVehicle)
                }
            }
            .sheet(isPresented: $isPresented, onDismiss: {
                //dismiss
            }, content: {
                AddVehicleView(vm: AddVehicleViewModel(context: viewContext))
            })
            .navigationTitle(vehicles)
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(add_new_vehicle){
                        isPresented = true
                    }
                }
            }
        }
    }
}

struct VehicleListView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = CoreDataManager.shared.persistenceStoreController.viewContext
        
        VehicleListView(vm: VehicleListViewModel(context: viewContext))
    }
}
