//
//  StorageListView.swift
//  FuelApp_SwiftUI
//
//  Created by Malith Kuruppu on 2022-08-26.
//

import SwiftUI

struct StorageListView: View {
    @State private var isPresented: Bool = false
    @Environment(\.managedObjectContext) var viewContext
    @ObservedObject private var storageListVM: StorageListViewModel
    
    init(vm: StorageListViewModel){
        self.storageListVM = vm
    }
    
    private func deleteStorage(at offsets: IndexSet){
        offsets.forEach { index in
            let storage = storageListVM.storages[index]
            storageListVM.deleteStorage(storageId: storage.id)
        }
    }
    
    var body: some View {
        NavigationView{
            VStack{
                List{
                    ForEach(storageListVM.storages){storage in
                        VStack{
                            Text("Fuel Type : \(storage.fuelType)")
//                            HStack{
//                                Text("Vehicle Type : \(vehicle.vehicleType.uppercased())")
//                                Text("Fuel Type : \(vehicle.fuelType.uppercased())")
//                            }
                        }
                        
                    }
                    .onDelete(perform: deleteStorage)
                }
            }
            .sheet(isPresented: $isPresented, onDismiss: {
                //dismiss
            }, content: {
                AddVehicleView(vm: AddVehicleViewModel(context: viewContext))
            })
            .navigationTitle("Storages")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add New storage"){
                        isPresented = true
                    }
                }
            }
        }
    }
}

struct StorageListView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = CoreDataManager.shared.persistenceStoreController.viewContext
        
        VehicleListView(vm: VehicleListViewModel(context: viewContext))
    }
}

