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
    
    init(vm: AddFuelTypeViewModel){
        self.addFuelTypeVM = vm
    }
    
    var body: some View {
        Form{
            TextField("Enter Fuel Type", text: $addFuelTypeVM.name)
            
            
            Button("Save"){
                addFuelTypeVM.save()
                presentationMode.wrappedValue.dismiss()
            }.centerHorizontally()
            
            .navigationTitle("Add New Fuel Type")
        }
    }
}

struct AddFuelTypeView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = CoreDataManager.shared.persistenceStoreController.viewContext
        
        AddFuelTypeView(vm: AddFuelTypeViewModel(context: viewContext))
    }
}

