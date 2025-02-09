//
//  HomeView.swift
//  YourMentor
//
//  Created by 이다경 on 1/3/25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var userData: UserData
    @Binding var posts: [Posts]
    let service = "http://3.148.49.139:8000/img/"
    //    @State var searchtext: String = ""
    
    var body: some View {
        ZStack {
            Color.back
                .ignoresSafeArea()
            ScrollView(showsIndicators: false) {
                HStack {
                    VStack(alignment: .leading) {
                        Text("안녕하세요!")
                            .font(.system(size: 18, weight: .regular))
                            .foregroundColor(.subfont)
                        Text(userData.nickname+"님")
                            .font(.system(size: 21, weight: .bold))
                    }
                    Spacer()
                    Image("basicsprofile")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 56, height: 56)
                        .clipShape(Circle())
                }
                .padding(.horizontal, 50)
                .padding(.top)
                VStack {
                    UserProfileCard()
                        .environmentObject(UserData())
                        .frame(height: 150)
                        .padding(.bottom, 20)
                    
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
                    
                    TagList()
                        .padding(.bottom, 20)
                    
                    VStack(alignment: .leading){
                        Text("업로드 목록")
                            .font(.system(size: 17, weight: .semibold))
                            .padding(.leading)
                        ForEach(posts) { post in
                            NavigationLink(destination: PostDetailView(
                                title: post.title,
                                date: post.createdAt.toDate() ?? Date(),
                                nickname: post.user.nick,
                                content: post.content,
                                hashtag: post.hashtags.map { $0.name },
                                img: post.img.map { service+"\($0)" }
                            )) {
                                    CardLayout(
                                        id: post.id,
                                        title: post.title,
                                        date: post.createdAt.toDate() ?? Date(),
                                        hashtag: post.hashtags.map { $0.name },
                                        img: post.img.map { service+"\($0)" }
                                    )
                                }
                                .frame(maxWidth: 295)
                                .frame(height: 190)
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
    }
}
    
extension String {
    func toDate() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter.date(from: self)
    }
}


struct TagList: View {
    @State private var selectedHashtag: String? = "전체"
    
    let hashtags = ["전체", "Android", "Server", "iOS", "Web", "Embedded", "Kotlin", "Java", "Swift", "JavaScript", "Arduino", "Figma", "협업", "프로젝트"]
    
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 5) {
                    Spacer()
                        .frame(width: 45)
                    ForEach(hashtags, id: \.self) { hashtag in
                        Button(action: {
                            selectedHashtag = hashtag
                        }) {
                            Text(hashtag)
                                .font(.system(size: 13, weight: .medium))
                                .padding(.horizontal, 13)
                                .padding(.vertical, 7)
                                .background(selectedHashtag == hashtag ? .main : .white)
                                .foregroundColor(selectedHashtag == hashtag ? .white : .black)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(selectedHashtag == hashtag ? .clear : .main, lineWidth: 1.5)
                                )
                                .cornerRadius(30)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView(posts: .constant([]))
        .environmentObject(UserData())
}
