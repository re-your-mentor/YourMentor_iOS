//
//  HomeView.swift
//  YourMentor
//
//  Created by 이다경 on 1/2/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            TabView {
                ChatListView()
                    .tabItem {
                        Image(systemName: "ellipsis.message")
                    }
            }
        }
    }
}

#Preview {
    HomeView()
}
