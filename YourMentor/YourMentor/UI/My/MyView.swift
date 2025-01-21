//
//  MyView.swift
//  YourMentor
//
//  Created by 이다경 on 1/3/25.
//

import SwiftUI

struct MyView: View {
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        VStack(spacing: 0) {
            VStack {
                HStack {
                    VStack(alignment: .leading, spacing: 7) {
                        HStack {
                            Text("이다경님")
                                .font(.system(size: 22, weight: .bold))
                            NavigationLink(destination: MyEditView()) {
                                Image(systemName: "pencil")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .bold()
                                    .foregroundColor(.gray)
                            }
                        }
                        Text(verbatim: "uoto716@dgsw.hs.kr")
                            .font(.system(size: 18))
                            .foregroundColor(.subfont)
                    }
                    Spacer()
                    MyProfile()
                        .frame(maxWidth: 85)
                }
                .frame(maxWidth: 295)
                .padding(.top)
                
                HStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        Text("내가 선택한 관심태그")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.black.opacity(0.8))
                        HStack(spacing: 5) {
                            ForEach(0..<3, id: \.self) { _ in
                                MyProfileHashtag(title: "Server")
                            }
                        }
                    }
                    Spacer()
                    Button {
                        
                    } label: {
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
                    VStack(alignment: .leading,spacing: 10) {
                        Text("총 4개")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(.gray)
                        ForEach(0..<4, id: \.self) { _ in
                            NavigationLink(destination: PostDetailView(
                                title: "안드로이드 깃허브로 협업하는 방법에 대하여",
                                date: Date(),
                                nicname: "맛좋은 오징어",
                                content: "알아보게 혹시 협업 방식 명이라도 알려주실 분 구합니다.")) {
                                    PostCell(title: "안드로이드 깃허브로 협업하는 방법에 대하여", date: Date())
                                }
                        }
                    }
                    .padding(.top, 30)
                }
            }
        }
    }
}


#Preview {
    MyView()
        .environmentObject(UserData())
}
