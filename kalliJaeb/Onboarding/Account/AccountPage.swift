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
   
    @EnvironmentObject var state: ViewState
    
    private let account: EthereumAccount
    @State var show: Bool = false
    @State var showHome: Bool = false
    struct Constants {
        static let detailKeys: [String] =  { ["Address", "Public Key"] }()
    }
    
    init(account: EthereumAccount) {
        self.account = account
    }
    
    private func fetchPrivateKey() {
        let storage = EthereumKeyLocalStorage.shared
        guard let privateKeyData = try? storage.loadPrivateKey(),
              let privateKey = String(data: privateKeyData, encoding: .utf8)
        else { return }
        print("(DEBUG) privateKeyData: ", privateKeyData)
        print("(DEBUG) private Key: ", privateKey)
    }
    
    private var accountBody: some View {
        VStack(alignment: .leading, spacing: 10) {
            ForEach(Constants.detailKeys, id:\.self) { key in
                if let value = account.details[key] {
                    value.medium(size: 15).text
                        .lineLimit(1)
                        .padding(.init(by: 10))
                        .borderCard(borderColor: .surfaceBackgroundInverse, radius: 12, borderWidth: 1.25)
                        .containerize(title: key.medium(size: 12), vPadding: 5, hPadding: 0, spacing: 0, alignment: .leading, style: .headCaption)
                }
            }
        }
        .padding(.init(by: 12))
        .slideIn(show: show, direction: .bottom)
    }
    
    var body: some View {
        ZStack {
            Color.surfaceBackground
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 20) {
                "You are set!".bold(size: 30)
                    .text
                Spacer().frame(height: 100, alignment: .center)
                
                ImageView(image: EmblemLogo.Polygon.image?.resized(size: .init(squared: .totalWidth.half.half)), contentMode: .fill)
                    .circleFrame(size: .init(squared: .totalWidth.half.half), background: .white.opacity(0.15), alignment: .center)
                    .fillWidth(alignment: .center)
                "Connect to Polygon!".bold(size: 20).text
                    .fillWidth(alignment: .center)
                Spacer()
                accountBody
                Spacer()
                Button(text: "Continue", config: .auto(background: .green)) {
                    withAnimation(.easeInOut) {
                        self.showHome = true
                    }
                }.fillWidth(alignment: .trailing)
                    .slideIn(show: show, direction: .bottom)
            }
            .padding(.init(vertical: 10, horizontal: 16))
            .fillWidth(alignment: .topLeading)
            
            NavLink(isActive: $showHome) {
                HomePage()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                withAnimation(.easeInOut) {
                    self.show = true
                }
            }
            fetchPrivateKey()
        }
    }
    
}
