//
//  ContentView.swift
//  FuelApp_SwiftUI
//
//  Created by Malith Kuruppu on 2022-08-26.
//

import SwiftUI

struct ContentView: View {
    let tab_home:LocalizedStringKey = "tab_home"
    let tab_analysis:LocalizedStringKey = "tab_analysis"
    let tab_help:LocalizedStringKey = "tab_help"

    
    var body: some View {
        ZStack{
                TabView{
                    HomeView()
                        .tabItem {
                            Image(systemName: "house")
                            Text(tab_home)
                        }
                    AnalysisView()
                        .tabItem {
                            Image(systemName: "building.columns.fill")
                            Text(tab_analysis)
                        }
                    HelpView()
                        .tabItem {
                            Image(systemName: "questionmark")
                            Text(tab_help)
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
