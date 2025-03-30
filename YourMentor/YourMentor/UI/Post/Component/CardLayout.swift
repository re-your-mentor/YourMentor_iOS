//
//  CardLayout.swift
//  YourMentor
//
//  Created by 이다경 on 12/27/24.
//

import SwiftUI

struct CardLayout: View {
    var id: Int
    var title: String
    var date: Date
    var like: Int
    var hashtag: [String]
    var img: String?
    var onDelete: () -> Void

    @State private var isSheetPresented = false
    @State private var showMenu = false
    @State private var showDeleteAlert = false
    
    @State private var alertMessage = ""
    @State private var showAlert = false
    
    @State private var isEditing = false

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                if let img = img, !img.isEmpty, let url = URL(string: img) {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(height: 140)
                        case .success(let image):
                            image.resizable()
                                .scaledToFill()
                                .frame(height: 140)
                                .clipShape(
                                    RoundedCornerShape(
                                        corners: [.topLeft, .topRight],
                                        radius: 12
                                    )
                                )
                                .clipped()
                        case .failure:
                            placeholderView
                        @unknown default:
                            placeholderView
                        }
                    }
                } else {
                    placeholderView
                }

                VStack {
                    Spacer()
                    HStack(spacing: 5) {
                        ForEach(hashtag, id: \.self) { tag in
                            Hashtag(title: tag)
                        }
                        Spacer()
                    }
                    .padding(.leading, 5)
                    .padding(.bottom, 7)
                }
            }
            .frame(height: 140)

            HStack(alignment: .top) {
                VStack(spacing: 3) {
                    HStack {
                        Text(title)
                            .font(.system(size: 15, weight: .semibold))
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
                    HStack(spacing: 3) {
                        Image(systemName: "clock")
                            .resizable()
                            .frame(width: 10, height: 10)
                        Text(formatteddate(date))
                            .font(.system(size: 10, weight: .semibold))
                            .padding(.trailing, 20)
                        Image(systemName: "heart")
                            .resizable()
                            .frame(width: 10, height: 10)
                        Text("\(like)")
                            .font(.system(size: 10, weight: .semibold))
                    }
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.leading, 7)
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: 45)
            .background(
                RoundedCornerShape(
                    corners: [.bottomLeft, .bottomRight], radius: 12
                )
                .foregroundColor(.white)
            )
            NavigationLink(destination: PostUploadView(isEditing: .constant(true), postID: id), isActive: $isEditing) {
                EmptyView()
            }
        }
        .foregroundColor(.black)
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
                postdelete(postid: id)
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

    private var placeholderView: some View {
        RoundedCornerShape(
            corners: [.topLeft, .topRight], radius: 12
        )
        .foregroundColor(.notimage)
        .frame(height: 140)
    }

    private func formatteddate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter.string(from: date)
    }

    private func postdelete(postid: Int) {
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

struct RoundedCornerShape: Shape {
    var corners: UIRectCorner
    var radius: CGFloat

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
