//
//  Signup_Tag.swift
//  YourMentor
//
//  Created by 이다경 on 1/9/25.
//

import SwiftUI

struct Signup_Tag: View {
    @EnvironmentObject var userData: UserData
    @Environment(\.dismiss) private var dismiss
    @State private var selectedHashtags: Set<String> = []
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 45) {
                Text("\(userData.nicname)님께서 편안한 멘토맨티 서비스를\n위해 관심있는 태그를 클릭해주세요!")
                    .font(.system(size: 21, weight: .semibold))
                
                HashtagSelection(selectedHashtags: $selectedHashtags)
                    .frame(maxWidth: 295, maxHeight: 200)
                
                ZStack {
                    if !selectedHashtags.isEmpty {
                        NavigationLink(destination: SignupSuccessView()) {
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
    Signup_Tag()
        .environmentObject(UserData())
}
