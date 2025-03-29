//
//  ChatCell.swift
//  YourMentor
//
//  Created by 이다경 on 1/1/25.
//

import SwiftUI

struct ChatCell: View {
    var id: Int
    var title: String
    var nick: String
    var hashtag: [String]
    var onDelete: () -> Void
    
    @State private var isEditing = false
    
    @State private var isSheetPresented = false
    @State private var showMenu = false
    @State private var showDeleteAlert = false
    
    @State private var alertMessage = ""
    @State private var showAlert = false

    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            VStack(alignment: .leading, spacing: 3) {
                HStack {
                    Text(title)
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, maxHeight: 20, alignment: .leading)
                    Button(action: {
                        isSheetPresented.toggle()
                    }) {
                        Image(systemName: "ellipsis")
                            .resizable()
                            .frame(width: 11, height: 3)
                            .rotationEffect(.degrees(90))
                            .foregroundColor(.gray)
                            .padding(2)
                    }
                    .contentShape(Rectangle())
                }
                Text(nick)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.black.opacity(0.6))
            }
            HStack {
                HStack(spacing: 5) {
                    ForEach(hashtag, id: \.self) { tag in
                        Hashtag(title: tag)
                    }
                }
            }
            .padding(.bottom)
            Divider()
        }
        .frame(maxWidth: 295)
        .sheet(isPresented: $isSheetPresented) {
                VStack {
                    Button("수정하기") {
                        isSheetPresented = false
                        isEditing = true
                    }
                    .padding(7)
                    Divider()
                    Button("삭제하기") {
                        showDeleteAlert = true
                    }
                    .padding(7)
                }
                .foregroundColor(.gray)
                .presentationDetents([.height(100)])
            }
        .alert("정말로 게시물을 삭제하시겠습니까?", isPresented: $showDeleteAlert) {
            Button("네", role: .destructive) {
                chatdelete(id: id)
            }
            Button("아니요", role: .cancel) {
                dismiss()
            }
        }
        .alert(alertMessage, isPresented: $showAlert) {
            Button("확인", role: .cancel) {
                dismiss()
            }
        }
    }
    
    private func chatdelete(id: Int) {
        guard let token = PostService.shared.LoadtokenFromKeychain() else {
            alertMessage = "토큰을 찾을 수 없습니다."
            showAlert = true
            return
        }

        ChatService.shared.Chatroomdelete(id: id, token: token) { result in
            switch result {
            case .success:
                print("게시물 삭제 성공")
                alertMessage = "게시물이 성공적으로 삭제되었습니다."
                showAlert = true
                onDelete()
            case .requestErr(let message):
                alertMessage = "오류:\n\(message ?? "알 수 없는 오류")"
                showAlert = true
            case .pathErr:
                alertMessage = "게시물을 찾을 수 없습니다."
                showAlert = true
            case .serverErr:
                alertMessage = "서버에서 오류가 발생했습니다."
                showAlert = true
            case .networkFail:
                alertMessage = "네트워크 문제로 삭제에 실패했습니다."
                showAlert = true
            }
        }
    }
}
