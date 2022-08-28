//
//  StorageFuelListView.swift
//  FuelApp_SwiftUI
//
//  Created by Malith Kuruppu on 2022-08-26.
//

import SwiftUI

struct StorageFuelListView: View {
    @State private var isPresented: Bool = false
    @Environment(\.managedObjectContext) var viewContext
    @ObservedObject private var storageFuelListVM: StorageFuelListViewModel
    
    init(vm: StorageFuelListViewModel){
        self.storageFuelListVM = vm
    }
    let storage_fuel_transaction:LocalizedStringKey = "storage_fuel_transaction"
    let ok:LocalizedStringKey = "ok"

    private func deleteStorageFuel(at offsets: IndexSet){
        offsets.forEach { index in
            let storageFuel = storageFuelListVM.storageFuels[index]
            storageFuelListVM.deleteStorageFuel(storageFuelId: storageFuel.id)
        }
    }
    
    var body: some View {
        NavigationView{
            VStack{
                Section("Select Storage"){
                    Picker("Select Storage", selection: $storageFuelListVM.selectedStorage) {
                        ForEach(storageFuelListVM.storages, id: \.self)  {(storage: StorageViewModel) in
                            Text(storage.fuelType.uppercased())
                                .tag(storage as StorageViewModel?)
                                .font(.system(size: 20))
                        }
                        
                    }
                    .frame(height: 75)
                    .pickerStyle(.wheel)
                    .onChange(of: storageFuelListVM.selectedStorage) {newvalue in                            storageFuelListVM.getFuelTransactionByStorage()
                    }
                    
                }
                
                List{
                    ForEach(storageFuelListVM.storageFuels){storageFuel in
                        VStack(alignment: .leading){
                            Text("Date : \(storageFuel.date, style: .date)")
                            Text("Pumped Amount : \(storageFuel.pumpedAmount, specifier: "%.2f")")
                        }
                    }
                    .onDelete(perform: deleteStorageFuel)
                    
                }
            }
            .navigationTitle(storage_fuel_transaction)
            .toolbar{
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    if(storageFuelListVM.storages.count > 0){
                        Button("Pump Fuel to Storage"){
                            isPresented = true
                        }
                    }
                    
                }
            }
            .sheet(isPresented: $isPresented, onDismiss: {
                
            }, content: {
                AddStorageFuelView(vm: AddStorageFuelViewModel(context: viewContext, storage: storageFuelListVM.storage!))
            })
        }
        .alert(storageFuelListVM.errorMessage, isPresented: $storageFuelListVM.isError) {
            Button(ok, role: .cancel) {
                //dismiss alert
            }
            
        }
    }
}



struct StorageFuelListView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = CoreDataManager.shared.persistenceStoreController.viewContext
        
        StorageFuelListView(vm: StorageFuelListViewModel(context: viewContext))
    }
}

