//
//  PointBackgroundButton.swift
//  UP
//
//  Created by youngjoo on 5/14/24.
//

import SwiftUI

struct PointBackgroundButton: View {
    
    let text: String
    
    var body: some View {
        Text(text)
            .foregroundStyle(.white)
            .bold()
            .frame(maxWidth: .infinity)
            .frame(height: 44)
            .background(.point)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .wrapToButton {
                print("login")
            }
            
    }
}
