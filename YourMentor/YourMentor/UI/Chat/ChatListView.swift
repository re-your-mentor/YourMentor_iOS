//
//  ChatListView.swift
//  YourMentor
//
//  Created by 이다경 on 1/1/25.
//

import SwiftUI

struct ChatListView: View {
    
    var body: some View {
        ZStack {
            Color.back
                .ignoresSafeArea()
            ScrollView(showsIndicators: false) {
                VStack {
                    NavigationLink(destination: ChatAddView()) {
                        HStack {
                            Image(systemName: "plus")
                                .resizable()
                                .frame(width: 15, height: 15)
                            Text("새 채팅")
                                .font(.system(size: 17, weight: .black))
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical)
                        .foregroundColor(.white)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .padding(.horizontal, 20)
                                .foregroundColor(.main)
                        )
                    }
                    Spacer()
                        .frame(height: 50)
                    VStack(alignment: .leading) {
                        VStack(spacing: 20) {
                            ForEach(0..<3, id: \.self) { _ in
                                NavigationLink(destination: ChatView()) {
                                    ChatCell(title: "저 안드로이드 개발 중인데 하나도 모르겠습니다.")
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

#Preview {
    ChatListView()
}
