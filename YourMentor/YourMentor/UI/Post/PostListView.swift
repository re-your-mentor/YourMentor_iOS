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
                        NavigationLink(destination: PostDetailView(
                            title: "안드로이드 깃허브로 협업하는 방법에 대하여",
                            date: Date(),
                            nicname: "맛좋은 오징어",
                            content: "지금 제가 정공이 안드로이드인데 팀 프로젝트를 하는건 처음이라서 잘 모르겠어요...뭔가 깃허브로 학습하는 방식이 있던걸로 아는데 어떤 방식이 있는지 다 까먹어 버렸어요... 알아보게 혹시 협업 방식 명이라도 알려주실 분 구합니다.")) {
                            PostCell(title: "안드로이드 깃허브로 협업하는 방법에 대하여", date: Date())
                        }
                    }
                }
            }
            .padding(.top)
        }
    }
}

#Preview {
    PostListView()
}
