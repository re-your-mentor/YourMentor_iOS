//
//  SearchView.swift
//  YourMentor
//
//  Created by 이다경 on 1/4/25.
//

import SwiftUI

struct SearchView: View {
    @State var searchtext: String = ""
    
    var body: some View {
        NavigationStack {
                ZStack(alignment: .top) {
                    Color.back
                        .ignoresSafeArea(edges: .all)
                    ScrollView(showsIndicators: false) {
                        VStack {
                            Spacer()
                                .frame(height: 65)
                            HStack {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.gray)
                                TextField("검색어를 입력해주세요.", text: $searchtext)
                                    .autocapitalization(.none)
                                    .font(.system(size: 15))
                            }
                            .padding(.horizontal, 25)
                            .padding(.vertical, 13)
                            .frame(maxWidth: 295)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(.white)
                            )
                            .padding(.top)
                            .padding(.bottom, 30)
                            ForEach(0..<4, id: \.self) { _ in
                                PostCell(
                                    id: 1,
                                    title: "안드로이드 깃허브로 협업하는 방법에 대하여",
                                    date: Date(),
                                    hashtag: ["post.hashtags.map { $0.name }"]
                                )
                            }
                        }
                    }
                    HeadView()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    SearchView()
}
