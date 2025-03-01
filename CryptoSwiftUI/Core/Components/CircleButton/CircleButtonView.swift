//
//  CircleButtonView.swift
//  CryptoSwiftUI
//
//  Created by Phuc Huu Do on 21/2/25.
//

import SwiftUI

struct CircleButtonView: View {
    
    let iconName: String
    
    var body: some View {
        Image(systemName: iconName)
            .font(.headline)
            .foregroundStyle(Color.theme.accent)
            .frame(width: 50, height: 50)
            .background(
                Circle()
                    .foregroundStyle(Color.theme.background)
            )
            .shadow(color: Color.theme.accent.opacity(0.25),
                    radius: 10,
                    x: 0,
                    y: 0
            )
            .padding(20)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    Group {
        CircleButtonView(iconName: "info")
        
        CircleButtonView(iconName: "plus")
            .colorScheme(.dark)
    }
}

//struct CircleButtonView_Previews: PreviewProvider {
//    static var previews: some View {
//        CircleButtonView()
//            .previewLayout(.sizeThatFits)
//    }
//}
