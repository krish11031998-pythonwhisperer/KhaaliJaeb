//
//  AccountPage.swift
//  kalliJaeb
//
//  Created by Krishna Venkatramani on 04/12/2022.
//

import Foundation
import SwiftUI
import SUI
import web3

fileprivate extension EthereumAccount {
    
    var details: [String: String] {
        ["Address": address.value, "Public Key": publicKey]
    }
    
}

struct AccountDetailPage: View {
    
    private let account: EthereumAccount
    @State var show: Bool = false
    struct Constants {
        static let detailKeys: [String] =  { ["Address", "Public Key"] }()
    }
    
    init(account: EthereumAccount) {
        self.account = account
    }
    
    private var accountBody: some View {
        VStack(alignment: .leading, spacing: 10) {
            ForEach(Constants.detailKeys, id:\.self) { key in
                if let value = account.details[key] {
                    HStack(alignment: .top) {
                        key.medium(color: .gray, size: 15).text
                        Spacer()
                        value.medium(size: 15).text
                            .frame(maxWidth: .totalWidth.half)
                    }
                    Divider()
                }
            }
        }
        .padding(.init(by: 12))
        .borderCard(borderColor: .surfaceBackgroundInverse, radius: 16, borderWidth: 1.5)
        .slideIn(show: show, direction: .bottom)
    }
    
    var body: some View {
        ZStack {
            Color.surfaceBackground
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 20) {
                "Account Page".bold(size: 30)
                    .text
                Spacer()
                accountBody
                Spacer()
            }
            .padding(.init(vertical: 10, horizontal: 16))
            .fillWidth(alignment: .topLeading)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                withAnimation(.easeInOut) {
                    self.show = true
                }
            }
        }
    }
    
}
