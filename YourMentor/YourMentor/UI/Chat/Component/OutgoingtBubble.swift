//
//  ChatBubble.swift
//  YourMentor
//
//  Created by 이다경 on 12/29/24.
//

import SwiftUI

struct OutgoingBubble: View {
    var char: String

    var body: some View {
        HStack {
            Text(char)
                .foregroundColor(.white)
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
//                .frame(maxWidth: 300)
                .background(
                    ZStack(alignment: .bottomTrailing) {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(.main)
                        Triangle()
                            .fill(.main)
                            .frame(width: 25, height: 25)
                            .padding(.leading, 15)
                            .padding(.top, 10)
                            .rotationEffect(.degrees(30))
                    }
                )
        }
        .padding(.horizontal, 10)
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}

#Preview {
    OutgoingBubble(char: "그 누구보다 빠르게 남들과는 다르게 색다르게 리듬을 타는 비트위의 나그네")
}
