//
//  ChatCell.swift
//  YourMentor
//
//  Created by 이다경 on 1/1/25.
//

import SwiftUI

struct ChatCell: View {
    var title: String
    var nick: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            VStack(alignment: .leading, spacing: 3) {
                Text(title)
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, maxHeight: 20, alignment: .leading)
                Text(nick)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.black.opacity(0.6))
            }
            HStack {
                HStack(spacing: 5) {
                    ForEach(0..<3, id: \.self) { _ in
                        Hashtag(title: "SwiftUI")
                    }
                }
//                Spacer()
            }
            .padding(.bottom)
            Divider()
        }
        .frame(maxWidth: 295)
    }
}

#Preview {
    ChatCell(title: "저 안드로이드 개발 중인데 하나도 모르겠습니다.", nick: "밤긋이아바밤규")
}
