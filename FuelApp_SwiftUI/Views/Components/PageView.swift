//
//  PageView.swift
//  FuelApp_SwiftUI
//
//  Created by Malith Kuruppu on 2022-08-26.
//

import SwiftUI

struct PageView: View {
    var page: PageModel
    
    var body: some View {
        VStack(spacing: 10) {
            Image("\(page.imageUrl)")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .padding()
                .cornerRadius(30)
                .background(.gray.opacity(0.10))
                .cornerRadius(10)
                .padding()
            
            Text(page.name)
                .font(.title)
            Text(page.description)
                .font(.subheadline)
                .frame(width: 300)
        }
    }
}

struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        PageView(page: PageModel.helpPages[0])
    }
}
