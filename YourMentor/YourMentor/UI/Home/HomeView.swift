//
//  HomeView.swift
//  YourMentor
//
//  Created by 이다경 on 1/3/25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        ZStack {
            Color.back
                .ignoresSafeArea()
            ScrollView(showsIndicators: false) {
                HStack {
                    VStack(alignment: .leading) {
                        Text("안녕하세요!")
                            .font(.system(size: 20, weight: .regular))
                            .foregroundColor(.subfont)
                        Text(userData.nicname+"님")
                            .font(.system(size: 23, weight: .bold))
                    }
                    Spacer()
                    Image("basicsprofile")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                }
                .padding(.horizontal, 50)
                .padding(.top)
                VStack {
                    UserProfileCard()
                        .environmentObject(UserData())
                        .frame(height: 150)
                    VStack(alignment: .leading){
                        Text("업로드 목록")
                            .font(.system(size: 20, weight: .semibold))
                            .padding(.leading)
                        ForEach(0..<4, id: \.self) { _ in
                            NavigationLink(destination: PostDetailView(
                                title: "안드로이드 깃허브로 협업하는 방법에 대하여",
                                date: Date(),
                                nicname: "맛좋은 오징어",
                                content: "지금 제가 정공이 안드로이드이라도 알려주실 분 구합니다.")) {
                                    CardLayout(title: "안드로이드 깃허브로 협업하는 방법에 대하여", date: Date())
                                }
                                .frame(width: 270)
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(UserData())
}
