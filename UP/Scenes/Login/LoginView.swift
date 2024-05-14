//
//  LoginView.swift
//  UP
//
//  Created by youngjoo on 5/14/24.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject
    private var viewModel = LoginViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                LoginText()
                
                PointBorderTextField(placeholder: "이메일을 입력하세요", text: $viewModel.email)
                PointBorderTextField(placeholder: "패스워드를 입력하세요", text: $viewModel.password)
                
                PointBackgroundButton(text: "로그인")
                
                SignUpButton(text: "회원가입") {
                    viewModel.isShowingSignUp = true
                }

                Spacer()
                    .frame(height: 100)
            } // VStack
            .padding(.horizontal, 30)
            .navigationDestination(isPresented: $viewModel.isShowingSignUp) {
                SignUpView()
            }
        } // NavigationStack
       
    }
}

#Preview {
    LoginView()
}

struct LoginText: View {
    var body: some View {
        Text("Login")
            .font(.system(size: 50, weight: .bold, design: .default))
            .bold()
            .foregroundStyle(.point)
    }
}

struct SignUpButton: View {
    
    let text: String
    let action: () -> Void
    
    var body: some View {
        HStack {
            Spacer()
            Text(text)
                .foregroundStyle(.white)
                .bold()
                .frame(width: 100, height: 44)
                .background(.point)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .wrapToButton {
                    action()
                }
        }
    }
}
