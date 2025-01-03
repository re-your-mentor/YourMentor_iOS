//
//  MyView.swift
//  YourMentor
//
//  Created by 이다경 on 1/3/25.
//

import SwiftUI

struct MyView: View {
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Spacer()
                    Image(systemName: "gear")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .padding(.trailing, 25)
                }
                MyProfile(email: "uoto716@dgsw.hs.kr")
                Spacer()
                    .frame(height: 100)
                VStack(alignment: .leading, spacing: 10) {
                    Text("내가 작성한 게시물")
                        .font(.system(size: 18, weight: .medium))
                    ForEach(0..<4, id: \.self) { _ in
                        PostCell(title: "안드로이드 깃허브로 협업하는 방법에 대하여", date: Date())
                    }
                }
            }
        }
    }
}

#Preview {
    MyView()
}
