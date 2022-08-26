//
//  HelpView.swift
//  FuelApp_SwiftUI
//
//  Created by Malith Kuruppu on 2022-08-26.
//

import SwiftUI

struct HelpView: View {
    @State private var pageIndex = 0
    private let pages: [PageModel] = PageModel.helpPages
    private let dotAppearance = UIPageControl.appearance()
    
    var body: some View {
        ZStack {
            NavigationView {
                TabView(selection: $pageIndex) {
                    ForEach(pages) { page in
                        VStack {
                            Spacer()
                            PageView(page: page)
                            Spacer()
                        }
                        .tag(page.tag)
                        
                    }
                }
                .navigationTitle("Help")
                
            }
            .animation(.easeInOut, value: pageIndex)
            .indexViewStyle(.page(backgroundDisplayMode: .interactive))
            .tabViewStyle(PageTabViewStyle())
            .onAppear {
                dotAppearance.currentPageIndicatorTintColor = .black
                dotAppearance.pageIndicatorTintColor = .gray
        }
        }
        
    }
    
    func incrementPage() {
        pageIndex += 1
    }
    
    func goToZero() {
        pageIndex = 0
    }
}

struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        HelpView()
    }
}

