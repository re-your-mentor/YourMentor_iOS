//
//  Signup_email.swift
//  YourMentor
//
//  Created by 이다경 on 1/9/25.
//

import SwiftUI

struct Signup_Email: View {
    @EnvironmentObject var userData: UserJoinData
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 45) {
                Image("loudspeaker")
                Text("너의 멘토에서 \(userData.nickname)님에게\n어떤 이메일로 연락을 드리면 될까요?")
                    .font(.system(size: 21, weight: .semibold))
                TextField("이메일을 작성해주세요!", text: $userData.email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
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
                    if !userData.email.isEmpty {
                        NavigationLink(destination: Signup_Password()
                            .environmentObject(userData)) {
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
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    Signup_Email()
        .environmentObject(UserJoinData())
}
