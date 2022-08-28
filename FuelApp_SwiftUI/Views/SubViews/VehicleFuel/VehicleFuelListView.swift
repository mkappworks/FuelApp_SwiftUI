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
    
    private func deleteVehicleFuel(at offsets: IndexSet){
        offsets.forEach { index in
            let vehicleFuel = vehicleFuelListVM.vehicleFuels[index]
            vehicleFuelListVM.deleteVehicleFuel(vehicleFuelId: vehicleFuel.id)
        }
    }
    
    var body: some View {
        NavigationView{
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
            .navigationTitle("Vehicle Fuel Transaction")
            .toolbar{
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    ScanButton(scannedText: $vehicleFuelListVM.vehicleId, buttonImageName: "camera.badge.ellipsis", buttonTitle: "Scan Vehicle Number")
                        .onChange(of: vehicleFuelListVM.vehicleId) {newvalue in
                            print("check registered")
                            vehicleFuelListVM.checkVehicleRegistered()
                        }
                    
                    if(vehicleFuelListVM.canPumpFuel){
                        Button("Pump Fuel to Vehicle"){
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
}



struct VehicleFuelListView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = CoreDataManager.shared.persistenceStoreController.viewContext
        
        VehicleFuelListView(vm: VehicleFuelListViewModel(context: viewContext))
    }
}
