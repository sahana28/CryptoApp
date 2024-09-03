//
//  SearchBarView.swift
//  CryptoApp
//
//  Created by Sahana  Rao on 20/08/24.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(searchText.isEmpty ? Color.theme.secondaryText : Color.theme.accent )
            TextField("Search by name or symbol....", text: $searchText)
                .foregroundStyle(Color.theme.accent)
                .autocorrectionDisabled()
                .overlay(alignment: .trailing) {
                    
                        Image(systemName: "xmark.circle.fill")
                        // Added to increase the tappable area of x icon
                            .padding()
                            .offset(x:10)
                            .foregroundStyle(Color.theme.accent)
                            .opacity(searchText.isEmpty ? 0.0 : 1.0)
                            .onTapGesture {
                                UIApplication.shared.endEditing()
                                searchText = ""
                        }
                        
                    
                }
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25.0)
                .fill(Color.theme.background)
                .shadow(color:Color.theme.accent.opacity(0.15) ,radius: 10, x: 0, y: 0)
            
        )
        .padding()
        
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    
    SearchBarView(searchText: .constant(""))
            .preferredColorScheme(.dark)
    
}

//struct SearchBarView_Previews: PreviewProvider {
//        static var previews: some View {
//            SearchBarView()
//                .previewLayout(.sizeThatFits)
//                .preferredColorScheme(.dark)
//        }
//}
