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
                
                if(addStorageVM.storageId != ""){
                    
//                    Picker("Select Fuel Type", selection: $addStorageVM.fuelType) {
//                        ForEach(addStorageVM.fuelType, id: \.self.fuelType) {
//                            Text($0.fuelType.uppercased())
//                                .font(.system(size: 20))
//                        }
//                        
//                    }
//                    //            .frame(height: 50)
//                    .pickerStyle(.wheel)
                    
                    
                    
                    Button("Save"){
//                        addVehicleVM.save()
                        presentationMode.wrappedValue.dismiss()
                    }.centerHorizontally()
                    
                        .navigationTitle("Add New FuelType")
                    
                }
                
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
