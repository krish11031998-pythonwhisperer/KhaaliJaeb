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
        static let padding: CGFloat = 16
        static let limit: Int = 2
    }
    
    @StateObject var model: SeedViewModel
    @Namespace var animation
    
    init(model: SeedViewModel) {
        self._model = .init(wrappedValue: model)
    }
    
    func createSeedPhraseBlob(phrase: String) -> some View {
        let size = phrase.size(usingFont: CustomFonts.regular.fontBuilder(size: 20) ?? .systemFont(ofSize: 20))
        return phrase
            .styled(font: .medium, color: .purple, size: 14)
            .text
            .blobify(background: .purple.opacity(0.12), padding: 7.5, cornerRadius: size.minDim.half)
    }
    
    var grid: some View {
        
        let rows = Constants.seedPhrases.multiDim(totalWidth: UIScreen.main.bounds.width - 2 * Constants.padding)
    
       return VStack(alignment: .leading, spacing: 10) {
           ForEach(rows, id: \.self) { row in
               columnBuilder(colsStr: row, isSource: true) { text in
                   self.model.addKeysToSelectedKeys(text: text)
               }
            }
        }.frame(maxWidth: .infinity, alignment: .leading)
    }
    
    var selectedGrid: some View {
        let rows = model.selectedPhrases.multiDim(totalWidth: UIScreen.main.bounds.width - 2 * Constants.padding)
    
       return VStack(alignment: .leading, spacing: 10) {
           ForEach(rows, id: \.self) { row in
               columnBuilder(colsStr: row, isSource: false) { text in
                   self.model.removeSelectedPhrase(text: text)
               }
            }
       }
       .padding(Constants.padding)
       .frame(maxWidth: .infinity, minHeight: 100, alignment: .topLeading)
       .background(Color.purple.opacity(0.15).blur(radius: 10))
        .borderCard(borderColor: .surfaceBackgroundInverse, radius: 12, borderWidth: 1)
        .containerize(title: "Selected Keys".medium(size: 15), subTitle: "\(model.selectedPhrases.count)/\(Constants.limit)".medium(size: 15), vPadding: 5, hPadding: 5, alignment: .leading, style: .headCaption)
        .shakeView(shakes: model.shakes)
        
    }
    
    func columnBuilder(colsStr: [String], isSource: Bool, handler: @escaping (String) -> Void) -> some View {
        HStack(alignment: .center, spacing: 5) {
            ForEach(colsStr, id: \.self) { text in
                createSeedPhraseBlob(phrase: text)
                    .matchedGeometryEffect(id: text, in: animation)
                    .isHidden(isSource ? self.model.isSelected(text: text) : true)
                    .buttonify {
                        handler(text)
                    }
            }
        }
    }
    
    var mainBody: some View {
        VStack {
            model.header.bold(size: 30)
                .text
                .padding(.init(vertical: 5))
                .frame(maxWidth: .infinity, alignment: .leading)
                .slideIn(show: model.show, direction: .bottom)
            
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

            Button(text: "Continue", config: .auto(background: .green), handler: model.continueAction)
            .slideIn(show: model.showButton, direction: .bottom)
            .padding(.init(by: 10))
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)

            NavLink(isActive: $model.showNextPage) {
                model.nextStep
            }
        }
        .onAppear(perform: model.onAppear)
    }
    
}


fileprivate struct Preview: PreviewProvider {
    
    static var previews: some View {
        NavigationView {
            SeedView(model: .init(pageType: .create))
        }
    }
}
