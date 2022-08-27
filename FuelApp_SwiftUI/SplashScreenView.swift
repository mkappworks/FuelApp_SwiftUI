//
//  SplashScreenView.swift
//  FuelApp_SwiftUI
//
//  Created by asiri indatissa on 2022-08-27.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5

    var body: some View {
        if isActive {
            ContentView()
        } else {
            VStack {
                VStack {
                    Image("SplashIcon")
                        .font(.system(size: 60))
                        .cornerRadius(12.0)
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear{
                    withAnimation(.easeIn(duration: 1.2)){
                        self.size = 0.9
                        self.opacity = 1.0
                    }
                }
            }
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
                    self.isActive = true
                }
            }
        }
     
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}

