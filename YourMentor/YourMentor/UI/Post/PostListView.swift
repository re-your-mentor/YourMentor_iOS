//
//  PostListView.swift
//  YourMentor
//
//  Created by 이다경 on 1/4/25.
//

import SwiftUI

struct PostListView: View {
    @State private var posts: [Posts] = []
    @State private var searchText: String = ""
    @State private var isLoading: Bool = false
    let service = APIConstants.baseURL + "/img/"
    
    var body: some View {
        ZStack {
            Color.back
                .ignoresSafeArea()
            ScrollView(showsIndicators: false) {
                VStack {
                    searchBar
                    
                    TagList()
                        .padding(.bottom, 30)
                    
                    popularPostsSection
                    
                    recentPostsSection
                }
            }
            .onAppear { fetchPosts() }
            .overlay(
                // 로딩 인디케이터
                isLoading ? AnyView(ProgressView()) : AnyView(EmptyView())
            )
        }
    }

    private var searchBar: some View {
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
    }

    private var popularPostsSection: some View {
        VStack(alignment: .leading) {
            Text("인기 많은 업로드")
                .font(.system(size: 17, weight: .semibold))
            
            if posts.count == 1 {
                popularPostsVertical
            } else {
                popularPostsHorizontal
            }
        }
        .padding(.bottom, 40)
    }

    private var popularPostsVertical: some View {
        ScrollView(showsIndicators: false) {
            ForEach(posts) { post in
                NavigationLink(destination: PostDetailView(
                    id: post.id,
                    title: post.title,
                    date: post.createdAt.toDate() ?? Date(),
                    nickname: post.User.nick,
                    content: post.content,
                    hashtag: post.Hashtags.map { $0.name },
                    img: post.img.map { service + "\($0)" }
                )) {
                    CardLayout(
                        id: post.id,
                        title: post.title,
                        date: post.createdAt.toDate() ?? Date(),
                        like: post.likesCount,
                        hashtag: post.Hashtags.map { $0.name },
                        img: post.img.map { service + "\($0)" },
                        onDelete: {
                            deletePost(id: post.id)
                        }
                    )
                }
                .frame(width: 295, height: 190)
            }
        }
    }

    private var popularPostsHorizontal: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(posts) { post in
                    NavigationLink(destination: PostDetailView(
                        id: post.id,
                        title: post.title,
                        date: post.createdAt.toDate() ?? Date(),
                        nickname: post.User.nick,
                        content: post.content,
                        hashtag: post.Hashtags.map { $0.name },
                        img: post.img.map { service + "\($0)" }
                    )) {
                        CardLayout(
                            id: post.id,
                            title: post.title,
                            date: post.createdAt.toDate() ?? Date(),
                            like: post.likesCount,
                            hashtag: post.Hashtags.map { $0.name },
                            img: post.img.map { service + "\($0)" },
                            onDelete: {
                                deletePost(id: post.id)
                            }
                        )
                    }
                    .frame(width: 295, height: 190)
                }
            }
        }
    }

    private var recentPostsSection: some View {
        VStack(alignment: .leading) {
            Text("최근 업로드")
                .padding(.leading, 7)
                .font(.system(size: 17, weight: .semibold))

            ForEach(posts) { post in
                NavigationLink(destination: PostDetailView(
                    id: post.id,
                    title: post.title,
                    date: post.createdAt.toDate() ?? Date(),
                    nickname: post.User.nick,
                    content: post.content,
                    hashtag: post.Hashtags.map { $0.name },
                    img: post.img.map { service + "\($0)" }
                )) {
                    PostCell(
                        id: post.id,
                        title: post.title,
                        date: post.createdAt.toDate() ?? Date(),
                        like: post.likesCount,
                        hashtag: post.Hashtags.map { $0.name },
                        onDelete: {
                            deletePost(id: post.id)
                        }
                    )
                }
            }
        }
    }

    private func fetchPosts() {
        isLoading = true
        PostService.shared.Postlist { result in
            DispatchQueue.main.async {
                isLoading = false
            }
            switch result {
            case .success(let fetchedPosts):
                DispatchQueue.main.async {
                    self.posts = fetchedPosts.posts
                }
            default:
                DispatchQueue.main.async {
                    print("게시물 목록 조회 실패")
                }
            }
        }
    }

    private func deletePost(id: Int) {
        posts.removeAll { $0.id == id }
    }
}
