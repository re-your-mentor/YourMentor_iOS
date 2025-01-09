//
//  Signup_Id.swift
//  YourMentor
//
//  Created by 이다경 on 1/9/25.
//

import SwiftUI

struct Signup_Id: View {
    @State private var id: String = ""
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 45) {
                Image("idcard")
                VStack {
                    Text("너의멘토에서 쓰실 아이디를 작성해주세요!")
                        .font(.system(size: 21, weight: .semibold))
                    Text("( 로그인 시 사용될 ID입니다. )")
                        .font(.system(size: 16, weight: .semibold))
                }
                TextField("아이디를 작성해주세요!", text: $id)
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
                    if !id.isEmpty {
                        NavigationLink(destination: Signup_Password()) {
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
    Signup_Id()
}
