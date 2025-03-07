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
                .font(.system(size: 14, weight: .medium))
                .padding(.vertical, 12)
                .padding(.horizontal, 27)
                .fixedSize(horizontal: false, vertical: true)
                .background(
                    ZStack(alignment: .bottomLeading) {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(.white)
                        Triangle()
                            .foregroundColor(.white)
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
