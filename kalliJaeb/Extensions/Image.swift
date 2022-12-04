//
//  Image.swift
//  kalliJaeb
//
//  Created by Krishna Venkatramani on 03/12/2022.
//

import Foundation
import UIKit

enum Logo: String, CaseIterable {
    case Python
    case JS
    case Rust
    case Solidity
    case Go
}

enum EmblemLogo: String, CaseIterable {
    case Polygon
}

extension Logo {
    var image: UIImage? { .init(named: rawValue)}
}

extension EmblemLogo {
    var image: UIImage? { .init(named: rawValue)}
}
