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
            
            // 1. 이메일 입력 후 다음 버튼 누르고 -> 중복확인 성공하면, passwordTextField hidden 해제, descriptionText 아래로 내려감
            
            // 2. 패스워드 입력 후 다음 버튼 누르면 -> 유효성 검증 -> 검증 성공하면, NicknameTextField Hidden 해제, emailTextField 아래로 내려감
            
            // 3. 닉네임 입력 후 다음 버튼 누르면 -> 유효성 검증 -> 검증 성공하면, 회원가입 네트워크 통신 .Post
            
            // 4. 회원가입 성공 시 회원가입 성공 화면 Push 되면서 3초 후 메인 화면
            PointBorderTextField(placeholder: "닉네임을 입력하세요", text: $viewModel.nickname)
            PointBorderTextField(placeholder: "패스워드를 입력하세요", text: $viewModel.password)
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
