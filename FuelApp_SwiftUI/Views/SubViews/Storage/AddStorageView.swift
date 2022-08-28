//
//  AddStorageView.swift
//  FuelApp_SwiftUI
//
//  Created by Malith Kuruppu on 2022-08-26.
//

import SwiftUI

struct AddStorageView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var addStorageVM: AddStorageViewModel
    
    init(vm: AddStorageViewModel){
        self.addStorageVM = vm
    }
    
    let select_fuel_type:LocalizedStringKey = "select_fuel_type"
    let enter_storage_capacity:LocalizedStringKey = "enter_storage_capacity"
    let common_save:LocalizedStringKey = "common_save"
    let af_new_fuel:LocalizedStringKey = "af_new_fuel"

    var body: some View {
        
        VStack{
            Form{
                Section(select_fuel_type){
                    Picker(select_fuel_type, selection: $addStorageVM.selectedFuelType) {
                        ForEach(addStorageVM.fuelTypes, id: \.self)  {(fuelType: FuelTypeViewModel) in
                            Text(fuelType.name.uppercased())
                                .tag(fuelType as FuelTypeViewModel?)
                                .font(.system(size: 20))
                        }
                        
                    }
                    .frame(height: 75)
                    .pickerStyle(.wheel)
                }
                Section(enter_storage_capacity){
                    TextField(enter_storage_capacity, value: $addStorageVM.storageCapacity, formatter: NumberFormatter())
                        .keyboardType(.decimalPad)
                }
                
                Button(common_save){
                    addStorageVM.save()
                    presentationMode.wrappedValue.dismiss()
                }.centerHorizontally()
                
                    .navigationTitle(af_new_fuel)
                
            }
        }
    }
}

struct AddStorageView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = CoreDataManager.shared.persistenceStoreController.viewContext
        
        AddStorageView(vm: AddStorageViewModel(context: viewContext))
    }
}
