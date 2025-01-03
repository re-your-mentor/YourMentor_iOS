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
            .padding(.top, 90)
            .padding(.trailing, 27)
            .frame(maxWidth: 265, maxHeight: 140)
            .background(
                RoundedCornerShape(corners: [.topLeft, .topRight], radius: 7)
                    .fill(.main.opacity(0.3))
            )
            HStack(alignment: .top) {
                VStack(spacing: 3) {
                    Text(title)
                        .font(.system(size: 15))
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    HStack(spacing: 1) {
                        Image(systemName: "clock")
                            .resizable()
                            .frame(maxWidth: 10, maxHeight: 10)
                        Text(formattedDate(date))
                            .font(.system(size: 10))
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.top, 5)
                .padding(.leading, 7)
                Spacer()
            }
            .frame(maxWidth: 265, maxHeight: 45)
            .background(
                RoundedCornerShape(corners: [.bottomLeft, .bottomRight], radius: 7)
                    .foregroundColor(.white)
            )

        }
    }
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd" // 원하는 형식
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

