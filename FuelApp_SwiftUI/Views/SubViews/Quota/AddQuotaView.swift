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
    
    let enter_vehicle_type:LocalizedStringKey = "enter_vehicle_type"
    let enter_quota_amount:LocalizedStringKey = "enter_quota_amount"
    let common_save:LocalizedStringKey = "common_save"
    let add_new_quota:LocalizedStringKey = "add_new_quota"
    
    init(vm: AddQuotaViewModel){
        self.addQuotaVM = vm
    }
    
    var body: some View {
        Form{
            TextField("enter_vehicle_type", text: $addQuotaVM.vehicleType)
            
            TextField("enter_quota_amount", value: $addQuotaVM.quotaAmount, formatter: NumberFormatter())
            .keyboardType(.decimalPad)
            
            Button("common_save"){
                addQuotaVM.save()
                presentationMode.wrappedValue.dismiss()
            }.centerHorizontally()
            
            .navigationTitle("add_new_quota")
        }
    }
}

struct AddQuotaView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = CoreDataManager.shared.persistenceStoreController.viewContext
        
        AddQuotaView(vm: AddQuotaViewModel(context: viewContext))
    }
}
