//
//  HomeStatsView.swift
//  CryptoApp
//
//  Created by Sahana  Rao on 20/08/24.
//

import SwiftUI

struct HomeStatsView: View {
    
    @EnvironmentObject private var viewModel : HomeViewModel
    @Binding var showPortfolio : Bool
    var body: some View {
        HStack {
            ForEach(viewModel.statistics) { stats in
                StatisticsView(stats: stats)
                    .frame(width: UIScreen.main.bounds.width / 3)
            }
        }
        
        .frame(width: UIScreen.main.bounds.width, alignment: (showPortfolio ? .trailing : .leading))
    }
}

#Preview {
    HomeStatsView(showPortfolio: .constant(true))
        .environmentObject(DeveloperInstance.instance.viewModel)
}
