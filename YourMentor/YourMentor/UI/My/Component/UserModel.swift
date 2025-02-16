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
    let email: String
    let createdAt: String
    let user_hashtags: [hashtags]
    let posts: [UserPosts]
    let pagination: pagination
}

struct pagination: Codable {
    let totalItems: Int
    let totalPages: Int
    let currentPage: Int
    let pageSize: Int
}
