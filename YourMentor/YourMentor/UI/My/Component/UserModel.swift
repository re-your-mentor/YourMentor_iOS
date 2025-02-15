//
//  UserModel.swift
//  YourMentor
//
//  Created by 이다경 on 2/15/25.
//

import Foundation

struct UserDetail: Codable {
    let profile_pic: String
    let nick: String
    let createdAt: String
    let posts: [UserPosts]
}

struct UserPosts: Codable, Identifiable {
    let id: Int
    let title: String
    let content: String
    let likeCount: Int
    let img: String?
    let userId: Int
    let createdAt: String
    let updatedAt: String
}
