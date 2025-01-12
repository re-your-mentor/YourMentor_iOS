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
                    Image(systemName: "person")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .padding()
                        .foregroundColor(selectedTab == 4 ? .email.opacity(0.7) : .gray.opacity(0.3))
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 20)
        }
        .background(Color.white)
        .shadow(color: .gray.opacity(0.1), radius: 3, x: 0, y: -5)
    }
}

struct MainView: View {
    @State private var selectedTab = 0
    @State private var isSearchActive = false

    var body: some View {
        NavigationView {
            VStack {
//                MainHeaderView(isSearchActive: $isSearchActive)
                
                if isSearchActive {
                    SearchView()
                } else {
                    VStack {
                        // Tab content
                        if selectedTab == 0 {
                            HomeView()
                        } else if selectedTab == 1 {
                            PostListView()
                        } else if selectedTab == 2 {
                            UploadView()
                        } else if selectedTab == 3 {
                            ChatListView()
                        } else if selectedTab == 4 {
                            MyView()
                        }
                    }
                    
                    CustomTabBar(selectedTab: $selectedTab)
                }
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
//            if isSearchActive {
//                ZStack {
//                    Button(action: {
//                        isSearchActive.toggle()
//                    }) {
//                        Image(systemName: "magnifyingglass")
//                            .resizable()
//                            .frame(width: 23, height: 23)
//                            .foregroundColor(.black)
//                    }
//                    .padding(.vertical, 11)
//                    .padding(.leading)
//                    .padding(.trailing, 300)
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 20)
//                            .stroke(lineWidth: 1)
//                            .foregroundColor(.black)
//                    )
//                    Keyword(keyword: "SwiftUI")
//                }
//                .padding(.bottom, 7)
//            } else {
//                HStack {
//                    Image("apptitle")
//                        .resizable()
//                        .frame(width: 80, height: 18)
//                    Spacer()
//                    Button(action: {
//                        isSearchActive.toggle()
//                    }) {
//                        Image(systemName: "magnifyingglass")
//                            .resizable()
//                            .frame(width: 23, height: 23)
//                            .foregroundColor(.black)
//                    }
//                }
//                .padding(.horizontal)
//            }
//        }
//        .frame(height: 50)
//    }
//}

#Preview {
    MainView()
}
