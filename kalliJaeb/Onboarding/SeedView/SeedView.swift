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
            let width = $0.widthOfString(usingFont: CustomFonts.regular.fontBuilder(size: 20) ?? .systemFont(ofSize: 20)) * 1.75
            if width > remainingWidth {
                rows.append(cols)
                cols.removeAll()
                remainingWidth = totalWidth
            } else {
                remainingWidth -= width
            }
            cols.append($0)
        }
        
        if !cols.isEmpty {
            rows.append(cols)
        }
        
        return rows
    }
}

struct SeedView: View {
    
    struct Constants {

        static let seedPhrases: [String] = ["Hello", "Seed", "Phrase", "Test", "Create", "an",
                                            "Turtle", "Fox", "Elephant", "Tiger", "Lion", "Zebra","Snake", "Cat", "Dog","Bottle","Water"]
        static let padding: CGFloat = 10
        static let limit: Int = 2
    }
    
    
    @State var show: Bool = false
    @State var selectedPhrases: Array<String> = []
    @State var showButton: Bool = false
    @State var showNextPage: Bool = false
    @State var shakes: CGFloat = 0
    @Namespace var animation
    var type: SeedViewType
    
    init(type: SeedViewType) {
        self.type = type
    }
    
   
    private func onAppear() {
        withAnimation(.easeInOut) {
            self.show = true
        }
    }
    
    
    func createSeedPhraseBlob(phrase: String) -> some View {
        phrase
            .styled(font: .regular, color: .purple, size: 20)
            .text
            .blobify(background: .purple.opacity(0.12), padding: 7.5, cornerRadius: 7.5)
    }
    
    var grid: some View {
        
        let rows = Constants.seedPhrases.multiDim(totalWidth: UIScreen.main.bounds.width - 2 * Constants.padding)
    
       return VStack(alignment: .leading, spacing: 10) {
           ForEach(rows, id: \.self) { row in
               columnBuilder(colsStr: row, isSource: true) { text in
                   if !self.selectedPhrases.contains(text) && self.selectedPhrases.count < 12 {
                       self.selectedPhrases.append(text)
                   }
               }
            }
        }.frame(maxWidth: .infinity, alignment: .leading)
    }
    
    var selectedGrid: some View {
        let rows = selectedPhrases.multiDim(totalWidth: UIScreen.main.bounds.width - 2 * Constants.padding)
    
       return VStack(alignment: .leading, spacing: 10) {
           ForEach(rows, id: \.self) { row in
               columnBuilder(colsStr: row, isSource: false) { text in
                   self.selectedPhrases.removeAll { $0 == text }
               }
            }
       }
       .padding(Constants.padding)
       .frame(maxWidth: .infinity, minHeight: 100, alignment: .topLeading)
       .background(Color.purple.opacity(0.15).blur(radius: 10))
        .borderCard(borderColor: .surfaceBackgroundInverse, radius: 12, borderWidth: 1)
        .containerize(title: "Selected Keys".medium(size: 15), subTitle: "\(selectedPhrases.count)/\(Constants.limit)".medium(size: 15), vPadding: 5, hPadding: 5, alignment: .leading, style: .headCaption)
        .shakeView(shakes: shakes)
        
    }
    
    func columnBuilder(colsStr: [String], isSource: Bool, handler: @escaping (String) -> Void) -> some View {
        HStack(alignment: .center, spacing: 5) {
            ForEach(colsStr, id: \.self) { text in
                createSeedPhraseBlob(phrase: text)
                    .matchedGeometryEffect(id: text, in: animation)
                    .isHidden(isSource ? !self.selectedPhrases.contains(text) : true)
                    .buttonify {
                        handler(text)
                    }
            }
        }
    }
    
    var mainBody: some View {
        VStack {
            type.header.bold(size: 30)
                .text
                .padding(.init(vertical: 5, horizontal: 10))
                .frame(maxWidth: .infinity, alignment: .leading)
                .slideIn(show: show, direction: .top)
            
            Spacer()
            
            grid
            
            Spacer().frame(height: 35, alignment: .center)

            selectedGrid

            Spacer()
//
        }.padding(.init(by: Constants.padding))
    }
    
    var body: some View {
        ZStack {
            Color.surfaceBackground
                .ignoresSafeArea()

            mainBody

            Button(text: "Continue", config: .auto(background: .green)) {
                let val = type.confirmCondition(keysToConfirm: selectedPhrases)
                showNextPage = val
                if !val {
                    withAnimation(.easeInOut(duration: 1)) {
                        self.shakes += 5
                    }
                }
                
            }
            .slideIn(show: showButton, direction: .bottom)
            .padding(.init(by: 10))
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)

            NavLink(isActive: $showNextPage) {
                type.nextStep(keys: selectedPhrases)
            }
        }
        .onAppear(perform: onAppear)
        .onChange(of: selectedPhrases.count) { count in
            if count == Constants.limit {
                showButton = true
            }
        }
    }
    
}


fileprivate struct Preview: PreviewProvider {
    
    static var previews: some View {
        NavigationView {
            SeedView(type: .create)
        }
    }
}
