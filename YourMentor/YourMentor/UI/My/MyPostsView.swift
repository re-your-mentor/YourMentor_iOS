//
//  MyPostsView.swift
//  YourMentor
//
//  Created by 이다경 on 3/6/25.
//

import SwiftUI

struct MyPostsView: View {
    @Binding var user: UserDetail?
    
    var body: some View {
        ZStack {
            Color.back.ignoresSafeArea()
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {
                    let posts = user?.posts ?? []
                    
                    if posts.isEmpty {
                        VStack {
                            Image(systemName: "nosign")
                                .resizable()
                                .frame(width: 100, height: 100)
                            Text("현재 만든 게시물이 없습니다!")
                                .font(.system(size: 20, weight: .semibold))
                        }
                        .padding(.top, 100)
                    } else {
                        Text("총 \(posts.count)개")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(.gray)
                            .padding(.leading, 50)
                        PostsView(user: $user)
                    }
                }
                .padding(.top, 30)
            }
        }
    }
}

struct PostsView: View {
    @Binding var user: UserDetail?
    let service = APIConstants.baseURL+"/img/"
    
    var body: some View {
        LazyVStack {
            let posts = user?.posts ?? []
            
            ForEach(posts, id: \.id) { post in
                let postDate = post.createdAt.toDate() ?? Date()
                let postHashtags = post.hashtags.map { $0.name }
                let postImageURLs = post.img.map { service + "\($0)" }
                let userNickname = user?.nick ?? "알 수 없음"
                
                NavigationLink(
                    destination: PostDetailView(
                        id: post.id,
                        title: post.title,
                        date: postDate,
                        nickname: userNickname,
                        content: post.content,
                        hashtag: postHashtags,
                        img: postImageURLs
                    )
                ) {
                    PostCell(
                        id: post.id,
                        title: post.title,
                        date: postDate,
                        like: post.likesCount,
                        hashtag: postHashtags
                    )
                }
            }
        }
    }
}
