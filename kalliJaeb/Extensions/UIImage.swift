//
//  UIImage.swift
//  kalliJaeb
//
//  Created by Krishna Venkatramani on 03/12/2022.
//

import Foundation
import UIKit

extension UIImage {
    func resized(size newSize: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: newSize)
        let image = renderer.image { _ in self.draw(in: CGRect(origin: .zero, size: newSize)) }
        let newImage = image.withRenderingMode(renderingMode)
        return newImage
    }
}
