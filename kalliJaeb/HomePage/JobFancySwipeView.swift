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
                if xOff > 0{
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
            VStack(alignment: .center) {
                "You've swiped through all the job listing".medium(size: 12).text
                "pls pay 1 ETH to rewind".bold(size: 11).text
                    .blobify(background: .green, padding: 10, cornerRadius: 12)
            }.frame(maxWidth: .infinity, alignment: .center)
            ForEach(0..<Constants.numbers) {
                if $0 >= currentIdx &&  $0 <= currentIdx + 2 {
                    JobCard(jobModel: $0%2 == 0 ? .secondBasicModel(idx: $0) : .basicModel(idx: $0))
                        .scaleEffect(1 - CGFloat($0 - currentIdx) * 0.075)
                        .offset(x: $0 == currentIdx ? xOff : 0,
                                y: $0 == currentIdx ? yOff : CGFloat($0 - currentIdx) * 25)
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
