//
//  ChatListView.swift
//  YourMentor
//
//  Created by 이다경 on 1/1/25.
//

import SwiftUI

struct ChatListView: View {
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    @Binding var rooms: [rooms]
//    let token = PostService.shared.LoadtokenFromKeychain()
    var body: some View {
        ZStack {
            Color.back
                .ignoresSafeArea()
            ScrollView(showsIndicators: false) {
                VStack {
                    NavigationLink(destination: ChatSearchView()) {
                        HStack(spacing: 10) {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                            Text("채팅방 검색하기")
                                .font(.system(size: 15))
                                .foregroundColor(.gray.opacity(0.7))
                            Spacer()
                        }
                        .padding(.horizontal, 25)
                        .padding(.vertical, 13)
                        .frame(maxWidth: 295)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.white)
                        )
                    }
                    
                    TagList()
                        .padding(.bottom, 20)
                    
                    NavigationLink(destination: ChatAddView()) {
                        HStack {
                            Image(systemName: "plus")
                                .resizable()
                                .frame(width: 12, height: 12)
                            Text("새 채팅")
                                .font(.system(size: 15, weight: .black))
                        }
                        .frame(maxWidth: 295)
                        .frame(height: 40)
                        .foregroundColor(.white)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(.main)
                        )
                    }
                    Spacer()
                        .frame(height: 50)
                    VStack(alignment: .leading) {
                        VStack(spacing: 20) {
                            ForEach(rooms) { room in
                                NavigationLink(destination: ChatView()) {
                                    ChatCell(title: room.name, nick: room.creator.nick)
                                }
                            }
                        }
                    }
                    Spacer()
                }
                .padding(.top)
            }
        }
//        .onAppear {
//            chatroomlist()
//        }
    }
    
//    private func chatroomlist() {
//        ChatService.shared.Chatroomlist(
//            token: token!
//        ) { result in
//            switch result {
//            case .success(let response):
//                print("채팅방 목록 조회 성공: \(response)")
//            case .requestErr(let message):
//                alertMessage = message as? String ?? "채팅방 목록 조회 실패"
//                showAlert = true
//            case .pathErr:
//                alertMessage = "잘못된 경로 요청입니다."
//                showAlert = true
//            case .serverErr:
//                alertMessage = "서버 오류가 발생했습니다."
//                showAlert = true
//            case .networkFail:
//                alertMessage = "네트워크 연결에 실패했습니다."
//                showAlert = true
//            }
//        }
//    }
}

