//
//  CardLayout.swift
//  YourMentor
//
//  Created by 이다경 on 12/27/24.
//

import SwiftUI

struct CardLayout: View {
    var title: String
    var date: Date
    var hashtag: String
    var img: String?
    
    @State private var showMenu: Bool = false
    @State private var showAlert: Bool = false
    @State private var isSheetPresented: Bool = false

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
                                        corners: [.topLeft, .topRight], radius: 12
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
                        ForEach(0..<3, id: \.self) { _ in
                            Hashtag(title: hashtag)
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
                    HStack(spacing: 1) {
                        Image(systemName: "clock")
                            .resizable()
                            .frame(width: 10, height: 10)
                        Text(formattedDate(date))
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
        }
        .foregroundColor(.black)
        .frame(maxWidth: 295)
        .sheet(isPresented: $isSheetPresented) {
                VStack {
                    Button("수정하기") {
                    }
                    .padding(7)
                    Divider()
                    Button("삭제하기") {
                        showAlert = true
                    }
                    .padding(7)
                }
                .foregroundColor(.gray)
                .presentationDetents([.height(100)])
            }
        .alert("정말로 게시물을 삭제하시겠습니까?", isPresented: $showAlert) {
            Button("네", role: .destructive) {
                
            }
            Button("아니요", role: .cancel) {
                
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

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter.string(from: date)
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

#Preview {
    CardLayout(title: "안드로이드 깃허브로 협업하는 방법에 대하여", date: Date(), hashtag: "sw")
}
