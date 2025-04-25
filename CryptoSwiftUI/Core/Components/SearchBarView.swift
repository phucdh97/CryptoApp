//
//  SearchBarView.swift
//  CryptoSwiftUI
//
//  Created by Phuc Huu Do on 23/4/25.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(
                    searchText.isEmpty ?
                    Color.theme.secondaryText : Color.theme.accent
                )
            
            TextField("Search by name or symbol", text: $searchText)
                .foregroundStyle(Color.theme.accent)
                .autocorrectionDisabled()
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x: 10)
                        .foregroundStyle(Color.theme.accent)
                        .opacity(searchText.isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            searchText = ""
                        }
                    , alignment: .trailing
                )
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.theme.background)
                .shadow(color: Color.theme.accent.opacity(0.15), radius:10,  x: 10, y: 10)
        )
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    Group {
        SearchBarView(searchText: .constant(""))
            .preferredColorScheme(.light)
        
//        SearchBarView()
//            .preferredColorScheme(.light)
    }
}

//struct SearchBarView_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            SearchBarView()
//                .previewLayout(.sizeThatFits)
//                .preferredColorScheme(.dark)
//            
//            SearchBarView()
//                .previewLayout(.sizeThatFits)
//                .preferredColorScheme(.light)
//        }
//    }
//}
