//
//  HomePage.swift
//  kalliJaeb
//
//  Created by Krishna Venkatramani on 03/12/2022.
//

import Foundation
import SwiftUI
import SUI

struct HomePage: View {
    
    var mainBody: some View {
        
        VStack(alignment: .leading) {
            "Available Jobs".bold(size: 35).text
                .fillWidth(alignment: .leading)
            Spacer()
            JobFancySwipeView()
            Spacer()
            
        }.padding(.init(by: 10))
        .fillWidth()

        
    }
    
    var body: some View {
        ZStack {
            Color.surfaceBackground
                .ignoresSafeArea()
            
            mainBody
        }
        .navigationBarBackButtonHidden(true)
    }
    
}
