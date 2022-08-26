//
//  AddQuotaView.swift
//  FuelApp_SwiftUI
//
//  Created by Malith Kuruppu on 2022-08-26.
//

import SwiftUI

struct AddQuotaView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var addQuotaVM: AddQuotaViewModel
    
    init(vm: AddQuotaViewModel){
        self.addQuotaVM = vm
    }
    
    var body: some View {
        Form{
            TextField("Enter Vehicle Type", text: $addQuotaVM.vehicleType)
            
            TextField("Enter Quota Amount", value: $addQuotaVM.quotaAmount, formatter: NumberFormatter())
            .keyboardType(.decimalPad)
            
            Button("Save"){
                addQuotaVM.save()
                presentationMode.wrappedValue.dismiss()
            }.centerHorizontally()
            
            .navigationTitle("Add New Quota")
        }
    }
}

struct AddQuotaView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = CoreDataManager.shared.persistenceStoreController.viewContext
        
        AddQuotaView(vm: AddQuotaViewModel(context: viewContext))
    }
}
