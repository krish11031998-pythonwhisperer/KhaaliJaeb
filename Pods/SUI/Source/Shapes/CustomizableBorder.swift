//
//  CustomizableRoundBorder.swift
//  SUI
//
//  Created by Krishna Venkatramani on 17/09/2022.
//

import SwiftUI

struct CustomizableBorder: Shape {
	
	let size: CGSize
	let isEditting: Bool
	let cornerRadius: CGFloat
	let inset: CGFloat
	
	init(size: CGSize, cornerRadius: CGFloat, inset: CGFloat, isEditting: Bool) {
		self.size = size
		self.cornerRadius = cornerRadius
		self.isEditting = isEditting
		self.inset = inset
	}
	
	var cutOff: CGFloat {
		isEditting ? size.width : 0
	}
	
	func path(in rect: CGRect) -> Path {
		var path = Path()
		path.move(to: .init(x: rect.minX + inset, y: rect.minY))
        path.addLine(to: .init(x: rect.minX + cornerRadius, y: rect.minY))
        path.addQuadCurve(to: .init(x: rect.minX, y: rect.minY + cornerRadius), control: .init(x: rect.minX, y: rect.minY))
		path.addLine(to: .init(x: rect.minX, y: rect.maxY - cornerRadius))
        path.addQuadCurve(to: .init(x: rect.minX + cornerRadius, y: rect.maxY), control: .init(x: rect.minX, y: rect.maxY))
		path.addLine(to: .init(x: rect.maxX - cornerRadius, y: rect.maxY))
        path.addQuadCurve(to: .init(x: rect.maxX, y: rect.maxY - cornerRadius), control: .init(x: rect.maxX, y: rect.maxY))
		path.addLine(to: .init(x: rect.maxX, y: rect.minY + cornerRadius))
        path.addQuadCurve(to: .init(x: rect.maxX - cornerRadius, y: rect.minY), control: .init(x: rect.maxX, y: rect.minY))
		path.addLine(to: .init(x: rect.minX + cutOff + inset, y: rect.minY))
		return path
	}
	
}

