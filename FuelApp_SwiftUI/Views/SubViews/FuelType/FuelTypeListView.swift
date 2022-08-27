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
            .navigationTitle("Fuel Types")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add New Fuel Type"){
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
