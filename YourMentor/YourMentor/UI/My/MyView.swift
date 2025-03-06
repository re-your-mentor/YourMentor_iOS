//
//  MyView.swift
//  YourMentor
//
//  Created by 이다경 on 1/3/25.
//

import SwiftUI

struct MyView: View {
    @Binding var user: UserDetail?
    
    @State private var isLogoutSuccess = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        VStack(spacing: 0) {
            MyProfileView(user: $user)
            
            HStack {
                VStack(spacing: 5) {
                    Text("내가 쓴 글")
                        .font(.system(size: 17, weight: .semibold))
                    RoundedRectangle(cornerRadius: 30)
                        .frame(width: 70, height: 2.3)
                        .foregroundColor(.black.opacity(0.9))
                }
                Spacer()
                
                Button(action: {
                    logout()
                }) {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                        .resizable()
                        .frame(width: 22, height: 20)
                        .foregroundColor(.black.opacity(0.8))
                }
            }
            .frame(maxWidth: 295)
            .padding(.top, 30)
            
            MyPostsView(user: $user)
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("로그아웃 실패"), message: Text(alertMessage), dismissButton: .default(Text("확인")))
        }
    }
    
    func logout() {
        AuthService.shared.logout { result in
            switch result {
            case .success(let message):
                isLogoutSuccess = true
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
