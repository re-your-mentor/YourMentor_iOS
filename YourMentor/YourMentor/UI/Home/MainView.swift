//
//  HomeView.swift
//  YourMentor
//
//  Created by 이다경 on 1/2/25.
//

import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: Int
    
    var body: some View {
        VStack {
//            Color.gray
            HStack {
                Button(action: {
                    selectedTab = 0
                }) {
                    Image(systemName: "house")
                        .resizable()
                        .frame(width: 27, height: 25)
                        .padding()
                        .foregroundColor(selectedTab == 0 ? .email.opacity(0.7) : .gray.opacity(0.3))
                }
                
                Spacer()
                
                Button(action: {
                    selectedTab = 1
                }) {
                    Image(systemName: "text.document")
                        .resizable()
                        .frame(width: 20, height: 25)
                        .padding()
                        .foregroundColor(selectedTab == 1 ? .email.opacity(0.7) : .gray.opacity(0.3))
                }
                
                Spacer()
                
                Button(action: {
                    selectedTab = 2
                }) {
                    Image(systemName: "plus.circle")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .padding()
                        .foregroundColor(selectedTab == 2 ? .main : .main.opacity(0.3))
                }
                
                Spacer()
                
                Button(action: {
                    selectedTab = 3
                }) {
                    Image(systemName: "ellipsis.message")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .padding()
                        .foregroundColor(selectedTab == 3 ? .email.opacity(0.7) : .gray.opacity(0.3))
                }
                
                Spacer()
                
                Button(action: {
                    selectedTab = 4
                }) {
                    Image("basicsprofile")
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: 25, height: 25)
                        .padding()
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 20)
        }
        .background(
            ZStack {
                Rectangle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [.black.opacity(0.5), .clear]),
                            startPoint: .bottom,
                            endPoint: .top
                        )
                    )
                    .frame(height: 90)
                Rectangle()
                    .fill(.white)
                    .frame(height: 74)
                    .padding(.top)
            }
        )
    }
}

struct MainView: View {
    @State var selectedTab: Int
    @State private var isSearchActive = false
//    @EnvironmentObject var userData: UserJoinData
    @State private var posts: [Posts] = []
    @State private var user: UserDetail?
    @State private var rooms: [rooms] = []
    let token = PostService.shared.LoadtokenFromKeychain()
    var userId: Int?

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
//                MainHeaderView(isSearchActive: $isSearchActive)
                
                if isSearchActive {
                    SearchView(posts: $posts)
                } else {
                    VStack {
                        if selectedTab == 0 {
                            HomeView(posts: $posts, user: $user)
                                .onAppear { fetchPosts() }
                                .onAppear { fetchUser() }
                        } else if selectedTab == 1 {
                            PostListView(posts: $posts)
                                .onAppear { fetchPosts() }
                        } else if selectedTab == 2 {
                            PostUploadView(isEditing: .constant(false))
                        } else if selectedTab == 3 {
                            ChatListView(rooms: $rooms)
                                .onAppear { fetchChatroom() }
                        } else if selectedTab == 4 {
                            MyView(user: $user)
                                .onAppear { fetchUser() }
                        }
                    }
                    CustomTabBar(selectedTab: $selectedTab)
                }
            }
        }
        .navigationBarBackButtonHidden()
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
    
    private func fetchChatroom() {
        ChatService.shared.Chatroomlist(token: token!) { result in
            switch result {
            case .success(let fetchedChatroom):
                self.rooms = fetchedChatroom.rooms
            default:
                print("게시물 목록 조회 실패")
            }
        }
    }

    
    private func fetchUser() {
        UserService.shared.UserDetail(userId: userId ?? 0) { result in
            switch result {
            case .success(let fetchedUser):
                print("사용자 데이터: \(fetchedUser)")
                self.user = fetchedUser
            default:
                print("게시물 목록 조회 실패")
            }
        }
    }


}

//struct MainHeaderView: View {
//    @Binding var isSearchActive: Bool
//
//    var body: some View {
//        ZStack {
//            Color.white
//                .shadow(color: .gray.opacity(0.1), radius: 3, x: 0, y: 5)
//            if !isSearchActive {
//                ZStack {
//                    Button(action: {
//                        isSearchActive.toggle()
//                    }) {
//                        Image(systemName: "magnifyingglass")
//                            .resizable()
//                            .frame(width: 23, height: 23)
//                            .foregroundColor(.black)
//                    }
//                }
//                .padding(.bottom, 7)
//            }
//        }
//        .frame(height: 50)
//    }
//}
