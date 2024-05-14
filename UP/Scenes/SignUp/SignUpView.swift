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
            Spacer()
                .frame(height: 50)
            
            SignUpText()

            PointBorderTextField(placeholder: "이메일을 입력하세요", text: $viewModel.email)
            
            DescriptionText(text: viewModel.output.errorDescription)
            
            PointBackgroundButton(text: "다음") {
                viewModel.action(.nextButtonTap)
            }
            
            Spacer()
        } // VStack
        .padding(.leading, 30)
        .padding(.trailing, 30)
    }
}

#Preview {
    SignUpView()
}

struct SignUpText: View {
    var body: some View {
        Text("회원가입")
            .font(.system(size: 30, weight: .bold, design: .default))
            .bold()
            .foregroundStyle(.point)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct DescriptionText: View {
    
    let text: String
    
    var body: some View {
        Text(text)
            .font(.system(size: 15, weight: .medium))
            .foregroundStyle(.red)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}
