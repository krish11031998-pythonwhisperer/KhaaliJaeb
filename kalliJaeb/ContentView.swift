//
//  ContentView.swift
//  kalliJaeb
//
//  Created by Krishna Venkatramani on 02/12/2022.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var state: ViewState
    let text: String = "<html><body><p>Hello!</p></body></html>"
    var body: some View {
        NavigationView {
            OnboardingView()
            
        }
    }
    
    @ViewBuilder var view: some View {
        
        if let url = Bundle.main.url(forResource: "googleTest", withExtension: "html"),
           let string = try? String(contentsOf: url, encoding: .utf8) {
            CustomWebView(html: string)
        } else {
            Color.clear
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
