//
//  ViewHelper.swift
//  kalliJaeb
//
//  Created by Krishna Venkatramani on 03/12/2022.
//

import Foundation
import SwiftUI
import SUI

struct SizeModifier: ViewModifier {
    
    var size: (CGSize) -> Void
    
    init(size: @escaping (CGSize) -> Void) {
        self.size = size
    }
    
    
    func body(content: Content) -> some View {
        content
            .background {
                GeometryReader { g -> AnyView in
                    DispatchQueue.main.async {
                        size(g.size)
                    }
                    
                    return Color.clear.anyView
                }
            }
    }
    
}

extension View {
    func getSize(_ size: @escaping (CGSize) -> Void)  -> some View{
        self.modifier(SizeModifier(size: size))
    }
    
}
