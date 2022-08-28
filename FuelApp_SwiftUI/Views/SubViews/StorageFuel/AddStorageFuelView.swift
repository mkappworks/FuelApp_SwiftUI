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
    let enter_pumped_amount:LocalizedStringKey = "enter_pumped_amount"
    let ok:LocalizedStringKey = "ok"
    let common_save:LocalizedStringKey = "common_save"
    let addNew_storage_fuel:LocalizedStringKey = "addNew_storage_fuel"

    var body: some View {
        VStack{
            Form{
                Text("Fuel Type : \(addStorageFuelVM.fuelTypeName)")
                
                Section(enter_pumped_amount){
                    TextField(enter_pumped_amount, value: $addStorageFuelVM.pumpedAmount, formatter: NumberFormatter())
                        .keyboardType(.decimalPad)
                }
                
                Button(common_save){
                    addStorageFuelVM.save()
                    if(addStorageFuelVM.isError == false){
                        presentationMode.wrappedValue.dismiss()
                    }
                   
                }
                .centerHorizontally()
                .navigationTitle(addNew_storage_fuel)
            }
        }
        .alert(addStorageFuelVM.errorMessage, isPresented: $addStorageFuelVM.isError) {
            Button(ok, role: .cancel) {
                if(addStorageFuelVM.isCloseView){
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
    
}

