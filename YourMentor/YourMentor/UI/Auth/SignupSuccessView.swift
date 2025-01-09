//
//  SignupSuccessView.swift
//  YourMentor
//
//  Created by 이다경 on 12/25/24.
//

import SwiftUI

struct SignupSuccessView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Image("logo")
                    .padding(.bottom, 30)
                VStack(spacing: 45) {
                    VStack(spacing: 10) {
                        Text("회원가입\n완료되었습니다!")
                            .font(.system(size: 32, weight: .heavy))
                            .multilineTextAlignment(.center)
                        VStack {
                            Text("멘토를 만나러 바로 출발합시다!")
                                .fontWeight(.semibold)
                            Text("새로운 ")
                                .fontWeight(.semibold)
                            + Text("만남")
                                .foregroundColor(.main)
                                .fontWeight(.black)
                            + Text("들이 기다리고 있어요.")
                                .fontWeight(.semibold)
                        }
                    }
                    NavigationLink(destination: LoginView()) {
                        AuthButton(text: "Start")
                    }
                }
            }
            .padding(.horizontal, 7)
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    SignupSuccessView()
}
