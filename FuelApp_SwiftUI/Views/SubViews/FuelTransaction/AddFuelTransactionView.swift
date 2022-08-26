//
//  AddFuelTransactionView.swift
//  FuelManagement_SwiftUI (iOS)
//
//  Created by asiri indatissa on 2022-08-25.
//

import SwiftUI

struct AddFuelTransactionView: View {
    @Environment(\.presentationMode) var presentationMode
       @ObservedObject private var addFuelTransactionViewVM: AddFuelTransactionViewModel
       
       init(vm: AddFuelTransactionViewModel){
           self.addFuelTransactionViewVM = vm
       }
    var body: some View {
        
        VStack{
            
            Form{
                TextField("Enter Fuel Type", text: $addFuelTransactionViewVM.fuelType)
                
                TextField("Enter Pumped Amount", value: $addFuelTransactionViewVM.pumped, formatter: NumberFormatter())
                .keyboardType(.decimalPad)
                    Button("Save"){
                        addFuelTransactionViewVM.save()
                        presentationMode.wrappedValue.dismiss()
                    }.centerHorizontally()
                    
                        .navigationTitle("Add Fuel to Storage")
                    
                }
                
            }
        }
    }

struct AddFuelTransactionView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = CoreDataManager.shared.persistenceStoreController.viewContext
        AddFuelTransactionView(vm: AddFuelTransactionViewModel(context: viewContext))
    }
}


