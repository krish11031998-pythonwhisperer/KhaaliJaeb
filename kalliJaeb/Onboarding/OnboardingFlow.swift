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
    @State var showRegister: Bool = false
    @State var showLogin: Bool = false
    struct Constants {
        static let heroHeader: String = "Welcome to khaaliJaeb!"
    }
    
    private func onAppear() {
        withAnimation(.easeInOut(duration: 1.5)) {
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
                
                Button(text: "Login", config: .large(background: .purple)) {
                    print("Clicked on Login")
                    self.showLogin = true
                }
                .slideIn(show: show, direction: .bottom)
                
                Button(text: "Register", config: .large(background: .purple)) {
                    print("Clicked on Register")
                    self.showRegister = true
                }
                .slideIn(show: show, direction: .bottom)

            }
            .fillFrame(alignment: .leading)
            .padding(.init(by: 20))
            
            NavLink(isActive: $showRegister) {
                SeedView(model: .init(pageType: .create))
            }
            
            NavLink(isActive: $showLogin) {
                LoginView()
            }
            
        }
        .onAppear(perform: onAppear)
    }
    
}
