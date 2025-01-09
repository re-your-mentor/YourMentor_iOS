//
//  PostDetailView.swift
//  YourMentor
//
//  Created by 이다경 on 1/5/25.
//

import SwiftUI

struct PostDetailView: View {
    var title: String
    var date: Date
    var nicname: String
    var content: String
    @State private var c_text: String = ""
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    Image("postex")
                        .resizable()
                        .frame(maxWidth: .infinity)
                        .frame(height: 200)
                    VStack(spacing: 15) {
                        VStack {
                            VStack(spacing: 3) {
                                Text(title)
                                    .font(.system(size: 17, weight: .bold))
                                    .frame(maxWidth: .infinity, alignment: .leading)
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
                            HStack {
                                HStack(spacing: 5) {
                                    ForEach(0..<3, id: \.self) { _ in
                                        Hashtag(title: "SwiftUI")
                                    }
                                }
                                Spacer()
                            }
                        }
                        VStack(alignment: .leading, spacing: 13) {
                            HStack {
                                Text(nicname+"님의 작성글")
                                    .font(.system(size: 15, weight: .medium))
                                Spacer()
                                Text("follow")
                                    .padding(.vertical, 5)
                                    .padding(.horizontal, 10)
                                    .font(.system(size: 13, weight: .medium))
                                    .foregroundColor(.white)
                                    .background(
                                        RoundedRectangle(cornerRadius: 30)
                                            .foregroundColor(.email)
                                    )
                            }
                            Divider()
                            Text(content)
                                .font(.system(size: 16, weight: .medium))
                        }
                    }
                    .padding(.horizontal, 25)
                    .padding(.vertical, 30)
                    Rectangle()
                        .frame(height: 25)
                        .foregroundColor(.back)
                    VStack(spacing: 25) {
                        VStack(alignment: .leading) {
                            Text("댓글")
                                .font(.system(size: 17, weight: .medium))
                                .padding(.leading)
                            ZStack {
                                TextField("댓글을 작성해주세요.", text: $c_text)
                                    .frame(height: 45)
                                    .padding(.leading)
                                    .background(
                                        RoundedRectangle(cornerRadius: 20)
                                            .foregroundColor(.back)
                                    )
                                HStack {
                                    Spacer()
                                    Button(action: {
                                        // 전송 버튼 동작
                                    }) {
                                        Image(systemName: "paperplane")
                                            .resizable()
                                            .frame(maxWidth: 17, maxHeight: 15)
                                            .foregroundColor(.gray)
                                            .padding(.trailing)
                                    }
                                }
                            }
                        }
                        VStack(spacing: 20) {
                            ForEach(0..<3, id: \.self) { _ in
                                CommentCell(
                                    c_nicname: "오징어먹물",
                                    c_content: "저도 잘 모르겠는데요... 제가 아는 선배 분들 중에 협업 많이 하시는걸로 유명한 선배있는데 컨택해드릴까요?"
                                )
                            }
                        }
                    }
                    .padding(.horizontal, 25)
                    .padding(.top, 30)
                }
                
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        HStack {
                            Image(systemName: "chevron.backward")
                            Text("돌아가기")
                        }
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter.string(from: date)
    }
}

#Preview {
    PostDetailView(title: "d", date: Date(), nicname: "d", content: "d")
}
