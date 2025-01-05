//
//  OnBoardingView.swift
//  YourMentor
//
//  Created by 이다경 on 12/25/24.
//

import SwiftUI

struct SignupView: View {
    @State private var email: String = ""
    @State private var id: String = ""
    @State private var password: String = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    HStack {
                        Spacer()
                        NavigationLink(destination: LoginView()) {
                            ChangeButton(auth: "Log In")
                                .padding(.trailing)
                        }
                    }
                    Spacer()
                }
                VStack(spacing: 60) {
                    VStack(spacing: 15) {
                        Text("Sign up")
                            .font(.system(size: 45, weight: .heavy))
                        Text("당신의 멘토를 찾으러 오신것을 환영 합니다!")
                            .fontWeight(.semibold)
                    }
                    VStack(spacing: 30) {
                        AuthTextField(text: $email, placeholder: "이메일을 입력해주세요.", imageName: "envelope", title: "Email")
                        AuthTextField(text: $id, placeholder: "아이디를 입력해주세요.", imageName: "person", title: "ID")
                        AuthTextField(text: $password, placeholder: "비밀번호를 입력해주세요.", imageName: "lock", title: "Password")
                    }
                    VStack(spacing: 10) {
                        AuthButton(text: "Signup")
                        KakaoButton(auth: "Signup")
                    }
                }
            }
            .padding(.horizontal, 7)
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    SignupView()
}
