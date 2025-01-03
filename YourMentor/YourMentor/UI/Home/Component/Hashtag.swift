//
//  Hashtag.swift
//  YourMentor
//
//  Created by 이다경 on 12/27/24.
//

import SwiftUI

struct Hashtag: View {
    var title: String
    
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                Text("#")
                Text(title)
            }
            .font(.system(size: 13))
            .foregroundColor(.black)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 7)
        .background(
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.white)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 30)
                .stroke(lineWidth: 1)
                .foregroundColor(.black)
        )
    }
}

struct All: View {
    var body: some View {
        VStack {
            Text("전체")
                .font(.system(size: 13))
                .foregroundColor(.black)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 7)
        .background(
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.white)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 30)
                .stroke(lineWidth: 1)
                .foregroundColor(.black)
        )
    }
}


#Preview {
    Hashtag(title: "ddd")
}
