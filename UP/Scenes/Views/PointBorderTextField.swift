//
//  PointBorderTextField.swift
//  UP
//
//  Created by youngjoo on 5/14/24.
//

import SwiftUI

struct PointBorderTextField: View {
    
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        TextField(placeholder, text: $text)
            .frame(height: 44)
            .padding(.leading, 10)
            .overlay {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(.point, lineWidth: 1)
            }
    }
}
