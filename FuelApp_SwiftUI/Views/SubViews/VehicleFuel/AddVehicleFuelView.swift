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
    
    var body: some View {
        VStack{
            Form{
                Text("Vehicle Number : \(addVehicleFuelVM.vehicleId)")
                
                Section("Enter Pumped Amount"){
                    TextField("Enter Pumped Amount", value: $addVehicleFuelVM.pumpedAmount, formatter: NumberFormatter())
                        .keyboardType(.decimalPad)
                }
                
                Button("Save"){
                    addVehicleFuelVM.save()
                    if(addVehicleFuelVM.isError == false){
                        presentationMode.wrappedValue.dismiss()
                    }
                   
                }
                .centerHorizontally()
                .navigationTitle("Add New Vehicle")
            }
        }
        .alert(addVehicleFuelVM.errorMessage, isPresented: $addVehicleFuelVM.isError) {
            Button("OK", role: .cancel) {
                if(addVehicleFuelVM.isCloseView){
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
    
}
