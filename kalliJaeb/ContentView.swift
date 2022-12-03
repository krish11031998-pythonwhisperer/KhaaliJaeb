//
//  ContentView.swift
//  kalliJaeb
//
//  Created by Krishna Venkatramani on 02/12/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
//            SeedView(viewModel: .init(header: "Create Seed Phrase", nextPage: {
//                SeedView(viewModel: .init(header: "Confirm Seed Phrase", nextPage: {
//                    LoginFlow()
//                }))
//            }))
            OnboardingView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
