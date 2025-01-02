//
//  ChatCell.swift
//  YourMentor
//
//  Created by 이다경 on 1/1/25.
//

import SwiftUI

struct ChatCell: View {
    var title: String
    
    var body: some View {
        VStack(spacing: 10) {
            VStack(spacing: 3) {
                Text(title)
                    .font(.system(size: 20))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, maxHeight: 20, alignment: .leading)
            }
            HStack {
                HStack(spacing: 5) {
                    ForEach(0..<3, id: \.self) { _ in
                        Hashtag(title: "SwiftUI")
                    }
                }
                Spacer()
            }
        }
        .frame(maxWidth: 345)
    }
}

#Preview {
    ChatCell(title: "저 안드로이드 개발 중인데 하나도 모르겠습니다.")
}
