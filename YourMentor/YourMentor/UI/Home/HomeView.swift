//
//  HomeView.swift
//  YourMentor
//
//  Created by 이다경 on 1/3/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 25) {
                VStack(alignment: .leading) {
                    Text("학교 행사&이벤트")
                        .font(.system(size: 18, weight: .semibold))
                    RoundedRectangle(cornerRadius: 20)
                        .frame(maxWidth: 330)
                        .frame(height: 150)
                }
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(0..<4, id: \.self) { _ in
                            CardLayout(title: "안드로이드 깃허브로 협업하는 방법에 대하여", date: Date())
                        }
                    }
                }
                VStack(alignment: .leading) {
                    Text("업로드 목록")
                        .font(.system(size: 20, weight: .semibold))
                    HStack {
                        All()
                        Hashtag(title: "SwiftUI")
                    }
                    ForEach(0..<4, id: \.self) { _ in
                        PostCell(title: "안드로이드 깃허브로 협업하는 방법에 대하여", date: Date())
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
