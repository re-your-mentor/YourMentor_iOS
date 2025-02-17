//
//  commentCell.swift
//  YourMentor
//
//  Created by 이다경 on 1/5/25.
//

import SwiftUI

struct CommentSection: View {
    
    @State private var isReplyVisible: [Int: Bool] = [:]
    @State private var replyComments: [Int: String] = [:]
    
    var comments: [Comment]
    var postId: Int
    var fetchPostDetail: () -> Void
    
    let token = PostService.shared.LoadtokenFromKeychain()
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var selectedCommentId: Int?
    @State private var showDeleteConfirmation = false
    
    var body: some View {
        VStack(spacing: 20) {
            ForEach(comments.filter { $0.reply_to == nil }) { comment in
                VStack(alignment: .leading, spacing: 10) {
                    CommentCell(
                        nickname: comment.user.nick,
                        content: comment.content,
                        commentId: comment.id,
                        onDelete: {
                            selectedCommentId = comment.id
                            showDeleteConfirmation = true
                        }
                    )
                    .padding(.leading, 5)
                    
                    let replies = getReplies(for: comment.id)
                    
                    HStack {
                        Button(action: toggleReplyVisibility(for: comment.id)) {
                            HStack(spacing: 5) {
                                Image(systemName: isReplyVisible[comment.id] == true ? "chevron.up" : "chevron.down")
                                    .resizable()
                                    .frame(width: 10, height: 5)
                                Text("답글 \(replies.count)개")
                                    .font(.system(size: 12, weight: .medium))
                            }
                            .foregroundColor(.gray.opacity(0.7))
                        }
                    }
                    
                    if isReplyVisible[comment.id] == true {
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                TextField("답글을 작성해보세요!", text: Binding(
                                    get: { replyComments[comment.id] ?? "" },
                                    set: { replyComments[comment.id] = $0 }
                                ))
                                .autocapitalization(.none)
                                .font(.system(size: 13, weight: .medium))
                                
                                Spacer()
                                Button {
                                    CommentCreate(replyTo: comment.id)
                                } label: {
                                    Image(systemName: "paperplane")
                                        .resizable()
                                        .frame(width: 13, height: 13)
                                        .foregroundColor(.gray)
                                }
                            }
                            .padding(.horizontal)
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(.gray.opacity(0.7))
                            
                            ForEach(replies) { reply in
                                CommentCell(
                                    nickname: reply.user.nick,
                                    content: reply.content,
                                    commentId: reply.id,
                                    onDelete: {
                                        selectedCommentId = reply.id
                                        showDeleteConfirmation = true
                                    }
                                )
                            }
                        }
                        .padding(.leading, 10)
                    }
                }
            }
        }
        .alert(isPresented: $showDeleteConfirmation) {
            Alert(
                title: Text("댓글 삭제"),
                message: Text("정말로 이 댓글을 삭제하시겠습니까?"),
                primaryButton: .destructive(Text("삭제")) {
                    if let commentId = selectedCommentId {
                        CommentDelete(commentId: commentId)
                    }
                },
                secondaryButton: .cancel(Text("취소"))
            )
        }
    }
    
    private func getReplies(for commentId: Int) -> [Comment] {
        return comments.filter { $0.reply_to == commentId }
    }
    
    private func toggleReplyVisibility(for commentId: Int) -> () -> Void {
        return {
            isReplyVisible[commentId] = !(isReplyVisible[commentId] ?? false)
        }
    }
    
    private func CommentCreate(replyTo: Int) {
        guard let replyContent = replyComments[replyTo], !replyContent.isEmpty else {
            alertMessage = "답글 내용을 입력해주세요."
            showAlert = true
            return
        }
        
        PostService.shared.Commentcreate(
            postId: postId,
            content: replyContent,
            replyTo: replyTo,
            token: token!
        ) { result in
            switch result {
            case .success(let response):
                print("대댓글 생성 성공: \(response)")
                replyComments[replyTo] = ""
                fetchPostDetail()
            case .requestErr(let message):
                alertMessage = message as? String ?? "댓글 생성 실패"
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
    
    private func CommentDelete(commentId: Int) {
        PostService.shared.Commentdelete(
            id: commentId,
            token: token!
        ) { result in
            switch result {
            case .success(let response):
                print("댓글 삭제 성공: \(response)")
                fetchPostDetail()
            case .requestErr(let message):
                alertMessage = message as? String ?? "댓글 삭제 실패"
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

struct CommentCell: View {
    var nickname: String
    var content: String
    var commentId: Int
    var onDelete: () -> Void
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 7) {
                Text(nickname+"님")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.gray.opacity(0.7))
                Text(content)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(.black.opacity(0.7))
            }
            .frame(maxWidth: 295, alignment: .leading)
            Spacer()
            VStack {
                Button(action: {
                    onDelete()
                }) {
                    Image(systemName: "trash")
                        .resizable()
                        .frame(width: 13, height: 13)
                        .foregroundColor(.red)
                        .padding(2)
                }
            }
        }
    }
}
