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
    @State private var selectedHashtags: Set<Int> = []
    
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
                        Text("#태그를 선택해주세요.")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundColor(.gray.opacity(0.7))
                        HashtagSelection(selectedHashtags: $selectedHashtags)
                            .frame(minHeight: 10)
                    }
                }
                .padding(.leading)
                
                Button {
                    
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
                    .frame(height: 180)
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
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    ChatAddView()
}
