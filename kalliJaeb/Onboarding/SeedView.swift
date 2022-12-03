//
//  SeedView.swift
//  kalliJaeb
//
//  Created by Krishna Venkatramani on 03/12/2022.
//

import Foundation
import SwiftUI
import SUI

extension String {
    
    func size(usingFont font: UIFont) -> CGSize {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size
    }
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        size(usingFont: font).width
    }
    
    func heightOfString(usingFont font: UIFont) -> CGFloat {
        size(usingFont: font).height
    }
}

extension Array where Self.Element == String {
    func multiDim(totalWidth: CGFloat) -> [[String]] {
        var rows: [[String]] = []
        var remainingWidth = totalWidth
        var cols: [String] = []
        
        forEach {
            let width = $0.widthOfString(usingFont: CustomFonts.regular.fontBuilder(size: 20) ?? .systemFont(ofSize: 20)) * 2
            print("(DEBUG) width (for \($0) : \(width) -> \(remainingWidth)")
            
            if width > remainingWidth {
                rows.append(cols)
                cols.removeAll()
                remainingWidth = totalWidth
            } else {
                remainingWidth -= width
            }
            cols.append($0)
            print("(DEBUG) cols : ", cols)
        }
        
        if !cols.isEmpty {
            rows.append(cols)
        }
        
        return rows
    }
}

struct SeedView: View {
    
    @State var show: Bool = false
    @State var selectedPhrases: Array<String> = []
    @State var showButton: Bool = false
    @Namespace var animation
    
    struct Constants {
        static let heroHeader: String = "Create an Seed Phrase"
        static let seedPhrases: [String] = ["Hello", "Seed", "Phrase", "Test", "Create", "an",
                                            "Turtle", "Fox", "Elephant", "Tiger", "Lion", "Zebra"]
        static let padding: CGFloat = 10
    }
    
    private func onAppear() {
        withAnimation(.easeInOut) {
            self.show.toggle()
        }
    }
    
    
    func createSeedPhraseBlob(phrase: String) -> some View {
        phrase
            .styled(font: .regular, color: .purple, size: 20)
            .text
            .blobify(background: .purple.opacity(0.12), padding: 7.5, cornerRadius: 7.5)
            .buttonify {
                if !self.selectedPhrases.contains(phrase) {
                    self.selectedPhrases.append(phrase)
                }
            }
    }
    
    var grid: some View {
        
        let rows = Constants.seedPhrases.multiDim(totalWidth: UIScreen.main.bounds.width - 2 * Constants.padding)
    
       return VStack(alignment: .leading, spacing: 10) {
           ForEach(rows, id: \.self) { row in
               columnBuilder(colsStr: row, isSource: false)
            }
        }.frame(maxWidth: .infinity, alignment: .leading)
    }
    
    var selectedGrid: some View {
        let rows = selectedPhrases.multiDim(totalWidth: UIScreen.main.bounds.width - 2 * Constants.padding)
    
       return VStack(alignment: .leading, spacing: 10) {
           ForEach(rows, id: \.self) { row in
               columnBuilder(colsStr: row, isSource: true)
                   .hidden()
            }
       }.frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func columnBuilder(colsStr: [String], isSource: Bool) -> some View {
        HStack(alignment: .center, spacing: 5) {
            ForEach(colsStr, id: \.self) {
                createSeedPhraseBlob(phrase: $0)
                    .matchedGeometryEffect(id: $0, in: animation, isSource: isSource)
            }
        }
    }
    
    var body: some View {
        ZStack {
            Color.surfaceBackground
                .ignoresSafeArea()
            
            VStack {
                Constants.heroHeader.bold(size: 30)
                    .text
                    .padding(.init(vertical: 5, horizontal: 10))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .slideIn(show: show, direction: .top)
                
                Spacer()
                
                grid
                
                Spacer().frame(height: 35, alignment: .center)
                
                selectedGrid
                Spacer()
                
            }.padding(.init(by: Constants.padding))
            
            Button(text: "Continue", config: .auto(background: .green)) {
                print("(DEBUG) Clicked on Continue!")
            }
            .slideIn(show: showButton, direction: .bottom)
            .padding(.init(by: 10))
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
        }
        .onAppear(perform: onAppear)
        .onChange(of: selectedPhrases.count) { count in
            if count == 2 {
                showButton = true
            }
        }
    }
    
}


fileprivate struct Preview: PreviewProvider {
    
    static var previews: some View {
        SeedView()
    }
}
