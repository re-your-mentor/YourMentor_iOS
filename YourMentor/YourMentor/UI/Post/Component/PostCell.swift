//
//  ListView.swift
//  YourMentor
//
//  Created by 이다경 on 12/29/24.
//

import SwiftUI

struct PostCell: View {
    var id: Int
    var title: String
    var date: Date
    var hashtag: [String]
    
    @State private var isEditing = false
    
    @State private var isSheetPresented = false
    @State private var showMenu = false
    @State private var showDeleteAlert = false
    
    @State private var alertMessage = ""
    @State private var showAlert = false

    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 10) {
            VStack(spacing: 3) {
                HStack {
                    Text(title)
                        .font(.system(size: 14, weight: .semibold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
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
                
                HStack(spacing: 1) {
                    Image(systemName: "clock")
                        .resizable()
                        .frame(maxWidth: 10, maxHeight: 10)
                    Text(formattedDate(date))
                        .font(.system(size: 10, weight: .semibold))
                }
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .foregroundColor(.black)
            .padding(.bottom, 10)
            
            HStack {
                HStack(spacing: 5) {
                    ForEach(hashtag, id: \.self) { tag in
                        Hashtag(title: tag)
                    }
                }
                Spacer()
            }
            NavigationLink(destination: PostUploadView(isEditing: .constant(true), postID: id), isActive: $isEditing) {
                EmptyView()
            }
        }
        .padding([.horizontal, .top])
        .padding(.bottom, 5)
        .frame(maxWidth: 300)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray.opacity(0.5), lineWidth: 0.5)
                )
        )
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
                PostDelete(postid: id)
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
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter.string(from: date)
    }
    
    private func PostDelete(postid: Int) {
        guard let token = PostService.shared.LoadtokenFromKeychain() else {
            alertMessage = "토큰을 찾을 수 없습니다."
            showAlert = true
            return
        }

        PostService.shared.Postdelete(postid: postid, token: token) { result in
            switch result {
            case .success:
                print("게시물 삭제 성공")
                alertMessage = "게시물이 성공적으로 삭제되었습니다."
                showAlert = true

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

#Preview {
    PostCell(id: 10, title: "안드로이드 깃허브로 협업하는 방법에 대하여", date: Date(), hashtag: ["String"])
}
