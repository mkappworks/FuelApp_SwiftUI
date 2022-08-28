//
//  ContentView.swift
//  FuelApp_SwiftUI
//
//  Created by Malith Kuruppu on 2022-08-26.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var viewContext
    
    var body: some View {
        ZStack{
                TabView{
                    HomeView()
                        .tabItem {
                            Image(systemName: "house")
                            Text("Home")
                        }
                    AnalysisView(vm: AnalysisViewModel(context: viewContext))
                        .tabItem {
                            Image(systemName: "building.columns.fill")
                            Text("Analysis")
                        }
                    HelpView()
                        .tabItem {
                            Image(systemName: "questionmark")
                            Text("Help")
                        }
                    
                    
                }
                .background(.gray)
                
            }
        
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
