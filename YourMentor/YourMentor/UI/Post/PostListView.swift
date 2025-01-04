//
//  PostListView.swift
//  YourMentor
//
//  Created by 이다경 on 1/4/25.
//

import SwiftUI

struct PostListView: View {
    var body: some View {
        ZStack {
            Color.back
                .ignoresSafeArea()
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {
                    Text("업로드 목록")
                        .font(.system(size: 20, weight: .semibold))
                    HStack {
                        All()
                        Hashtag(title: "SwiftUI")
                    }
                    ForEach(0..<10, id: \.self) { _ in
                        PostCell(title: "안드로이드 깃허브로 협업하는 방법에 대하여", date: Date())
                    }
                }
            }
        }
    }
}

#Preview {
    PostListView()
}
