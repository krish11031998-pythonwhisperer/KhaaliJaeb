//
//  Button.swift
//  kalliJaeb
//
//  Created by Krishna Venkatramani on 03/12/2022.
//

import Foundation
import SwiftUI
import SUI

struct Button: View {

    let text: String
    let handler: () -> Void
    let config: ButtonType
    
    init(text: String,
         config: ButtonType = .auto(background: .clear),
         handler: @escaping () -> Void) {
        self.text = text
        self.handler = handler
        self.config = config
    }
    
    var body: some View {
        text.medium(color: .textColor, size: 20)
            .text
            .addButtonConfig(config: config)
            .buttonify(animation: .easeInOut, action: handler)
    }
}
