//
//  UserProfileCard.swift
//  YourMentor
//
//  Created by 이다경 on 1/11/25.
//

import SwiftUI

struct UserProfileCard: View {
    var body: some View {
        VStack {
            HStack {
                Text("email")
                    .font(.system(size: 15, weight: .bold))
                Spacer()
                Image(systemName: "chevron.right")
            }
            .padding(.vertical, 5)
            Rectangle()
                .foregroundColor(.white.opacity(0.5))
                .frame(height: 1)
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Text("내가 선택한 관심태그")
                        .font(.system(size: 15, weight: .semibold))
                        .padding(.vertical, 10)
                    Spacer()
                }
                UserHashtag(title: "SwiftUI")
            }
        }
        .padding(.horizontal, 20)
        .foregroundColor(.white)
        .frame(width: 295)
        .frame(minHeight: 80, maxHeight: 150)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.main)
        )
    }
}

#Preview {
    UserProfileCard()
}
