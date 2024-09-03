//
//  DetailView.swift
//  CryptoApp
//
//  Created by Sahana  Rao on 23/08/24.
//

import SwiftUI


struct DetailLoadingView : View {
    @Binding var coin : CoinModel?
    
    var body: some View {
        ZStack {
            if let coin = coin {
                DetailView(coin: coin)
            }
        }
    }
}

struct DetailView: View {
    @StateObject var viewModel : DetailViewModel
    @State private var showFullDescription : Bool = false
    private let columns : [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    private let spacing : CGFloat = 30
    init(coin: CoinModel) {
        _viewModel = StateObject(wrappedValue: DetailViewModel(coin: coin))
        print("Initializing detail view for \(coin.name)")
    }
    var body: some View {
        ScrollView {
            VStack {
                ChartView(coin: viewModel.coin)
                    .padding(.vertical)
                VStack(spacing: 20, content: {
                    overView
                    Divider()
                    descriptionSection
                    overviewGrid
                    additionalDetails
                    Divider()
                    additionalGrid
                    websiteSection

                })
                .padding()
            }
        }
        .background(
            Color.theme.background
                .ignoresSafeArea()
         )
        .navigationTitle(viewModel.coin.name)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                navigationBarTrailingItems
            }
        }
        
    }
    
}

#Preview {
    NavigationView {
        DetailView(coin: DeveloperInstance.instance.coin)
    }
    
}

extension DetailView {
    private var overView : some View {
            Text("Overview")
                .font(.title)
                .bold()
                .foregroundStyle(Color.theme.accent)
                .frame(maxWidth: .infinity, alignment: .leading)
      }
    
    private var additionalDetails : some View {
        Text("Additional Details")
            .font(.title)
            .bold()
            .foregroundStyle(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var additionalGrid : some View {
        LazyVGrid(columns: columns,
                  alignment: .leading,
                  spacing: spacing,
                  pinnedViews: [],
                  content: {
            ForEach(viewModel.additionalStatistics) { stats in
                StatisticsView(stats: StatisticsModel(title: stats.title, value: stats.value,percentageChange: stats.percentageChange))
            }
        })
    }
    
    private var descriptionSection : some View {
        ZStack {
            if let coinDescription = viewModel.coinDescription, !coinDescription.isEmpty {
                VStack(alignment: .leading) {
                    Text(coinDescription)
                        .lineLimit(showFullDescription ? nil : 3)
                    
                        .font(.callout)
                        .foregroundStyle(Color.theme.secondaryText)
                    
                    Button(action: {
                      //  withAnimation(.easeIn) {
                            showFullDescription.toggle()
                       // }
                    }, label: {
                        Text(showFullDescription ? "Read less" : "Read more..")
                            .font(.caption)
                            .bold()
                            .padding(.vertical, 4)
                    })
                    .accentColor(.blue)
                }
                .frame(maxWidth: .infinity,alignment: .leading )
                
            }
        }
    }
    
    private var navigationBarTrailingItems : some View {
        HStack {
            Text(viewModel.coin.symbol.uppercased())
            .font(.headline)
            .foregroundStyle(Color.theme.secondaryText)
            CoinImageView(coin: viewModel.coin)
                .frame(width: 25, height: 25)
        }
    }
    
    private var overviewGrid : some View {
        LazyVGrid(columns: columns,
                  alignment: .leading,
                  spacing: spacing,
                  pinnedViews: [],
                  content: {
            ForEach(viewModel.overviewStatistics) { stats in
                StatisticsView(stats: StatisticsModel(title: stats.title, value: stats.value,percentageChange: stats.percentageChange))
            }
        })
    }
    
    private var websiteSection : some View {
        VStack(alignment: .leading, spacing: 20) {
            if let websiteString = viewModel.websiteURL, let url = URL(string: websiteString) {
                Link("Website", destination: url)
            }
            
            if let redditString = viewModel.redditURL, let url = URL(string: redditString) {
                Link("Reddit", destination: url)
            }
        }
        .accentColor(.blue)
        .frame(maxWidth: .infinity, alignment: .leading)
        
    }
}
