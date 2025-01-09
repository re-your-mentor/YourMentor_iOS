//
//  LoginView.swift
//  YourMentor
//
//  Created by 이다경 on 12/25/24.
//

import SwiftUI

struct LoginView: View {
    @State private var id: String = ""
    @State private var password: String = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    HStack {
                        Spacer()
                        NavigationLink(destination: SignupView()) {
                            ChangeButton(auth: "Sign Up")
                                .padding(.trailing)
                        }
                    }
                    Spacer()
                }
                VStack(spacing: 60) {
                    VStack(spacing: 15) {
                        Text("Log in")
                            .font(.system(size: 45, weight: .heavy))
                        Text("멘토들을 만나러 가도록 해봅시다!")
                            .fontWeight(.semibold)
                    }
                    VStack(spacing: 30) {
                        AuthTextField(text: $id, placeholder: "아이디를 입력해주세요.", imageName: "person", title: "ID")
                        AuthTextField(text: $password, placeholder: "비밀번호를 입력해주세요.", imageName: "lock", title: "Password")
                    }
                    VStack(spacing: 20) {
                        AuthButton(text: "Login")
                        Button {
                            
                        } label: {
                            Text("or continue with")
                                .font(.system(size: 17, weight: .medium))
                                .foregroundStyle(.gray)
                        }
                        Button {
                            
                        } label: {
                            KakaoButton()
                                .padding(.top)
                        }
                    }
                }
            }
            .background(Image("loginback"))
            .padding(.horizontal, 7)
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    LoginView()
}
