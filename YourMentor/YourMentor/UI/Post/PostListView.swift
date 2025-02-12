//
//  PostListView.swift
//  YourMentor
//
//  Created by 이다경 on 1/4/25.
//

import SwiftUI

struct PostListView: View {
    @Binding var posts: [Posts]
//    @State private var postdetail: [PostDetail] = []
    
    @State var searchtext: String = ""
    let service = "http://3.148.49.139:8000/img/"
    
    var body: some View {
        ZStack {
            Color.back
                .ignoresSafeArea()
            ScrollView(showsIndicators: false) {
                VStack {
                    NavigationLink(destination: SearchView()) {
                        HStack(spacing: 10) {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                            Text("검색어를 입력해주세요.")
                                .font(.system(size: 15))
                                .foregroundColor(.gray.opacity(0.7))
                            Spacer()
                        }
                        .padding(.horizontal, 25)
                        .padding(.vertical, 13)
                        .frame(maxWidth: 295)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.white)
                        )
                    }
                    .padding(.top)
                    
                    TagList()
                        .padding(.bottom, 30)
                    
                    VStack(alignment: .leading){
                        Text("인기 많은 업로드")
                            .font(.system(size: 17, weight: .semibold))
                            .padding(.leading, 55)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 10) {
                                    ForEach(posts) { post in
                                        NavigationLink(destination: PostDetailView(
                                            id: post.id,
                                            title: post.title,
                                            date: post.createdAt.toDate() ?? Date(),
                                            nickname: post.user.nick,
                                            content: post.content,
                                            hashtag: post.hashtags.map { $0.name },
                                            img: post.img.map { service+"\($0)" }
                                        )) {
                                            CardLayout(
                                                id: post.id,
                                                title: post.title,
                                                date: post.createdAt.toDate() ?? Date(),
                                                hashtag: post.hashtags.map { $0.name },
                                                img: post.img.map { service+"\($0)" }
                                            )
                                        }
                                        .frame(width: 295, height: 190)
                                    }
                            }
                            
                        }
                    }
                    .padding(.bottom, 40)
                    VStack(alignment: .leading) {
                        Text("최근 업로드")
                            .padding(.leading, 7)
                            .font(.system(size: 17, weight: .semibold))
                        ForEach(posts) { post in
                            NavigationLink(destination: PostDetailView (
                                id: post.id,
                                title: post.title,
                                date: post.createdAt.toDate() ?? Date(),
                                nickname: post.user.nick,
                                content: post.content,
                                hashtag: post.hashtags.map { $0.name },
                                img: post.img.map { service+"\($0)" }
                            )) {
                                    PostCell(
                                        id: post.id,
                                        title: post.title,
                                        date: post.createdAt.toDate() ?? Date(),
                                        hashtag: post.hashtags.map { $0.name }
                                    )
                                }
                        }
                    }
                }
            }
        }
    }
}
