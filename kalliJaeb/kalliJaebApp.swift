//
//  kalliJaebApp.swift
//  kalliJaeb
//
//  Created by Krishna Venkatramani on 02/12/2022.
//

import SwiftUI

class ViewState: ObservableObject {
    @Published var showOnBoarding: Bool = true {
        willSet {
            showHome = false
        }
    }
    @Published var showHome: Bool = false {
        willSet {
            showOnBoarding = false
        }
    }
}


@main
struct kalliJaebApp: App {
    
    @StateObject var state: ViewState = .init()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(state)
        }
    }
}
