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
    let hv_storages:LocalizedStringKey = "hv_storages"
    let add_new_storage:LocalizedStringKey = "add_new_storage"
    
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
                        VStack(alignment:.leading){
                            Text("Fuel Type : \(storage.fuelType.uppercased())")
                            Text("Storage Capacity : \(storage.storageCapacity, specifier: "%.2f")")
                            Text("Current Amount : \(storage.currentAmount, specifier: "%.2f")")
                        }
                        
                    }
                    .onDelete(perform: deleteStorage)
                }
            }
            .sheet(isPresented: $isPresented, onDismiss: {
                //dismiss
            }, content: {
                AddStorageView(vm: AddStorageViewModel(context: viewContext))
            })
            .navigationTitle(hv_storages)
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(add_new_storage){
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
        
        StorageListView(vm: StorageListViewModel(context: viewContext))
    }
}

