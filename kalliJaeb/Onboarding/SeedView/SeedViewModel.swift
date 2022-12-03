//
//  SeedViewModel.swift
//  kalliJaeb
//
//  Created by Krishna Venkatramani on 03/12/2022.
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
    
    func confirmCondition(keysToConfirm: [String]) -> Bool {
        switch self {
        case .create:
            return true
        case .confirm(let keys):
            var condition = true
            var count = 0
            while condition && count < keys.count {
                if keys[count] == keysToConfirm[count] {
                    count += 1
                } else {
                    condition = false
                }
            }
            return condition
        }
    }
    
    @ViewBuilder func nextStep(keys: [String]) -> some View {
        switch self {
        case .create:
            SeedView(type: .confirm(keys: keys))
        case .confirm(let keys):
            HomePage()
        }
    }
}
