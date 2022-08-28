//
//  AnalysisView.swift
//  FuelApp_SwiftUI
//
//  Created by Malith Kuruppu on 2022-08-26.
//

import SwiftUI

struct AnalysisView: View {
    @Environment(\.managedObjectContext) var viewContext
    @ObservedObject private var analysisVM: AnalysisViewModel
    
    init(vm: AnalysisViewModel){
        self.analysisVM = vm
    }
    
    
    var body: some View {
        NavigationView{
            VStack{
                Form{
                    Section("Select Storage"){
                        Picker("Select Storage", selection: $analysisVM.selectedStorage) {
                            ForEach(analysisVM.storages, id: \.self)  {(storage: StorageViewModel) in
                                Text(storage.fuelType.uppercased())
                                    .tag(storage as StorageViewModel?)
                                    .font(.system(size: 20))
                            }
                        }
                        .frame(height: 75)
                        .pickerStyle(.wheel)
                        .onChange(of: analysisVM.selectedStorage) {newvalue in                              analysisVM.getFuelTransactions()
                        }
                        
                    }
                    
                    DatePicker("Select Start Date", selection: $analysisVM.startDate, in: ...Date(), displayedComponents: .date )
                        .onChange(of: analysisVM.startDate) {newvalue in                              analysisVM.getFuelTransactions()
                        }
                    
                    TextField("Enter Fuel Value to Predict", value: $analysisVM.predictedFuelLevel, formatter: NumberFormatter())
                        .keyboardType(.decimalPad)
                    
                    if(analysisVM.predictedDate != nil){
                        Text("Predict date that fuel will reach \(analysisVM.predictedFuelLevel, specifier: "%.2f") : \(analysisVM.predictedDate!, style: .date)")
                    }
                    
                    Button("Predict"){
                        analysisVM.prediction()
                    }
                }
                
                
                
            }
            .navigationTitle("Fuel Analysis")
            
            //            .sheet(isPresented: $isPresented, onDismiss: {
            //
            //            }, content: {
            //                AddStorageFuelView(vm: AddStorageFuelViewModel(context: viewContext, storage: storageFuelListVM.storage!))
            //            })
            //        }
            //        .alert(storageFuelListVM.errorMessage, isPresented: $storageFuelListVM.isError) {
            //            Button("OK", role: .cancel) {
            //                //dismiss alert
            //            }
            //
            //        }
        }
    }
}

struct AnalysisView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = CoreDataManager.shared.persistenceStoreController.viewContext
        
        AnalysisView(vm: AnalysisViewModel(context: viewContext))
        
    }
}

