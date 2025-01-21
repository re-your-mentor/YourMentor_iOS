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
            .font(.system(size: 10))
            .foregroundColor(.black)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
        .background(
            RoundedRectangle(cornerRadius: 30)
                .fill(.white)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 30)
                .stroke(lineWidth: 1)
                .foregroundColor(.black)
        )
    }
}

struct UserHashtag: View {
    var title: String
    
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                Text("#")
                Text(title)
            }
            .font(.system(size: 10))
            .foregroundColor(.main)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
        .background(
            RoundedRectangle(cornerRadius: 30)
                .fill(.white)
        )
    }
}

struct MyProfileHashtag: View {
    var title: String
    
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                Text("#")
                Text(title)
            }
            .font(.system(size: 10))
            .foregroundColor(.black)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
        .background(
            RoundedRectangle(cornerRadius: 30)
                .fill(.white)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 30)
                .stroke(lineWidth: 1)
                .foregroundColor(.main)
        )
    }
}


#Preview {
    MyProfileHashtag(title: "ddd")
}
