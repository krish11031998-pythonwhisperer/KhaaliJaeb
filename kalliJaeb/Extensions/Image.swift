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
}

extension Logo {
    var image: UIImage? { .init(named: rawValue)}
}
