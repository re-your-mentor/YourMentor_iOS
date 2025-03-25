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
    var hashtag: [String]
    
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
                    ForEach(hashtag, id: \.self) { tag in
                        Hashtag(title: tag)
                    }
                }
            }
            .padding(.bottom)
            Divider()
        }
        .frame(maxWidth: 295)
    }
}
