//
//  JobFancySwipeView.swift
//  kalliJaeb
//
//  Created by Krishna Venkatramani on 03/12/2022.
//

import Foundation
import SwiftUI
import SUI

struct JobFancySwipeView: View {
    
    @State var size: CGSize = .zero
    @State var currentIdx: Int = 0
    @State var xOff: CGFloat = 0
    @State var yOff: CGFloat = 0
    private let count: Int = 10
    @State var ratio: CGFloat = 0
    struct Constants {
        static let numbers: Int = 10
        static let hLimit: CGFloat = 50
    }
    
    @ViewBuilder func cardBuilder(number: Int,color: Color) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .center, spacing: 10) {
                "FrontEnd Engineer".bold(size: 20).text
                Spacer()
            }
            Spacer()
            if currentIdx == number {
                
                self.skills(languages: Logo.allCases)
            }
            
            Spacer()
        }
        .padding(.init(vertical: 20, horizontal: 10))
        .background(color)
        .frame(height: .totalHeight.half, alignment: .center)
        .borderCard(borderColor: .surfaceBackgroundInverse, radius: 20, borderWidth: 1.25)
        .padding(.horizontal, 10)
        .frame(maxWidth: .infinity)
    }
    
    
    private func skills(languages: [Logo]) -> some View {
        
        let size: CGFloat = 60
        
        let col: [GridItem] = [.init(.adaptive(minimum: size, maximum: size), spacing: 12, alignment: .leading)]
        
        return LazyVGrid(columns: col, alignment: .leading, spacing: 10) {
            ForEach(languages, id: \.self) {
                ImageView(image: $0.image?.resized(size: .init(squared: size.half)), contentMode: .fit)
                    .circleFrame(size: .init(squared: size), background: .white.opacity(0.15), alignment: .center)
                    .circularProgressBar(pct: ratio, lineWidth: 3, lineColor: .purple)
            }

        }
    }
    
    private func onChanged(value: DragGesture.Value) {
        asyncMainAnimation {
            let width = value.translation.width
            let height = value.translation.height
            self.xOff = width
            if abs(height) <= Constants.hLimit {
                self.yOff = height
            }
            
        }
    }
    
    private func onEnded(value:DragGesture.Value) {
        asyncMainAnimation {
            
            if abs(xOff) > 50 {
                if xOff < 0 {
                    self.currentIdx = self.currentIdx > 0 ? self.currentIdx - 1 : self.currentIdx
                } else if xOff > 0{
                    self.currentIdx = self.currentIdx < count ? self.currentIdx + 1 : self.currentIdx
                }
            }
            
            self.xOff = 0
            self.yOff = 0
        }
    }
    
    func columnBuilder(colsStr: [String], isSource: Bool, handler: @escaping (String) -> Void) -> some View {
        HStack(alignment: .center, spacing: 5) {
            ForEach(colsStr, id: \.self) { text in
                createSeedPhraseBlob(phrase: text)
                    .buttonify {
                        handler(text)
                    }
            }
        }
    }
    
    func createSeedPhraseBlob(phrase: String) -> some View {
        phrase
            .styled(font: .regular, color: .textColor, size: 20)
            .text
            .blobify(background: .surfaceBackgroundInverse.opacity(0.12), padding: 7.5, cornerRadius: 7.5)
    }
    
    var dragGesture: some Gesture {
        DragGesture().onChanged(onChanged(value:)).onEnded(onEnded(value:))
    }
    
    var body: some View {
        ZStack {
            ForEach(0..<Constants.numbers) {
                if $0 >= currentIdx &&  $0 <= currentIdx + 2 {
                    cardBuilder(number: $0,color: .red)
                        .offset(x: $0 == currentIdx ? xOff : 0,
                                y: $0 == currentIdx ? yOff : CGFloat($0 - currentIdx) * 10)
                        .zIndex(Double(currentIdx - $0))
                        .gesture($0 == currentIdx ? dragGesture : nil)
                    
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                withAnimation {
                    self.ratio = 0.5
                }
            }
        }
    }
    
}
