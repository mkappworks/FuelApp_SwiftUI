//
//  AddStorageFuelView.swift
//  FuelApp_SwiftUI
//
//  Created by Malith Kuruppu on 2022-08-28.
//

import SwiftUI
import CoreData

struct AddStorageFuelView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var addStorageFuelVM: AddStorageFuelViewModel
    
    init(vm: AddStorageFuelViewModel){
        self.addStorageFuelVM = vm
    }
    
    var body: some View {
        VStack{
            Form{
                Text("Fuel Type : \(addStorageFuelVM.fuelTypeName)")
                
                Section("Enter Pumped Amount"){
                    TextField("Enter Pumped Amount", value: $addStorageFuelVM.pumpedAmount, formatter: NumberFormatter())
                        .keyboardType(.decimalPad)
                }
                
                Button("Save"){
                    addStorageFuelVM.save()
                    if(addStorageFuelVM.isError == false){
                        presentationMode.wrappedValue.dismiss()
                    }
                   
                }
                .centerHorizontally()
                .navigationTitle("Add New Storage Fuel")
            }
        }
        .alert(addStorageFuelVM.errorMessage, isPresented: $addStorageFuelVM.isError) {
            Button("OK", role: .cancel) {
                if(addStorageFuelVM.isCloseView){
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
    
}

