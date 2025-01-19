//
//  PostListView.swift
//  YourMentor
//
//  Created by 이다경 on 1/4/25.
//

import SwiftUI

struct PostListView: View {
    @State var searchtext: String = ""
    var body: some View {
        ZStack {
            Color.back
                .ignoresSafeArea()
            ScrollView(showsIndicators: false) {
                VStack {
                    NavigationLink(destination: SearchView()) {
                        HStack(spacing: 10) {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                            Text("검색어를 입력해주세요.")
                                .font(.system(size: 15))
                                .foregroundColor(.gray.opacity(0.7))
                            Spacer()
                        }
                        .padding(.horizontal, 25)
                        .padding(.vertical, 13)
                        .frame(maxWidth: 295)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.white)
                        )
                    }
                    .padding(.top)
                    
                    TagList()
                        .padding(.bottom, 30)
                    
                    VStack(alignment: .leading){
                        Text("인기 많은 업로드")
                            .font(.system(size: 17, weight: .semibold))
                            .padding(.leading, 55)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            ScrollViewReader { proxy in
                                HStack(spacing: 10) {
                                    ForEach(0..<5, id: \.self) { index in
                                        NavigationLink(destination: PostDetailView(
                                            title: "안드로이드 깃허브로 협업하는 방법에 대하여",
                                            date: Date(),
                                            nicname: "맛좋은 오징어",
                                            content: """
                                        지금 제가 전공이 안드로이드인데 팀 프로젝트를 하는 건 처음이라서 잘 모르겠어요...
                                        뭔가 깃허브로 학습하는 방식이 있던 걸로 아는데 어떤 방식이 있는지 다 까먹어 버렸어요...
                                        알아보게 혹시 협업 방식 명이라도 알려주실 분 구합니다.
                                        """
                                        )) {
                                            CardLayout(title: "안드로이드 깃허브로 협업하는 방법에 대하여", date: Date())
                                        }
                                        .frame(width: 295, height: 190)
                                        .id(index)
                                    }
                                    
                                }
                                .onAppear {
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                                proxy.scrollTo(1, anchor: .center)
                                            }
                                        }
                                
                            }
                            
                        }
                    }
                    .padding(.bottom, 40)
                    VStack(alignment: .leading) {
                        Text("최근 업로드")
                            .padding(.leading, 7)
                            .font(.system(size: 17, weight: .semibold))
                        ForEach(0..<10, id: \.self) { _ in
                            NavigationLink(destination: PostDetailView (
                                title: "안드로이드 깃허브로 협업하는 방법에 대하여",
                                date: Date(),
                                nicname: "맛좋은 오징어",
                                content: "지금 제가 정공이 안드로이드인데 팀 프로젝트를 하는건 처음이라서 잘 모르겠어요...뭔가 깃허브로 학습하는 방식이 있던걸로 아는데 어떤 방식이 있는지 다 까먹어 버렸어요... 알아보게 혹시 협업 방식 명이라도 알려주실 분 구합니다.")) {
                                    PostCell(title: "안드로이드 깃허브로 협업하는 방법에 대하여", date: Date())
                                }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    PostListView()
}
