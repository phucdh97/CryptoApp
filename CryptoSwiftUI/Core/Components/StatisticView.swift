//
//  StatisticView.swift
//  CryptoSwiftUI
//
//  Created by Do Huu Phuc on 27/4/25.
//

import SwiftUI

struct StatisticView: View {
    
    let stat: StatisticModel
    
    var body: some View {
        let isUp = stat.percentageChange ?? 0 >= 0
        VStack(alignment: .leading, spacing: 4) {
            Text(stat.title)
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)
            Text(stat.value)
                .font(.headline)
                .foregroundStyle(Color.theme.accent)
            HStack {
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(
                        Angle(degrees: isUp ? 0.0 : 180.0)
                    )
                Text(stat.percentageChange?.asPercentString() ?? "")
                    .font(.caption)
                    .bold()
            }
            .foregroundStyle(isUp ? Color.theme.green : Color.theme.red)
            .opacity(stat.percentageChange == nil ? 0.0 : 1.0)
        }
    }
}

#Preview {
    StatisticView(stat: DeveloperPreview.instance.stat1)
    
    StatisticView(stat: DeveloperPreview.instance.stat2)
    
    StatisticView(stat: DeveloperPreview.instance.stat3)
}
