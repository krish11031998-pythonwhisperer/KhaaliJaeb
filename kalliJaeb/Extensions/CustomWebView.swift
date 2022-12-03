//
//  CustomWebView.swift
//  kalliJaeb
//
//  Created by Krishna Venkatramani on 03/12/2022.
//

import Foundation
import SwiftUI
import UIKit
import WebKit

struct CustomWebView: UIViewRepresentable {
    
    let html: String
    init(html:String) {
        self.html = html
    }
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        uiView.loadHTMLString(html, baseURL: nil)
    }
    
}

