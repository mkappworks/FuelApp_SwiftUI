//
//  FuelTypeListView.swift
//  FuelApp_SwiftUI
//
//  Created by Malith Kuruppu on 2022-08-26.
//

import SwiftUI

struct FuelTypeListView: View {
    @State private var isPresented: Bool = false
    @Environment(\.managedObjectContext) var viewContext
    @ObservedObject private var fuelTypeListVM: FuelTypeListViewModel
    
    let af_enter_fuel:LocalizedStringKey = "af_enter_fuel"
    let fuel_type:LocalizedStringKey = "fuel_type"
    let fuel_types:LocalizedStringKey = "fuel_types"

    let af_new_fuel:LocalizedStringKey = "af_new_fuel"
    
    init(vm: FuelTypeListViewModel){
        self.fuelTypeListVM = vm
    }
    
    private func deleteFueltype(at offsets: IndexSet){
        offsets.forEach { index in
            let fuelType = fuelTypeListVM.fuelTypes[index]
            fuelTypeListVM.deleteFuelType(fuelTypeId: fuelType.id)
        }
    }
    
    var body: some View {
        NavigationView{
            VStack{
                List{
                    ForEach(fuelTypeListVM.fuelTypes){fuelType in
                        HStack{
                            Text("Fuel Type : \(fuelType.name.uppercased())")
                        }
                    }.onDelete(perform: deleteFueltype)
                }
            }
            .sheet(isPresented: $isPresented, onDismiss: {
                //dismiss
            }, content: {
                AddFuelTypeView(vm: AddFuelTypeViewModel(context: viewContext))
            })
            .navigationTitle(fuel_types)
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(af_new_fuel){
                        isPresented = true
                    }
                }
            }
        }
    }
}

struct FuelTypeListView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = CoreDataManager.shared.persistenceStoreController.viewContext
        
        FuelTypeListView(vm: FuelTypeListViewModel(context: viewContext))
    }
}
