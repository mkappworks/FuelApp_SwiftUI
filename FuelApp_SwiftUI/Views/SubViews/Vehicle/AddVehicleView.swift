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
    
    let scan_vehicle_number:LocalizedStringKey = "scan_vehicle_number"
    let vehicle_number:LocalizedStringKey = "vehicle_number"
    let select_vehicle_type:LocalizedStringKey = "select_vehicle_type"
    let select_fuel_type:LocalizedStringKey = "select_fuel_type"
    let common_save:LocalizedStringKey = "common_save"
    let add_new_vehicle:LocalizedStringKey = "add_new_vehicle"
    let ok:LocalizedStringKey = "ok"

    
    var body: some View {
        
        VStack{
            Form{
                ScanButton(scannedText: $addVehicleVM.vehicleId, buttonImageName: "camera.badge.ellipsis", buttonTitle: "Scan Vehicle Number")
                
                if(addVehicleVM.vehicleId != ""){
                   Text( "Vehicle Number : \(addVehicleVM.vehicleId)")
                    Section(select_vehicle_type){
                        Picker(select_vehicle_type, selection: $addVehicleVM.selectedQuota) {
                            ForEach(addVehicleVM.quotas, id: \.self) {(quota: QuotaViewModel) in
                                Text(quota.vehicleType.uppercased())
                                    .tag(quota as QuotaViewModel?)
                                    .font(.system(size: 20))
                            }
                            
                        }
                        .frame(height: 75)
                        .pickerStyle(.wheel)
                    }
                    
                    Section(select_fuel_type){
                        Picker(select_fuel_type, selection: $addVehicleVM.selectedFuelType) {
                            ForEach(addVehicleVM.fuelTypes, id: \.self)  {(fuelType: FuelTypeViewModel) in
                                Text(fuelType.name.uppercased())
                                    .tag(fuelType as FuelTypeViewModel?)
                                    .font(.system(size: 20))
                            }
                            
                        }
                        .frame(height: 75)
                        .pickerStyle(.wheel)
                    }
                    
                    Button(common_save){
                        addVehicleVM.save()
                        presentationMode.wrappedValue.dismiss()

                    }
                    .centerHorizontally()
                    .navigationTitle(add_new_vehicle)
                }
                
            }
        }
        .alert(addVehicleVM.errorMessage, isPresented: $addVehicleVM.isError) {
            Button(ok, role: .cancel) {
                presentationMode.wrappedValue.dismiss()
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
