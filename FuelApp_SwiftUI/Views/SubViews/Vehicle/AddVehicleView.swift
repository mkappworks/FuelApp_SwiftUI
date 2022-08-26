//
//  AddVehicleView.swift
//  FuelApp_SwiftUI
//
//  Created by Malith Kuruppu on 2022-08-26.
//

import SwiftUI

struct AddVehicleView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var addVehicleVM: AddVehicleViewModel
    
    init(vm: AddVehicleViewModel){
        self.addVehicleVM = vm
    }
    
    var body: some View {
        
        VStack{
            
            
            Form{
                ScanButton(scannedText: $addVehicleVM.vehicleId, buttonImageName: "camera.badge.ellipsis", buttonTitle: "Scan Vehicle Number")
                
                if(addVehicleVM.vehicleId != ""){
                    TextField("Vehicle Number", text: $addVehicleVM.vehicleId)
                        .disabled(true)
                    
                    
                    Picker("Select Vehicle Type", selection: $addVehicleVM.vehicleType) {
                        ForEach(addVehicleVM.quotas, id: \.self.vehicleType) {
                            Text($0.vehicleType.uppercased())
                                .font(.system(size: 20))
                        }
                        
                    }
                    //            .frame(height: 50)
                    .pickerStyle(.wheel)
                    
                    
//                    Picker("Select Fuel Type", selection: $addVehicleVM.fuelType) {
//                        ForEach($addVehicleVM. FuelType.allCases, id: \.self) {
//                            Text($0.rawValue.uppercased())
//                                .font(.system(size: 20))
//                        }
//                        
//                    }
//                            .frame(height: 50)
//                    .pickerStyle(.wheel)
                    
                    
                    Button("Save"){
                        addVehicleVM.save()
                        presentationMode.wrappedValue.dismiss()
                    }.centerHorizontally()
                    
                        .navigationTitle("Add New Vehicle")
                    
                }
                
            }
        }
    }
}

struct AddVehicleView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = CoreDataManager.shared.persistenceStoreController.viewContext
        
        AddVehicleView(vm: AddVehicleViewModel(context: viewContext))
    }
}
