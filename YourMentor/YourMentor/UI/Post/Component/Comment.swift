//
//  commentCell.swift
//  YourMentor
//
//  Created by 이다경 on 1/5/25.
//

import SwiftUI

struct CommentSection: View {
    @State private var isReplyVisible: [Bool] = Array(repeating: false, count: 3)
    @State private var replyText: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            ForEach(0..<3, id: \.self) { index in
                VStack(alignment: .leading, spacing: 10) {
                    CommentCell(
                        c_nicname: "오징어먹물",
                        c_content: "저도 잘 모르겠는데요... 제가 아는 선배 분들 중에 협업 많이 하시는걸로 유명한 선배있는데 컨택해드릴까요?"
                    )
                    HStack {
                        Button(action: {
                            isReplyVisible[index].toggle()
                        }) {
                            HStack(spacing: 5) {
                                Image(systemName: isReplyVisible[index] ? "chevron.up" : "chevron.down")
                                    .resizable()
                                    .frame(width: 10, height: 5)
                                Text("답글 2개")
                                    .font(.system(size: 12, weight: .medium))
                            }
                            .foregroundColor(.black.opacity(0.7))
                        }
                    }
                    if isReplyVisible[index] {
                        VStack(alignment: .leading, spacing: 10) {
                            TextFieldView()
                                .padding(.top)
                            ForEach(0..<2, id: \.self) { index in
                                CommentCell(c_nicname: "ㅇㅇ", c_content: "ㅇㅇㅇ")
                            }
                        }
                        .padding(.leading)
                    }
                }
            }
        }
    }
}

struct CommentCell: View {
    var c_nicname: String
    var c_content: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 7) {
            Text(c_nicname+"님")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.gray.opacity(0.7))
            Text(c_content)
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(.black.opacity(0.8))
        }
        .frame(width: .infinity)
    }
}

struct TextFieldView: View {
    @State private var replyText: String = ""
    
    var body: some View {
        VStack {
            HStack {
                TextField("답글을 작성해보세요!", text: $replyText)
                    .font(.system(size: 13, weight: .medium))
                Spacer()
                Image(systemName: "paperplane")
                    .resizable()
                    .frame(width: 13, height: 13)
                    .foregroundColor(.gray)
            }
            .padding(.horizontal)
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.gray.opacity(0.7))
        }
        .frame(maxWidth: 260)
//        .padding(.horizontal)
    }
}

#Preview {
//    CommentCell(c_nicname: "오징어 튀김 학살자", c_content: "저도 잘 모르겠는데요... 제가 아는 선배 분들 중에 협업 많이 하시는걸로 유명한 선배있는데 컨택해드릴까요?")
//    CommentSection()
//    TextFieldView()
    PostDetailView(title: "안드로이드 깃허브로 협업하는 방법에 대하여", date: Date(), nicname: "맛좋은 오징어", content: "지금 제가 전공이 안드로이드인데 팀 프로젝트를 하는건 처음이라서 잘 모르겠어요... 뭔가 깃허브로 학습하는 방식이 있던걸로 아는데 어떤 방식이 있는지 다 까먹었")
}
