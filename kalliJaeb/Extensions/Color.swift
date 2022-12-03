//
//  Color.swift
//  kalliJaeb
//
//  Created by Krishna Venkatramani on 02/12/2022.
//

import Foundation
import SwiftUI

extension Color {
    enum Catalogue: String {
        case surfaceBackground
        case textColor
        case surfaceBackgroundInverse
        case textColorInverse
    }
}

extension Color.Catalogue {
    var color: Color { .init(self.rawValue) }
}


extension Color {
    static var textColor: Color { .Catalogue.textColor.color }
    static var surfaceBackground: Color { .Catalogue.surfaceBackground.color }
    static var textColorInverse: Color { .Catalogue.textColorInverse.color }
    static var surfaceBackgroundInverse: Color { .Catalogue.surfaceBackgroundInverse.color }
}
