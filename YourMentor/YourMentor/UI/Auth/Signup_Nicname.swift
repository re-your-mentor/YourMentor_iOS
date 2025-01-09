//
//  Signup_nicname.swift
//  YourMentor
//
//  Created by 이다경 on 1/9/25.
//

import SwiftUI

class UserData: ObservableObject {
    @Published var nicname: String = ""
}

struct Signup_Nicname: View {
    @EnvironmentObject var userData: UserData
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 45) {
                Image("logo")
                VStack(spacing: 10) {
                    Text("너의 멘토에 오신 것을\n환영합니다!")
                        .font(.system(size: 35, weight: .bold))
                    Text("너의 멘토에서 사용하실 닉네임을 지정해주세요.")
                        .font(.system(size: 15.5, weight: .semibold))
                }
                TextField("닉네임을 작성해주세요!", text: $userData.nicname)
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
                    if !userData.nicname.isEmpty {
                        NavigationLink(destination: Signup_Email()) {
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
    Signup_Nicname()
}
