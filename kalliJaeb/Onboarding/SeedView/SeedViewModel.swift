//
//  SeedViewModel.swift
//  kalliJaeb
//
//  Created by Krishna Venkatramani on 03/12/2022.
//

import Foundation
import SwiftUI
import web3

class SeedViewModel: ObservableObject {
    
    struct Constants {

        static let seedPhrases: [String] = ["Hello", "Seed", "Phrase", "Test", "Create", "an",
                                            "Turtle", "Fox", "Elephant", "Tiger", "Lion", "Zebra","Snake", "Cat", "Dog","Bottle","Water"]
        static let padding: CGFloat = 10
        static let limit: Int = 2
    }
    
    private let pageType: SeedViewType
    @Published private(set) var show: Bool = false
    @Published private(set) var selectedPhrases: Array<String> = [] {
        didSet {
            if selectedPhrases.count == Constants.limit {
                withAnimation(.easeInOut) {
                    showButton = true
                }
            }
        }
    }
    @Published private(set) var showButton: Bool = false
    @Published var showNextPage: Bool = false
    @Published private(set) var shakes: CGFloat = 0
    private var account: EthereumAccount?
    
    init(pageType: SeedViewType) {
        self.pageType = pageType
    }
    
    //MARK: - LifeCycle
    
    func onAppear() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(50)) {
            withAnimation(.easeInOut(duration: 0.75)) {
                self.show = true
            }
        }
    }
    
    //MARK: - SelectedKeys Logic
    
    func addKeysToSelectedKeys(text: String) {
        if !self.selectedPhrases.contains(text) && self.selectedPhrases.count < 12 {
            self.selectedPhrases.append(text)
        }
    }
    
    func removeSelectedPhrase(text: String) {
        selectedPhrases.removeAll { $0 == text }
    }
    
    func isSelected(text: String) -> Bool {
        !self.selectedPhrases.contains(text)
    }
    
    //MARK: - MISC
    
    public var header : String{
        pageType.header
    }
    
    //MARK: - Actions
    private var confirmCondition:  Bool {
        switch pageType {
        case .create:
            return true
        case .confirm(let keys):
            var condition = true
            var count = 0
            while condition && count < keys.count {
                if keys[count] == selectedPhrases[count] {
                    count += 1
                } else {
                    condition = false
                }
            }
            return condition
        }
    }
        
    @ViewBuilder var nextStep: some View {
        switch pageType {
        case .create:
            SeedView(model: .init(pageType: .confirm(keys: selectedPhrases)))
        case .confirm:
            if let safeAccount = account {
                AccountDetailPage(account: safeAccount)
            } else {
                EmptyView()
            }
            
        }
    }
    
    func continueAction() {
        switch pageType {
        case .create:
            self.showNextPage = confirmCondition
        case .confirm:
            if !confirmCondition {
                withAnimation(.easeInOut(duration: 1)) {
                    self.shakes += 5
                }
            } else {
                createAccount()
            }
        }
    }
    
    //MARK: - AccountCreation
    
    private func createAccount() {
        guard let account = try? EthereumAccount.create(replacing: EthereumKeyLocalStorage(), keystorePassword: "USER_PASSWORD") else { return }
        print("(DEBUG) account : ", account.address)
        self.account = account
        self.showNextPage = true
    }
    
}
