//
//  Signup_Tag.swift
//  YourMentor
//
//  Created by 이다경 on 1/9/25.
//

import SwiftUI

struct Signup_Tag: View {
    @EnvironmentObject var userData: UserJoinData
    @Environment(\.dismiss) private var dismiss
    @State private var selectedHashtags: Set<Int> = []
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var isSignupSuccess = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 45) {
                Text("\(userData.nickname)님께서 편안한 멘토맨티 서비스를\n위해 관심있는 태그를 클릭해주세요!")
                    .font(.system(size: 21, weight: .semibold))
                
                HashtagSelection(selectedHashtags: $selectedHashtags)
                    .frame(maxWidth: 295, maxHeight: 200)
                
                ZStack {
                    if !selectedHashtags.isEmpty {
                        Button(action: {
                            Join()
                        }) {
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
                
                NavigationLink(destination: SignupSuccessView(), isActive: $isSignupSuccess) {
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
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("알림"),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("확인")) {
                        if alertMessage.contains("성공") {
                            isSignupSuccess = true
                        }
                    }
                )
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private func Join() {
//        userData.selectedTags = selectedHashtags
        
        AuthService.shared.join(
            email: userData.email,
            nick: userData.nickname,
            password: userData.password
        ) { result in
            switch result {
            case .success(let joinResponse):
                if let response = joinResponse as? JoinResponse {
                    print("\(response.message)\nUser\n ID: \(response.user.id)")
                    print(" Email: \(response.user.email)\n Nick: \(response.user.nick)\nToken: \(response.token)")
                } else {
                    print("Failed to cast loginResponse to LoginResponse")
                }
                isSignupSuccess = true
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

#Preview {
    Signup_Tag()
        .environmentObject(UserJoinData())
}
