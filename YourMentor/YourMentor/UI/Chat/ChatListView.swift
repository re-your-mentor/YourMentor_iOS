//
//  ChatListView.swift
//  YourMentor
//
//  Created by 이다경 on 1/1/25.
//

import SwiftUI

struct ChatListView: View {
    @Binding var rooms: [rooms]
    
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
                                    ChatCell(title: room.name, nick: room.creator.nick, hashtag: room.hashtags.map { $0.name })
                                }
                            }
                        }
                    }
                    Spacer()
                }
                .padding(.top)
            }
        }
    }
}
