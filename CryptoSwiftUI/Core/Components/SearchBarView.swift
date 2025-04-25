//
//  SearchBarView.swift
//  CryptoSwiftUI
//
//  Created by Phuc Huu Do on 23/4/25.
//

import SwiftUI

struct SearchBarView: View {
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(Color.theme.secondaryText)
        }
    }
}

#Preview {
    SearchBarView()
}
