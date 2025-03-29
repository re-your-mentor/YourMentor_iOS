//
//  ChatAddView.swift
//  YourMentor
//
//  Created by 이다경 on 3/6/25.
//

import SwiftUI

struct ChatAddView: View {
    
    @State private var tag: String = ""
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var selectedHashtags: Set<Int> = []
    
    @State private var isAddSuccess = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    let token = PostService.shared.LoadtokenFromKeychain()
    
    @State private var userId: Int = 0
    
    var body: some View {
        ZStack {
            Color.back
                .ignoresSafeArea()
            VStack(alignment: .center) {
                Spacer()
                    .frame(height: 150)
                VStack(alignment: .leading, spacing: 70) {
                    VStack(alignment: .leading) {
                        TextField("제목을 입력해주세요.", text: $title)
                            .autocapitalization(.none)
                            .font(.system(size: 17))
                        Text("\(title.count)/40자")
                            .foregroundColor(title.count > 40 ? .red : .gray.opacity(0.7))
                            .font(.system(size: 14))
                    }
                    .fontWeight(.bold)
                    VStack(alignment: .leading) {
                        TextField("설명을 입력해주세요.", text: $description)
                            .autocapitalization(.none)
                            .font(.system(size: 17))
                    }
                    VStack(alignment: .leading) {
                        Text("#태그를 선택해주세요.")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundColor(.gray.opacity(0.7))
                        HashtagSelection(selectedHashtags: $selectedHashtags)
                            .frame(minHeight: 10)
                    }
                }
                .padding(.leading)
                
                Button {
                    chatroomadd()
                } label: {
                    Text("채팅방 만들기")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 45)
                        .background(
                            RoundedRectangle(cornerRadius: 30)
                                .fill(.email)
                        )
                        .padding(.horizontal, 15)
                }
                Spacer()
                    .frame(height: 100)
            }
            .frame(maxWidth: .infinity)
            .background(
                Rectangle()
                    .fill(.white)
                    .ignoresSafeArea()
            )
            .padding(.horizontal, 45)
            
            VStack {
                HeadView()
                Spacer()
            }
            
            NavigationLink(destination: MainView(selectedTab: 3, userId: userId), isActive: $isAddSuccess) {
                EmptyView()
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("오류"), message: Text(alertMessage), dismissButton: .default(Text("확인")))
        }
        .navigationBarBackButtonHidden()
    }
    
    private func chatroomadd() {
        ChatService.shared.Chatroomadd(
            name: title,
            description: description,
            token: token!,
            hashtag: Array(selectedHashtags)
        ) { result in
            switch result {
            case .success(let response):
                print("채팅방 생성 성공: \(response)")
                print("선택된 해시태그: \(Array(selectedHashtags))")
                self.userId = response.room.userId
                isAddSuccess = true
            case .requestErr(let message):
                alertMessage = message as? String ?? "채팅방 생성 실패"
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
    ChatAddView()
}
