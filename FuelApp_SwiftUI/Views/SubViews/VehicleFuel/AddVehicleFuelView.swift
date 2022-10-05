//
//  AddVehicleFuelView.swift
//  FuelApp_SwiftUI
//
//  Created by Malith Kuruppu on 2022-08-26.
//

import SwiftUI
import CoreData

struct AddVehicleFuelView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var addVehicleFuelVM: AddVehicleFuelViewModel
    
    init(vm: AddVehicleFuelViewModel){
        self.addVehicleFuelVM = vm
    }
    let vehicle_number:LocalizedStringKey = "vehicle_number"
    let enter_pumped_amount:LocalizedStringKey = "enter_pumped_amount"
    let common_save:LocalizedStringKey = "common_save"
    let add_new_vehicle:LocalizedStringKey = "add_new_vehicle"
    let ok:LocalizedStringKey = "ok"

    var body: some View {
        VStack{
            Form{
                Text("Vehicle Number : \(addVehicleFuelVM.vehicleId)")
                
                Section(enter_pumped_amount){
                    TextField(enter_pumped_amount, value: $addVehicleFuelVM.pumpedAmount, formatter: NumberFormatter())
                        .keyboardType(.decimalPad)
                }
                
                Button(common_save){
                    addVehicleFuelVM.save()
                    if(addVehicleFuelVM.isError == false){
                        presentationMode.wrappedValue.dismiss()
                    }
                   
                }
                .centerHorizontally()
                .navigationTitle(add_new_vehicle)
            }
        }
        .alert(addVehicleFuelVM.errorMessage, isPresented: $addVehicleFuelVM.isError) {
            Button(ok, role: .cancel) {
                if(addVehicleFuelVM.isCloseView){
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
    
}
