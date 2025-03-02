//
//  UserProfileCard.swift
//  YourMentor
//
//  Created by 이다경 on 1/11/25.
//

import SwiftUI

struct UserProfileCard: View {
//    @EnvironmentObject var userData: UserJoinData
    @Binding var user: UserDetail?
    
    var body: some View {
        VStack(spacing: 0) {
            VStack {
                HStack {
                    Text(verbatim: user?.email ?? "")
                        .font(.system(size: 15, weight: .bold))
                    Spacer()
//                    NavigationLink(destination: MainView(selectedTab: 4, user)){
//                        Image(systemName: "chevron.right")
//                    }
                }
                .padding(.bottom, 3)
                Rectangle()
                    .foregroundColor(.white.opacity(0.5))
                    .frame(height: 1)
            }
            .padding(.top, 25)
            .padding(.horizontal, 20)
            .frame(width: 295)
            .background(
                RoundedCornerShape(corners: [.topLeft, .topRight], radius: 15)
                    .fill(.main)
            )
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Text("내가 선택한 관심태그")
                        .font(.system(size: 15, weight: .semibold))
                        .padding(.vertical, 10)
                    Spacer()
                }
                HStack(spacing: 3) {
                    ForEach(user?.hashtags ?? []) { hashtag in
                        UserHashtag(title: hashtag.name)
                    }
                    Spacer()
                }
                .frame(maxWidth: 290, maxHeight: 50)
            }
            .padding(.top, 5)
            .padding(.bottom, 25)
            .padding(.horizontal, 20)
            .frame(width: 295)
            .background(
                RoundedCornerShape(corners: [.bottomLeft, .bottomRight], radius: 15)
                    .foregroundColor(.main)
            )
        }
        .foregroundColor(.white)
        .frame(maxWidth: 265)
    }
}
