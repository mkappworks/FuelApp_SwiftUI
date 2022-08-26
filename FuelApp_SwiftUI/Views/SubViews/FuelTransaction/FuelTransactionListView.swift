//  FuelTransactionListView.swift
//  FuelManagement_SwiftUI (iOS)
//
//  Created by asiri indatissa on 2022-08-25.
//

import SwiftUI

struct FuelTransactionListView: View {
    @State private var isPresented: Bool = false
    @Environment(\.managedObjectContext) var viewContext
    @ObservedObject private var fuelTransactionListVM: FuelTransactionListViewModel
    
    init(vm: FuelTransactionListViewModel){
        self.fuelTransactionListVM = vm
    }
    
    private func deleteFuelTransaction(at offsets: IndexSet){
        offsets.forEach { index in
            let fuelTransaction = fuelTransactionListVM.fuelTransactions[index]
            fuelTransactionListVM.deleteFuelTransaction(fuelType: fuelTransaction.id)
        }
    }
    
    var body: some View {
        NavigationView{
            VStack{
                List{
                    ForEach(fuelTransactionListVM.fuelTransactions){fuelTransaction in
                        VStack{
                            Text("Pumped Amount : \(fuelTransaction.pumpedAmount)")
                            HStack{
                                Text("Current Amount : \(fuelTransaction.currentAmount)")
                                Text("Fuel Type : \(fuelTransaction.fuelType.uppercased())")
                                Text("Date : \(fuelTransaction.date)")

                            }
                        }
                        
                    }
                    .onDelete(perform: deleteFuelTransaction)
                }
            }
            .sheet(isPresented: $isPresented, onDismiss: {
                //dismiss
            }, content: {
                AddFuelTransactionView(vm: AddFuelTransactionViewModel(context: viewContext))
            })
            .navigationTitle("Add Fuel to Storage")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add Fuel to Storage"){
                        isPresented = true
                    }
                }
            }
        }
    }
}
struct FuelTransactionListView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = CoreDataManager.shared.persistenceStoreController.viewContext
        
        FuelTransactionListView(vm: FuelTransactionListViewModel(context: viewContext))
    }
}


