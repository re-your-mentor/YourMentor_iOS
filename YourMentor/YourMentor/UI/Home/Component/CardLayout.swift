//
//  CardLayout.swift
//  YourMentor
//
//  Created by 이다경 on 12/27/24.
//

import SwiftUI

struct CardLayout: View {
    var title: String
    var date: Date

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 5) {
                ForEach(0..<3, id: \.self) { _ in
                    Hashtag(title: "SwiftUI")
                }
            }
            .padding(.top, 95)
            .padding(.trailing, 27)
            .frame(maxWidth: .infinity, maxHeight: 140)
            .background(
                RoundedCornerShape(corners: [.topLeft, .topRight], radius: 7)
                    .fill(.notimage)
            )
            HStack(alignment: .top) {
                VStack(spacing: 3) {
                    Text(title)
                        .font(.system(size: 15, weight: .semibold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    HStack(spacing: 1) {
                        Image(systemName: "clock")
                            .resizable()
                            .frame(width: 10, height: 10)
                        Text(formattedDate(date))
                            .font(.system(size: 10, weight: .semibold))
                    }
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.top, 5)
                .padding(.leading, 7)
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: 45)
            .background(
                RoundedCornerShape(corners: [.bottomLeft, .bottomRight], radius: 7)
                    .foregroundColor(.white)
            )
        }
        .foregroundColor(.black)
        .frame(maxWidth: 265)
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter.string(from: date)
    }
}

struct RoundedCornerShape: Shape {
    var corners: UIRectCorner
    var radius: CGFloat

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

#Preview {
    CardLayout(title: "안드로이드 깃허브로 협업하는 방법에 대하여", date: Date())
}
