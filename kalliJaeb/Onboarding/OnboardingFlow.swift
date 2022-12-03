//
//  LoginFlow.swift
//  kalliJaeb
//
//  Created by Krishna Venkatramani on 02/12/2022.
//

import Foundation
import SwiftUI
import SUI

struct OnboardingView: View {
    
    @State var show: Bool = false
    @State var showLogin: Bool = false
    struct Constants {
        static let heroHeader: String = "Welcome to khaaliJaeb!"
    }
    
    private func onAppear() {
        withAnimation(.easeInOut) {
            self.show = true
        }
    }
    
    var body: some View {
        ZStack {
            Color.surfaceBackground
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading) {
                Constants.heroHeader.bold(size: 50)
                    .text
                    .padding(.init(vertical: 5, horizontal: 10))
                    .slideIn(show: show, direction: .top)
                
                Spacer()
                
                Button(text: "Login", config: .large(background: .red)) {
                    print("Clicked on Login")
                }
                .slideIn(show: show, direction: .bottom)
                
                Button(text: "Register", config: .large(background: .yellow)) {
                    print("Clicked on Register")
                    self.showLogin = true
                }
                .slideIn(show: show, direction: .bottom)

            }
            .fillFrame(alignment: .leading)
            .padding(.init(by: 20))
            
            NavLink(isActive: $showLogin) {
                SeedView(type: .create)
            }
            
        }
        .onAppear(perform: onAppear)
    }
    
}


struct LoginFlow: View {
    
    var body: some View {
        Color.surfaceBackground
    }
}

fileprivate struct Preview: PreviewProvider {
    
    static var previews: some View {
        OnboardingView()
    }
}