//
//  IncomingBubble.swift
//  YourMentor
//
//  Created by 이다경 on 12/29/24.
//

import SwiftUI

struct IncomingBubble: View {
    var char: String

    var body: some View {
        HStack {
            Text(char)
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
                .fixedSize(horizontal: false, vertical: true)
                .background(
                    ZStack(alignment: .bottomLeading) {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(.bubble)
                        Triangle()
                            .foregroundColor(.bubble)
                            .frame(width: 25, height: 25)
                            .padding(.trailing, 15)
                            .padding(.top, 10)
                            .rotationEffect(.degrees(-30))
                    }
                )
        }
        .padding(.horizontal, 10)
    }
}


#Preview {
    IncomingBubble(char: "안녕하세요")
}
