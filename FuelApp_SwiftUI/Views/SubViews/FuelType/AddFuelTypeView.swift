//
//  AddFuelTypeView.swift
//  FuelApp_SwiftUI
//
//  Created by Malith Kuruppu on 2022-08-26.
//

import SwiftUI

struct AddFuelTypeView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var addFuelTypeVM: AddFuelTypeViewModel
    
    let af_enter_fuel:LocalizedStringKey = "af_enter_fuel"
    let common_save:LocalizedStringKey = "common_save"
    let af_new_fuel:LocalizedStringKey = "af_new_fuel"

    init(vm: AddFuelTypeViewModel){
        self.addFuelTypeVM = vm
    }
    
    var body: some View {
        Form{
            TextField(af_enter_fuel, text: $addFuelTypeVM.name)
            
            
            Button(common_save){
                addFuelTypeVM.save()
                presentationMode.wrappedValue.dismiss()
            }.centerHorizontally()
            
            .navigationTitle(af_new_fuel)
        }
    }
}

struct AddFuelTypeView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = CoreDataManager.shared.persistenceStoreController.viewContext
        
        AddFuelTypeView(vm: AddFuelTypeViewModel(context: viewContext))
    }
}

