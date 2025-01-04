//
//  HomeView.swift
//  YourMentor
//
//  Created by 이다경 on 1/2/25.
//

import SwiftUI

struct MainView: View {
    @State private var isSearchActive = false

    var body: some View {
        NavigationView {
            VStack {
                MainHeaderView(isSearchActive: $isSearchActive)
                if isSearchActive {
                    SearchView()
                } else {
                    TabView {
                        HomeView()
                            .tabItem {
                                Image(systemName: "house")
                            }
                        PostListView()
                            .tabItem {
                                Image(systemName: "text.document")
                            }
                        ChatListView()
                            .tabItem {
                                Image(systemName: "plus.circle")
                            }
                        ChatListView()
                            .tabItem {
                                Image(systemName: "ellipsis.message")
                            }
                        MyView()
                            .tabItem {
                                Image(systemName: "person")
                            }
                    }
                }
            }
        }
    }
}

struct MainHeaderView: View {
    @Binding var isSearchActive: Bool

    var body: some View {
        ZStack {
            Color.white
                .shadow(color: .gray.opacity(0.1), radius: 3, x: 0, y: 5)
            if isSearchActive {
                ZStack {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .frame(width: 23, height: 23)
                        .padding(.vertical, 11)
                        .padding(.leading)
                        .padding(.trailing, 300)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(lineWidth: 1)
                                .foregroundColor(.black)
                        )
                    Keyword(keyword: "SwiftUI")
                }
                .padding(.bottom, 7)
            } else {
                HStack {
                    Image("apptitle")
                        .resizable()
                        .frame(width: 80, height: 18)
                    Spacer()
                    Button(action: {
                        isSearchActive.toggle()
                    }) {
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .frame(width: 23, height: 23)
                            .foregroundColor(.black)
                    }
                }
                .padding(.horizontal)
            }
        }
        .frame(height: 50)
    }
}

#Preview {
    MainView()
}
