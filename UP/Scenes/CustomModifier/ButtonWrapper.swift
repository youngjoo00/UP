//
//  WrapToButton.swift
//  UP
//
//  Created by youngjoo on 5/13/24.
//

import SwiftUI

private struct ButtonWrapper: ViewModifier {
    
    let action: () -> Void
    
    func body(content: Content) -> some View {
        Button(
            action: action,
            label: { content }
        )
    }
}

extension View {
    
    /// 버튼으로 래핑해서 반환하는 메서드
    func wrapToButton(action: @escaping () -> Void) -> some View {
        modifier(ButtonWrapper(action: action))
    }
}
