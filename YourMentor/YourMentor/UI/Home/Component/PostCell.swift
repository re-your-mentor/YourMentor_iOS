//
//  ListView.swift
//  YourMentor
//
//  Created by 이다경 on 12/29/24.
//

import SwiftUI

struct PostCell: View {
    var title: String
    var date: Date
    
    var body: some View {
        VStack(spacing: 10) {
            VStack(spacing: 3) {
                Text(title)
                    .font(.system(size: 15, weight: .semibold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                HStack(spacing: 1) {
                    Image(systemName: "clock")
                        .resizable()
                        .frame(maxWidth: 10, maxHeight: 10)
                    Text(formattedDate(date))
                        .font(.system(size: 10, weight: .semibold))
                }
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .foregroundColor(.black)
            HStack {
                HStack(spacing: 5) {
                    ForEach(0..<3, id: \.self) { _ in
                        Hashtag(title: "SwiftUI")
                    }
                }
                Spacer()
            }
        }
        .padding()
        .frame(maxWidth: 345)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                )
        )
    }
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd" // 원하는 형식
        return formatter.string(from: date)
    }
}

#Preview {
    PostCell(title: "안드로이드 깃허브로 협업하는 방법에 대하여", date: Date())
}
