//
//  VehicleFuelListView.swift
//  FuelApp_SwiftUI
//
//  Created by Malith Kuruppu on 2022-08-26.
//

import SwiftUI

struct VehicleFuelListView: View {
    @State private var isPresented: Bool = false
    @Environment(\.managedObjectContext) var viewContext
    @ObservedObject private var vehicleFuelListVM: VehicleFuelListViewModel
    
    init(vm: VehicleFuelListViewModel){
        self.vehicleFuelListVM = vm
    }
    let vehicle_fuel_transaction:LocalizedStringKey = "vehicle_fuel_transaction"
    let pump_fuel_to_vehicle:LocalizedStringKey = "pump_fuel_to_vehicle"
    
    private func deleteVehicleFuel(at offsets: IndexSet){
        offsets.forEach { index in
            let vehicleFuel = vehicleFuelListVM.vehicleFuels[index]
            vehicleFuelListVM.deleteVehicleFuel(vehicleFuelId: vehicleFuel.id)
        }
    }
    
    var body: some View {
        VStack{
            List{
                ForEach(vehicleFuelListVM.vehicleFuels){vehicleFuel in
                    VStack(alignment: .leading){
                        Text("Date : \(vehicleFuel.date, style: .date)")
                        Text("Pumped Amount : \(vehicleFuel.pumpedAmount, specifier: "%.2f")")
                    }
                }
                .onDelete(perform: deleteVehicleFuel)
            }
        }
        .sheet(isPresented: $isPresented, onDismiss: {
            //dismiss
        }, content: {
            AddVehicleFuelView(vm: AddVehicleFuelViewModel(context: viewContext, vehicle: vehicleFuelListVM.vehicle!))
        })
        .navigationTitle(vehicle_fuel_transaction)
        .toolbar{
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                ScanButton(scannedText: $vehicleFuelListVM.vehicleId, buttonImageName: "camera.badge.ellipsis", buttonTitle: "Scan Vehicle Number")
                
                if(vehicleFuelListVM.canPumpFuel){
                    Button(pump_fuel_to_vehicle){
                        isPresented = true
                    }
                }
            }
            
        }
        .alert(vehicleFuelListVM.errorMessage, isPresented: $vehicleFuelListVM.isError) {
            Button("OK", role: .cancel) {
                //dismiss alert
            }
        }
    }
}



struct VehicleFuelListView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = CoreDataManager.shared.persistenceStoreController.viewContext
        
        VehicleFuelListView(vm: VehicleFuelListViewModel(context: viewContext))
    }
}
