//
//  SplashView.swift
//  FuelApp_SwiftUI
//
//  Created by Malith Kuruppu on 2022-08-27.
//

import SwiftUI

struct SplashView: View {
    @State private var isActive = false
    
    var body: some View {
        if isActive {
            ContentView()
        } else {
            Image("SplashIcon")
                .font(.system(size: 60))
                .cornerRadius(12.0)
                .onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
                        self.isActive = true
                    }
                }
        }
        
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}


