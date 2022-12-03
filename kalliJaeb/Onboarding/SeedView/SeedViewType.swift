//
//  SeedViewType.swift
//  kalliJaeb
//
//  Created by Krishna Venkatramani on 04/12/2022.
//

import Foundation
import SwiftUI

enum SeedViewType {
    case create
    case confirm(keys: [String])
}

extension SeedViewType {
    
    var header: String {
        switch self {
        case .create:
            return  "Create your Seed Phrase"
        case .confirm:
            return "Confirm your Seed Phrase"
        }
    }
}

