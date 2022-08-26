//
//  QuotaListView.swift
//  FuelApp_SwiftUI
//
//  Created by Malith Kuruppu on 2022-08-26.
//

import SwiftUI

struct QuotaListView: View {
    @State private var isPresented: Bool = false
    @Environment(\.managedObjectContext) var viewContext
    @ObservedObject private var quotaListVM: QuotaListViewModel
    
    init(vm: QuotaListViewModel){
        self.quotaListVM = vm
    }
    
    private func deleteQuota(at offsets: IndexSet){
        offsets.forEach { index in
            let quota = quotaListVM.quotas[index]
            quotaListVM.deleteQuota(quotaId: quota.id)
        }
    }
    
    var body: some View {
        NavigationView{
            VStack{
                List{
                    ForEach(quotaListVM.quotas){quota in
                        HStack{
                            Text("Vehicle Type : \(quota.vehicleType.uppercased())")
                            Text("Montly Quota : \(quota.quotaAmount, specifier: "%.2f")")
                        }
                    }.onDelete(perform: deleteQuota)
                }
            }
            .sheet(isPresented: $isPresented, onDismiss: {
                //dismiss
            }, content: {
                AddQuotaView(vm: AddQuotaViewModel(context: viewContext))
            })
            .navigationTitle("Quotas")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add New Quota"){
                        isPresented = true
                    }
                }
            }
        }
    }
}

struct QuotaListView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = CoreDataManager.shared.persistenceStoreController.viewContext
        
        QuotaListView(vm: QuotaListViewModel(context: viewContext))
    }
}

