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
    let organization: String
    let description: String
    let skills: [JobSkill]
}

extension JobModel {
    static func basicModel(idx: Int) -> JobModel {
        .init(idx: idx, title: "FrontEnd Engineering", organization: "Meta", description: "You will be working in a exciting team and will be building the USE-LESS metaverse project website, to help sell our foolish dream that metaverse ACTUALLY is .. USeLEsS", skills: [
            .init(name: "Python", logo: .Python),
            .init(name: "JS", logo: .JS),
            .init(name: "Rust", logo: .Rust),
            .init(name: "Solidity", logo: .Solidity)
        ])
    }
    
    static func secondBasicModel(idx: Int) -> JobModel {
        .init(idx: idx, title: "Dev Ops", organization: "Devfolio", description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book", skills: [
            .init(name: "Python", logo: .Python),
            .init(name: "JS", logo: .JS),
            .init(name: "Rust", logo: .Rust),
            .init(name: "Solidity", logo: .Solidity)
        ])
    }
}

struct JobCard: View {
    
    @State private var ratio: CGFloat = 0
    @State private var matchRatio: CGFloat = 0
//    @Binding private var isCurrent: Bool
    private var job: JobModel
    
    init(jobModel: JobModel) {
        self.job = jobModel
    }
    
    private func requiredSkills(languages: [Logo]) -> some View {
        
        let size: CGFloat = 45
        
        let col: [GridItem] = [.init(.adaptive(minimum: size, maximum: size), spacing: 12, alignment: .leading)]
        
        return LazyVGrid(columns: col, alignment: .leading, spacing: 15) {
            ForEach(languages, id: \.self) {
                ImageView(image: $0.image?.resized(size: .init(squared: size.half)), contentMode: .fit)
                    .circleFrame(size: .init(squared: size), background: .white.opacity(0.15), alignment: .center)
                    .circularProgressBar(pct: ratio, lineWidth: 1.5, lineColor: .purple)
            }

        }
    }
    
    private func yourMatch() -> some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(Color.surfaceBackgroundInverse.opacity(0.1))
            .horizontalProgressBar(pct: matchRatio, lineColor: .green)
            .fillWidth(alignment: .leading)
            .padding(.horizontal, 8)
    }
    

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .center, spacing: 10) {
                VStack(alignment: .leading, spacing: 10) {
                    job.title.bold(size: 20).text
                    job.organization.medium(size: 12).text
                }
                Spacer()
            }
            
            job.description
                .medium(color: .gray, size: 15)
                .text
            
            self.requiredSkills(languages: Logo.allCases)
                .padding(.horizontal, 8)
                .containerize(title: "Required Skils".medium(size: 15), vPadding: 8, hPadding: 0)
            
            yourMatch()
                .frame(height: 12.5, alignment: .center)
                .containerize(title: "Match".medium(size: 15), vPadding: 8, hPadding: 0)
            Spacer()
            "Message".medium(size: 12).text.blobify(background: .blue, padding: 10, cornerRadius: 12)
        }
        .padding(.init(vertical: 20, horizontal: 20))
        .background(Color.surfaceBackground)
        .frame(height: .totalHeight.half, alignment: .center)
        .borderCard(borderColor: .surfaceBackgroundInverse, radius: 20, borderWidth: 1.25)
        .padding(.horizontal, 10)
        .frame(maxWidth: .infinity)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                withAnimation(.easeInOut) {
                    self.ratio = .random(in: 0.3..<0.9)
                    self.matchRatio = .random(in: 0.3..<0.9)
                }
            }
        }
    }
}
