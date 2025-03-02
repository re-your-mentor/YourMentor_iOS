//
//  Signup_Password.swift
//  YourMentor
//
//  Created by 이다경 on 1/9/25.
//

import SwiftUI

struct Signup_Password: View {
    @State private var passcheck: String = ""
    @State private var showpass = false
    @State private var showpasscheck = false
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var userData: UserJoinData
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var isSignupSuccess = false
    
    @State private var userId: Int?
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 45) {
                Image("key")
                Text("비밀번호를 입력해주세요!")
                    .font(.system(size: 21, weight: .semibold))
                HStack {
                    Group {
                        if showpass {
                            TextField("비밀번호를 작성해주세요!", text: $userData.password)
                                .autocapitalization(.none)
                                .submitLabel(.done)
                        } else {
                            SecureField("비밀번호를 작성해주세요!", text: $userData.password)
                                .submitLabel(.done)
                        }
                    }
                    .autocapitalization(.none)
                    .frame(minHeight: 20)
                    
                    Button(action: {
                        self.showpass.toggle()
                    }, label: {
                        Image(systemName: showpass ? "eye" : "eye.slash")
                            .foregroundColor(.gray)
                    })
                }
                .font(.system(size: 14))
                .padding(.leading)
                .padding(.bottom, 7)
                .overlay(
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray),
                    alignment: .bottom
                )
                .padding(.horizontal, 50)
                ZStack {
                    if !userData.password.isEmpty {
                        HStack {
                            Group {
                                if showpasscheck {
                                    TextField("비밀번호를 확인해주세요!", text: $passcheck)
                                        .autocapitalization(.none)
                                        .submitLabel(.done)
                                } else {
                                    SecureField("비밀번호를 확인해주세요!", text: $passcheck)
                                        .submitLabel(.done)
                                }
                            }
                            .autocapitalization(.none)
                            .frame(minHeight: 20)
                            
                            Button(action: {
                                self.showpasscheck.toggle()
                            }, label: {
                                Image(systemName: showpasscheck ? "eye" : "eye.slash")
                                    .foregroundColor(.gray)
                            })
                        }
                        .font(.system(size: 14))
                        .padding(.leading)
                        .padding(.bottom, 7)
                        .overlay(
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(.gray),
                            alignment: .bottom
                        )
                        .padding(.horizontal, 50)
                    } else {
                        Text("")
                            .padding(.horizontal, 15)
                            .padding(.vertical, 7)
                    }
                }
                .frame(height: 20)
                ZStack {
                    if !passcheck.isEmpty {
                        Button {
                            Join()
                        } label: {
                            Text("다음")
                                .font(.system(size: 15, weight: .black))
                                .foregroundStyle(.white)
                                .padding(.horizontal, 15)
                                .padding(.vertical, 7)
                                .background(
                                    RoundedRectangle(cornerRadius: 30)
                                        .fill(.main)
                                )
                        }
                    } else {
                        Text("")
                            .padding(.horizontal, 15)
                            .padding(.vertical, 7)
                    }
                }
                .frame(height: 44)
                
                NavigationLink(
                    destination: Signup_Tag(userId: userId ?? 0).environmentObject(userData),
                    isActive: $isSignupSuccess
                ) {
                    EmptyView()
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image("backbutton")
                            .resizable()
                            .frame(width: 12, height: 22)
                            .padding(.leading, 7)
                            .foregroundColor(.black)
                    }
                }
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("오류"), message: Text(alertMessage), dismissButton: .default(Text("확인")))
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private func Join() {
        if userData.password != passcheck {
            alertMessage = "비밀번호가 일치하지 않습니다."
            showAlert = true
            return
        }
        
        AuthService.shared.join(
            email: userData.email,
            nick: userData.nickname,
            password: userData.password
        ) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let joinResponse):
                    if let response = joinResponse as? JoinResponse {
                        print("\(response.message)\nUser\n ID: \(response.user.id)")
                        print(" Email: \(response.user.email)\n Nick: \(response.user.nick)\nToken: \(response.token)")
                        
                        userId = response.user.id
                        isSignupSuccess = true
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
    }
}
