//
//  SignUpView.swift
//  UP
//
//  Created by youngjoo on 5/14/24.
//

import SwiftUI

struct SignUpView: View {
    
    @StateObject
    private var viewModel = SignUpViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            Text("회원가입")
                .font(.system(size: 50, weight: .bold, design: .default))
                .bold()
                .foregroundStyle(.point)
            
            Spacer()
            TextField("이메일을 입력하세요", text: $viewModel.email)
                .frame(height: 44)
                .padding(.leading, 10)
                .overlay {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(.point, lineWidth: 1)
                }
        } // VStack
        .padding(.leading, 30)
        .padding(.trailing, 30)
    }
}

#Preview {
    SignUpView()
}
