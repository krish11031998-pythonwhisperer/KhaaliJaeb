//
//  CustomFonts.swift
//  kalliJaeb
//
//  Created by Krishna Venkatramani on 02/12/2022.
//

import Foundation
import SwiftUI
import SUI

enum CustomFonts:String{
    case black = "Satoshi-Black"
    case bold = "Satoshi-Bold"
    case regular = "Satoshi-Regular"
    case medium = "Satoshi-Medium"
    case light = "Satoshi-Light"
    case sectionHeader = "Gilroy-Bold"
    
    func fontBuilder(size: CGFloat) -> UIFont? {
        .init(name: self.rawValue, size: size)
    }
}


extension String {
    
    func styled(font: CustomFonts, color: Color, size: CGFloat) -> RenderableText {
        styled(font: font.fontBuilder(size: size) ?? .systemFont(ofSize: size), color: color)
    }
    
    func regular(color: Color = .textColor, size: CGFloat) -> RenderableText  { styled(font: .regular, color: color, size: size) }
    func medium(color: Color = .textColor, size: CGFloat) -> RenderableText  { styled(font: .medium, color: color, size: size) }
    func semiBold(color: Color = .textColor, size: CGFloat) -> RenderableText  { styled(font: .regular, color: color, size: size) }
    func bold(color: Color = .textColor, size: CGFloat) -> RenderableText  { styled(font: .bold, color: color, size: size) }
    func extraBold(color: Color = .textColor, size: CGFloat) -> RenderableText  { styled(font: .black, color: color, size: size) }
    func sectionHeader(color: Color = .textColor, size: CGFloat) -> RenderableText { styled(font: .sectionHeader, color: color, size: size)}
}
