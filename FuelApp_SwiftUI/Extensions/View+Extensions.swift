//
//  View+Extensions.swift
//  FuelApp_SwiftUI
//
//  Created by Malith Kuruppu on 2022-08-26.
//

import Foundation
import SwiftUI

extension View{
    
    func centerHorizontally() -> some View{
        HStack{
            Spacer()
            self
            Spacer()
        }
    }
    
    func hideKeyboard(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
