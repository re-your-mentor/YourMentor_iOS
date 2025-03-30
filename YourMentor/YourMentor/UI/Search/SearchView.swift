//
//  SearchView.swift
//  YourMentor
//
//  Created by 이다경 on 1/4/25.
//

import SwiftUI

struct SearchView: View {
    @State var posts: [Posts] = []
    @State var searchtext: String = ""
    let service = APIConstants.baseURL + "/img/"

    var filteredPosts: [Posts] {
        let trimmedText = searchtext.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmedText.isEmpty {
            return posts
        } else {
            return posts.filter { $0.title.lowercased().contains(trimmedText.lowercased()) }
        }
    }

    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                Color.back
                    .ignoresSafeArea(edges: .all)
                ScrollView(showsIndicators: false) {
                    VStack {
                        Spacer().frame(height: 65)
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                            TextField("검색어를 입력해주세요.", text: $searchtext)
                                .autocapitalization(.none)
                                .font(.system(size: 15))
                        }
                        .padding(.horizontal, 25)
                        .padding(.vertical, 13)
                        .frame(maxWidth: 295)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.white)
                        )
                        .padding(.top)
                        .padding(.bottom, 30)
                        
                        ForEach(filteredPosts) { post in
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
                HeadView()
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear { fetchPosts() }
    }
    
    private func fetchPosts() {
        PostService.shared.Postlist { result in
                switch result {
                case .success(let fetchedPosts):
                    self.posts = fetchedPosts.posts
                default:
                    print("게시물 목록 조회 실패")
                }
            }
        }
    private func deletePost(id: Int) {
        posts.removeAll { $0.id == id }
    }
}
