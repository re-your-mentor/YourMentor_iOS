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
    var nickname: String
    var content: String
    var hashtag: String
    var img: String?
    
    @State private var c_text: String = ""
    
    var body: some View {
        ZStack(alignment: .top) {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    Spacer()
                        .frame(height: 55)
                    if let img = img, !img.isEmpty, let url = URL(string: img) {
                        AsyncImage(url: url) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .frame(height: 200)
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(height: 200)
                            case .failure:
                                Color.notimage
                                    .frame(height: 200)
                            @unknown default:
                                Color.notimage
                                    .frame(height: 200)
                            }
                        }
                    } else {
                        Color.notimage
                            .frame(height: 200)
                    }
                    
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
                                        Hashtag(title: hashtag)
                                    }
                                }
                                Spacer()
                            }
                        }
                        VStack(alignment: .leading, spacing: 5) {
                            HStack {
                                Text(nickname + "님의 작성글")
                                    .font(.system(size: 14, weight: .medium))
                                Spacer()
                            }
                            Divider()
                                .padding(.bottom, 10)
                            Text(content)
                                .font(.system(size: 15, weight: .medium))
                        }
                    }
                    .frame(maxWidth: 300)
                    .padding(.vertical, 25)
                    
                    Rectangle()
                        .frame(height: 7)
                        .foregroundColor(.back)
                    
                    VStack(spacing: 25) {
                        VStack(alignment: .leading) {
                            Text("댓글")
                                .font(.system(size: 13, weight: .medium))
                                .padding(.leading)
                            ZStack {
                                TextField("댓글을 작성해주세요.", text: $c_text)
                                    .autocapitalization(.none)
                                    .font(.system(size: 14, weight: .medium))
                                    .frame(height: 45)
                                    .padding(.leading)
                                    .background(
                                        RoundedRectangle(cornerRadius: 20)
                                            .foregroundColor(.back)
                                    )
                                HStack {
                                    Spacer()
                                    Button {
                                        
                                    } label: {
                                        Image(systemName: "paperplane")
                                            .resizable()
                                            .frame(maxWidth: 15, maxHeight: 15)
                                            .foregroundColor(.gray)
                                            .padding(.trailing)
                                    }
                                }
                            }
                        }
                        VStack(spacing: 25) {
                            CommentSection()
                        }
                    }
                    .frame(maxWidth: 300)
                    .padding(.top, 25)
                }
            }
            
            HeadView()
                .zIndex(1)
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter.string(from: date)
    }
}

//#Preview {
//    PostDetailView(title: "안드로이드 깃허브로 협업하는 방법에 대하여", date: Date(), nickname: "맛좋은 오징어", content: "지금 제가 전공이 안드로이드인데 팀 프로젝트를 하는건 처음이라서 잘 모르겠어요... 뭔가 깃허브로 학습하는 방식이 있던걸로 아는데 어떤 방식이 있는지 다 까먹었")
////    PostDetailHead()
//}
