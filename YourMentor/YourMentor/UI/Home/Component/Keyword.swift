//
//  Keyword.swift
//  YourMentor
//
//  Created by 이다경 on 12/29/24.
//

import SwiftUI

struct Keyword: View {
    var keyword: String
    
    var body: some View {
        HStack(spacing: 5) {
            Image(systemName: "xmark")
                .resizable()
                .frame(maxWidth: 15, maxHeight: 15)
            Text(keyword)
                .font(.system(size: 15))
        }
        .padding(10)
        .foregroundColor(.white)
        .background(
            RoundedRectangle(cornerRadius: 10)
        )
    }
}

#Preview {
    Keyword(keyword: "검색어")
}
