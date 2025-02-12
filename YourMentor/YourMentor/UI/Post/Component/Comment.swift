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
    
    var comments: [Comment]
    
    var body: some View {
        VStack(spacing: 20) {
            ForEach(comments) { comment in
                VStack(alignment: .leading, spacing: 10) {
                    CommentCell(
                        nickname: comment.user.nick,
                        content: comment.content
                    )
//                    HStack {
//                        Button(action: {
//                            isReplyVisible[comment.count].toggle()
//                        }) {
//                            HStack(spacing: 5) {
//                                Image(systemName: isReplyVisible[comment.count] ? "chevron.up" : "chevron.down")
//                                    .resizable()
//                                    .frame(width: 10, height: 5)
//                                Text("답글 2개")
//                                    .font(.system(size: 12, weight: .medium))
//                            }
//                            .foregroundColor(.black.opacity(0.7))
//                        }
//                    }
//                    if isReplyVisible[comment.count] {
//                        VStack(alignment: .leading, spacing: 10) {
//                            TextFieldView()
//                                .padding(.top)
//                            ForEach(0..<2, id: \.self) { index in
//                                CommentCell(nickname: "ㅇㅇ", content: "ㅇㅇㅇ")
//                            }
//                        }
//                        .padding(.leading)
//                    }
                }
            }
        }
    }
}

struct CommentCell: View {
    var nickname: String
    var content: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 7) {
            Text(nickname+"님")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.gray.opacity(0.7))
            Text(content)
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(.black.opacity(0.8))
        }
        .frame(maxWidth: .infinity)
    }
}

struct TextFieldView: View {
    @State private var replyText: String = ""
    
    var body: some View {
        VStack {
            HStack {
                TextField("답글을 작성해보세요!", text: $replyText)
                    .autocapitalization(.none)
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
    }
}
