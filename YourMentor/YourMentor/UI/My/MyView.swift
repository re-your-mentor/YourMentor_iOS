//
//  MyView.swift
//  YourMentor
//
//  Created by 이다경 on 1/3/25.
//

import SwiftUI

struct MyView: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                HStack {
                    Spacer()
                    Image(systemName: "gear")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .padding(.trailing, 25)
                        .foregroundColor(.gray)
                }
                MyProfile(email: "uoto716@dgsw.hs.kr")
                Spacer()
                    .frame(height: 100)
                VStack(alignment: .leading, spacing: 10) {
                    Text("내가 작성한 게시물")
                        .font(.system(size: 18, weight: .medium))
                    ForEach(0..<4, id: \.self) { _ in
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
    MyView()
}
