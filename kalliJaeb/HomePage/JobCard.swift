//
//  JobCard.swift
//  kalliJaeb
//
//  Created by Krishna Venkatramani on 04/12/2022.
//

import Foundation
import SUI
import SwiftUI

struct JobSkill {
    let name: String
    let logo: Logo
}

struct JobModel {
    let idx: Int
    let title: String
    let skills: [JobSkill]
}

extension JobModel {
    static func basicModel(idx: Int) -> JobModel {
        .init(idx: idx, title: "FrontEnd Engineering", skills: [
            .init(name: "Python", logo: .Python),
            .init(name: "JS", logo: .JS),
            .init(name: "Rust", logo: .Rust),
            .init(name: "Solidity", logo: .Solidity)
        ])
    }
}

struct JobCard: View {
    
    @State private var ratio: CGFloat = 0
//    @Binding private var isCurrent: Bool
    private var job: JobModel
    
    init(jobModel: JobModel) {
        self.job = jobModel
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
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .center, spacing: 10) {
                "FrontEnd Engineer".bold(size: 20).text
                Spacer()
            }
            self.skills(languages: Logo.allCases)
                .containerize(title: "Required Skils".medium(size: 15), vPadding: 8)
            Spacer()
        }
        .padding(.init(vertical: 20, horizontal: 10))
        .background(Color.surfaceBackground)
        .frame(height: .totalHeight.half, alignment: .center)
        .borderCard(borderColor: .surfaceBackgroundInverse, radius: 20, borderWidth: 1.25)
        .padding(.horizontal, 10)
        .frame(maxWidth: .infinity)
        .onAppear {
            self.ratio = .random(in: 0.3..<0.9)
        }
//        .onChange(of: isCurrent) { isCurrent in
//            if isCurrent {
//
//            }
//        }
    }
}
