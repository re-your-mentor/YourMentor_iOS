//
//  commentCell.swift
//  YourMentor
//
//  Created by 이다경 on 1/5/25.
//

import SwiftUI

struct CommentCell: View {
    var c_nicname: String
    var c_content: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 7) {
            Text(c_nicname)
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(.gray)
            Text(c_content)
                .font(.system(size: 16, weight: .medium))
        }
    }
}

#Preview {
    CommentCell(c_nicname: "오징어 튀김 학살자", c_content: "깃허브 협압 방식은 전공에 따라서 다르지 않아요. 하지만 통상적으로 쓰는 방식들이 있지요. 깃허브로 하는 업 방식이 궁금한거라면 gotflow 방식을 쓰는걸 추천해요")
}
