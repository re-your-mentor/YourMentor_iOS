//
//  LoginView.swift
//  YourMentor
//
//  Created by 이다경 on 12/25/24.
//

import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @StateObject var userData = UserJoinData()
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var isLoginSuccess = false
    
    @State private var userId: Int!
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    HStack {
                        Spacer()
                        NavigationLink(destination: Signup_Nickname()
                            .environmentObject(userData)) {
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
                        AuthTextField(text: $email, placeholder: "이메일을 입력해주세요.", imageName: "person", title: "Emaill")
                        AuthTextField(text: $password, placeholder: "비밀번호를 입력해주세요.", imageName: "lock", title: "Password")
                    }
                    VStack(spacing: 20) {
                        Button(action: {
                            login()
                        }) {
                            AuthButton(text: "Login")
                        }
                        Button(action: {
                            kakaologin()
                        }) {
                            KakaoButton()
                                .padding(.top)
                        }
                    }
                }
            }
            .background(Image("loginback"))
            .padding(.horizontal, 7)
            
            NavigationLink(destination: MainView(selectedTab: 0, userId: userId), isActive: $isLoginSuccess) {
                EmptyView()
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("오류"), message: Text(alertMessage), dismissButton: .default(Text("확인")))
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private func login() {
        AuthService.shared.login(
            email: email,
            password: password
        ) { result in
            switch result {
            case .success(let loginResponse):
                if let response = loginResponse as? LoginResponse {
                    print("\(response.message)\nUser\n ID: \(response.user.id)")
                    print(" Email: \(response.user.email)\n Nick: \(response.user.nick)\nToken: \(response.token)")
                    
                    self.userId = response.user.id
                    self.isLoginSuccess = true
                } else {
                    print("Failed to cast loginResponse to LoginResponse")
                }
            case .requestErr(let message):
                alertMessage = message as? String ?? "오류가 발생했습니다."
                showAlert = true
            case .pathErr:
                alertMessage = "잘못된 경로 요청입니다."
                showAlert = true
            case .serverErr:
                alertMessage = "서버 오류가 발생했습니다."
                showAlert = true
            case .networkFail:
                alertMessage = "네트워크 연결에 실패했습니다."
                showAlert = true
            }
        }
    }
    
    private func kakaologin() {
        AuthService.shared.kakaologin() { result in
            switch result {
            case .success:
                isLoginSuccess = true
            case .requestErr(let message):
                alertMessage = message as? String ?? "오류가 발생했습니다."
                showAlert = true
            case .pathErr:
                alertMessage = "잘못된 경로 요청입니다."
                showAlert = true
            case .serverErr:
                alertMessage = "서버 오류가 발생했습니다."
                showAlert = true
            case .networkFail:
                alertMessage = "네트워크 연결에 실패했습니다."
                showAlert = true
            }
        }
    }
}
