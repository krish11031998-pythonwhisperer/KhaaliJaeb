//
//  SlideAnimaton.swift
//  kalliJaeb
//
//  Created by Krishna Venkatramani on 02/12/2022.
//

import Foundation
import SwiftUI


struct SlideIn: Animatable, ViewModifier {
    
    enum Direction {
        case left, right, top, bottom
    }
    
    var show: Bool
    let offset: CGFloat
    let direction: Direction
    
    init(show: Bool, direction: Direction, off: CGFloat = -10) {
        self.show = show
        self.direction = direction
        self.offset = off
    }
    
    var animatableData: Bool {
        get { show }
        set { show = newValue }
    }
    
    func body(content: Content) -> some View {
        switch direction {
        case .top, .bottom:
            content
                .opacity(show ? 1 : 0)
                .offset(y: show ? 0 : direction == .top ? -offset : offset)
        case .left,.right:
            content
                .opacity(show ? 1 : 0)
                .offset(y: show ? 0 : direction == .left ? -offset : offset)
        }
        
    }
}

extension View {
    
    func slideIn(show: Bool, direction: SlideIn.Direction, offset: CGFloat = 10) -> some View {
        self.modifier(SlideIn(show: show, direction: direction, off: offset))
    }
}
