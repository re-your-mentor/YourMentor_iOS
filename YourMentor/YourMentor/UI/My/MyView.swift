//
//  MyView.swift
//  YourMentor
//
//  Created by 이다경 on 1/3/25.
//

import SwiftUI

struct MyView: View {
    
    @Binding var user: UserDetail?
    let service = "http://3.148.49.139:8000/img/"
    
    @State private var isLogoutSuccess = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        VStack(spacing: 0) {
            VStack {
                HStack {
                    VStack(alignment: .leading, spacing: 7) {
                        HStack {
                            
                            Text((user?.nick ?? "이름 없음") + "님")
                            
                                .font(.system(size: 22, weight: .bold))
                            
                            NavigationLink(destination: MyEditView(
                                newnickname: user?.nick ?? "",
                                selectedHashtags: Set(user?.user_hashtags.map { $0.id } ?? []),
                                profileImageURL: service + (user?.profile_pic ?? "")
                            )) {
                                Image(systemName: "pencil")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .bold()
                                    .foregroundColor(.gray)
                            }

                        }
                        
                        Text(verbatim: user?.email ?? "")
                            .font(.system(size: 18))
                            .foregroundColor(.subfont)
                    }
                    Spacer()
                    let url = URL(string: service + (user?.profile_pic ?? ""))
                    AsyncImage(url: url) { image in
                        image.resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                            .frame(width: 84, height: 84)
                    } placeholder: {
                        ProgressView()
                    }
                }
                .frame(maxWidth: 295)
                .padding(.top)
                
                HStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        Text("내가 선택한 관심태그")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.black.opacity(0.8))
                        HStack(spacing: 5) {
                            ForEach(user?.user_hashtags ?? []) { hashtag in
                                MyProfileHashtag(title: hashtag.name)
                            }
                        }
                    }
                    Spacer()
                    Button(action: {
                        logout()
                    }) {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                            .resizable()
                            .frame(width: 22, height: 20)
                            .foregroundColor(.black.opacity(0.8))
                    }
                }
                .frame(maxWidth: 295)
                
                HStack {
                    VStack(spacing: 5) {
                        Text("내가 쓴 글")
                            .font(.system(size: 17, weight: .semibold))
                        RoundedRectangle(cornerRadius: 30)
                            .frame(width: 70, height: 2.3)
                            .foregroundColor(.black.opacity(0.9))
                    }
                    Spacer()
                }
                .frame(maxWidth: 295)
                .padding(.top, 30)
            }
            
            ZStack {
                Color.back.ignoresSafeArea()
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading) {
                        Text("최근 업로드")
                            .padding(.leading, 7)
                            .font(.system(size: 17, weight: .semibold))
                        ForEach(user?.posts ?? []) { post in
                            if let user = user {
                                NavigationLink(destination: PostDetailView(
                                    id: post.id,
                                    title: post.title,
                                    date: post.createdAt.toDate() ?? Date(),
                                    nickname: user.nick,
                                    content: post.content,
                                    hashtag: post.hashtags.map { $0.name },
                                    img: post.img.map { service+"\($0)" }
                                )) {
                                    PostCell(
                                        id: post.id,
                                        title: post.title,
                                        date: post.createdAt.toDate() ?? Date(),
                                        hashtag: post.hashtags.map { $0.name }
                                    )
                                }
                            } else {
                                Text("사용자 정보 로딩 중...")
                            }
                        }

                    }
                    .padding(.top, 30)
                }
            }
//            NavigationLink(destination: LoginView(), isActive: $isLogoutSuccess) {
//                EmptyView()
//            }
        }
    }
    
    func logout() {
        AuthService.shared.logout { result in
            switch result {
            case .success(let message):
                isLogoutSuccess = true
            case .requestErr(let message):
                alertMessage = message as? String ?? "오류가 발생했습니다."
                showAlert = true
            case .pathErr:
                alertMessage = "잘못된 경로 요청입니다."
                showAlert = true
            case .serverErr:
                alertMessage = "서버 오류가 발생했습니다."
                showAlert = true
            case .networkFail:
                alertMessage = "네트워크 연결에 실패했습니다."
                showAlert = true
            }
        }
    }
}
