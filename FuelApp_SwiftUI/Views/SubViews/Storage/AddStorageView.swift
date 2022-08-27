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
    
    var body: some View {
        
        VStack{
            Form{
                Section("Select Fuel Type"){
                    Picker("Select Fuel Type", selection: $addStorageVM.selectedFuelType) {
                        ForEach(addStorageVM.fuelTypes, id: \.self)  {(fuelType: FuelTypeViewModel) in
                            Text(fuelType.name.uppercased())
                                .tag(fuelType as FuelTypeViewModel?)
                                .font(.system(size: 20))
                        }
                        
                    }
                    .frame(height: 75)
                    .pickerStyle(.wheel)
                }
                          TextField("Enter Storage Capacity", value: $addStorageVM.storageCapacity, formatter: NumberFormatter())
                          .keyboardType(.decimalPad)
                          Button("Save"){
                    addStorageVM.save()
                    presentationMode.wrappedValue.dismiss()
                    }.centerHorizontally()
                    
                    .navigationTitle("Add New FuelType")
                    
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
