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
    @State private var isAddTagSuccess = false
    
    let token = PostService.shared.LoadtokenFromKeychain()
    var userId: Int?
    
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
                            addUserTags()
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
                
                NavigationLink(destination: SignupSuccessView(userId: userId), isActive: $isAddTagSuccess) {
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
                            isAddTagSuccess = true
                            addUserTags()
                        }
                    }
                )
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private func addUserTags() {
        guard let userId = userId else { return }
        let hashtags = Array(selectedHashtags)
        
        UserService.shared.UserTagAdd(token: token ?? "", userId: userId, hashtags: hashtags) { result in
            switch result {
            case .success(let response):
                isAddTagSuccess = true
                print("해시태그 추가 성공")
            default:
                print("해시태그 추가 실패")
            }
        }
    }
}
