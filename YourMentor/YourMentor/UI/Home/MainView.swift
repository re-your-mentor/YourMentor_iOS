//
//  HomeView.swift
//  YourMentor
//
//  Created by 이다경 on 1/2/25.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView {
            TabView {
                HomeView()
                    .tabItem {
                        Image(systemName: "house")
                    }
                ChatListView()
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

#Preview {
    MainView()
}
