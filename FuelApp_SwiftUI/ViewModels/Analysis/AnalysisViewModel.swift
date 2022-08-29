//
//  AnalysisViewModel.swift
//  FuelApp_SwiftUI
//
//  Created by Malith Kuruppu on 2022-08-28.
//

import Foundation
import CoreData

@MainActor
class AnalysisViewModel: ObservableObject{
    @Published var startDate: Date = Date.now
    @Published var predictedFuelLevel: Double = 0.0
    @Published var predictedDate: Date?
    
    @Published var errorMessage: String = ""
    @Published var isError: Bool = false
    
    @Published var selectedStorage: StorageViewModel?
    @Published var storages = [StorageViewModel]()
    @Published var storage: Storage?
    
    private var fetchStorageFuels = [AnalysisFuelViewModel]()
    private var fetchVehicleFuels = [AnalysisFuelViewModel]()
    
    var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext){
        self.context = context
        
        self.getStorages()
        
        self.getFuelTransactions()
        
    }
    
    func getFuelTransactions(){
        self.getFuelTransactionByStorage()
        self.getFuelTransactionByVehicles()
    }
    
    private func getStorages(){
        do{
            let request = NSFetchRequest<Storage>(entityName: "Storage")
            
            let fetchedStorages = try context.fetch(request)
            
            storage = fetchedStorages.first
            storages = fetchedStorages.map(StorageViewModel.init)
            
            
            if(storages.count == 0){
                errorMessage.append(contentsOf: "No Storages found. Please add a Storage. ")
                isError = true
                return
            }
            
            selectedStorage = storages.first
            
        }catch{
            print(error)
        }
        
    }
    
    func getFuelTransactionByStorage(){
        if(storages.count == 0){return}
        
        storage = selectedStorage?.storageEntity
        
        
        let storageFuel  = storage?.fuelTransactions?.filtered(using: NSPredicate(format: "(date >= %@)",  startDate as NSDate)) as! Set<FuelTransaction>

        fetchStorageFuels.removeAll()
        
        fetchStorageFuels.append(contentsOf: storageFuel.map(AnalysisFuelViewModel.init))
        
        fetchStorageFuels.sort{
            $0.date < $1.date
        }

    }
    
    func getFuelTransactionByVehicles(){
        do{
            if(storage == nil ){return}
            
            let fuelTypeName = storage?.fuelTypes?.name
            
            let request = NSFetchRequest<Vehicle>(entityName: "Vehicle")
            request.sortDescriptors = []
            request.predicate = NSPredicate(format: "fuelTypes.name == %@", fuelTypeName!)
            
            let fetchedVehicles: [Vehicle] = try context.fetch(request)
            fetchVehicleFuels.removeAll()
            
            for vehicle in fetchedVehicles {
                
                let vehicleFuel = vehicle.fuelTransactions?.filtered(using: NSPredicate(format: "(date >= %@)",  startDate as NSDate)) as! Set<FuelTransaction>
                
                fetchVehicleFuels.append(contentsOf: vehicleFuel.map(AnalysisFuelViewModel.init))
                
            }
            
            fetchVehicleFuels.sort{
                $0.date < $1.date
            }
            
        }catch{
            print(error)
        }
    }
    
    func prediction(){
        let storageDateToTotalPumpedDict =  getDateToTotalPumpedDict(dict: getDateToAnalysisFuelVMDict(array: fetchStorageFuels), multipler: 1)
        
        let vehicleDateToTotalPumpedDict =  getDateToTotalPumpedDict(dict: getDateToAnalysisFuelVMDict(array: fetchVehicleFuels), multipler: -1)
        
        let combinedDateToTotalPumpedDict = storageDateToTotalPumpedDict.merging(vehicleDateToTotalPumpedDict ){(first, second) in first+second}
        
        let  sortedDateToTotalPumpedDict =  sortDateDict(dict: combinedDateToTotalPumpedDict)
        
        let dayToTotalPumpedDict  = transformDic(dict: sortedDateToTotalPumpedDict)
        
        calculatePredictedDate(dict: dayToTotalPumpedDict, dictStartDate: Array(sortedDateToTotalPumpedDict)[0].key)
    }
    
    
    private func getDateToAnalysisFuelVMDict(array: [AnalysisFuelViewModel]) -> [Date : [AnalysisFuelViewModel] ]{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MM yyyy"
        
        return Dictionary(grouping: array, by: {  dateFormatter.date(from: dateFormatter.string(from: $0.date)) ?? $0.date })
    }
    
    private func getDateToTotalPumpedDict(dict: [Date : [AnalysisFuelViewModel]], multipler: Double)->[Date : Double]{
        
        var  dateTotalPumpedDictionary =  [Date : Double]()
        
        for (key, value) in dict {
            let totalPumpedByDate = value.map{ $0.pumpedAmount }.reduce(0, +) * multipler
            dateTotalPumpedDictionary.updateValue(totalPumpedByDate, forKey: key)
        }
        
        
        return dateTotalPumpedDictionary
        
    }
    
    private func sortDateDict(dict: [Date:Double])->[Dictionary<Date, Double>.Element]{
        
        let sortedDict = dict.sorted(by: { $0.key < $1.key } )
        
        return sortedDict
        
    }
    
    private func sortDayDict(dict: [Double:Double])->[Dictionary<Double, Double>.Element]{
        
        let sortedDict = dict.sorted(by: { $0.key < $1.key } )
        
        return sortedDict
        
    }
    
    private func transformDic(dict: [Dictionary<Date, Double>.Element])-> [Dictionary<Double, Double>.Element]{

        var  dayToTotalPumpedDict =  [Double : Double]()
        
        let startDateInDict: Date = Array(dict)[0].key
        
        for(key, value) in dict{
            if(key == startDateInDict){
                dayToTotalPumpedDict.updateValue(value, forKey: 0)
            }
            
            let delta = startDateInDict.distance(to: key)/(3600*24)
            
            dayToTotalPumpedDict.updateValue(value, forKey: delta)
        }
        
        return sortDayDict(dict: dayToTotalPumpedDict)
    }
    
    private func calculatePredictedDate(dict: [Dictionary<Double, Double>.Element], dictStartDate: Date){
        
        let dictCount:Double = Double(dict.count)
        
        let averageDays = dict.map{ $0.key }.reduce(0.0, +) / dictCount
        let averageDayTotalPumped = dict.map{ $0.value }.reduce(0.0, +) / dictCount
        
        var sumXX = 0.0
        var sumXY = 0.0
        
        for(key, value) in dict{
            let deltaDaysX = key - averageDays
            let deltaTotalPumpedY = value - averageDayTotalPumped
            
            let xx = deltaDaysX * deltaDaysX
            
            let xy = deltaDaysX * deltaTotalPumpedY
            
            sumXX += xx
            sumXY += xy
            
        }
  
        let slopeOfBestFitLine = sumXY/sumXX
        
        let yIntercept =  Array(dict)[0].value
        
        let dayFromStartDay = (predictedFuelLevel - yIntercept)/slopeOfBestFitLine
        
        predictedDate = Calendar.current.date(byAdding: .day, value: Int(dayFromStartDay), to: dictStartDate)
    }
}


struct AnalysisFuelViewModel: Identifiable{
    private var fuelTransaction: FuelTransaction
    
    init(fuelTransaction: FuelTransaction){
        self.fuelTransaction = fuelTransaction
    }
    
    var id: NSManagedObjectID{
        fuelTransaction.objectID
    }
    
    var date: Date{
        fuelTransaction.date!
    }
    
    var pumpedAmount: Double{
        fuelTransaction.pumpedAmount
    }
    
}

