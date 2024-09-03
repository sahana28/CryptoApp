//
//  StatisticsView.swift
//  CryptoApp
//
//  Created by Sahana  Rao on 20/08/24.
//

import SwiftUI

struct StatisticsView: View {
    
    let stats : StatisticsModel
    var body: some View {
        VStack(alignment: .leading, spacing: 4)
        {
            Text(stats.title)
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)
            Text(stats.value)
                .font(.headline)
                .foregroundStyle(Color.theme.accent)
            HStack(spacing: 4) {
                Image(systemName: "triangle.fill")
                    .font(.caption)
                    .rotationEffect(Angle(degrees: (stats.percentageChange ?? 0) >= 0 ? 0 : 180))
                    
                Text(stats.percentageChange?.asPercentString() ?? "")
                    .font(.caption)
                    .bold()
                    
            }
            .foregroundStyle((stats.percentageChange ?? 0) >= 0 ? Color.theme.green : Color.theme.red)
            .opacity(stats.percentageChange == nil ? 0.0 : 1.0)
            
            
        }
        
    }
}

#Preview {
    StatisticsView(stats: DeveloperInstance.instance.statsModel3)
}
