//
//  UserModel.swift
//  YourMentor
//
//  Created by 이다경 on 2/15/25.
//

import Foundation

struct UserDetail: Codable {
    let user_id: Int
    let profile_pic: String
    let nick: String
    let email: String
    let createdAt: String
    let hashtags: [hashtags]
    let posts: [UserPosts]
    let pagination: pagination
}

struct pagination: Codable {
    let totalItems: Int
    let totalPages: Int
    let currentPage: Int
    let pageSize: Int
}

struct UserprofileUpdateRespone: Codable {
    let success: Bool
    let message: String
    let profile_pic: String?
}

struct UserNickUpdateRespone: Codable {
    let message: String
}

struct UsertagAddResponse: Codable {
    let success: Bool
    let addedCount: Int
    let currentTotal: Int
}

struct UsertagRemoveResponse: Codable {
    let success: Bool
    let user: User
    let currentHashtags: [hashtags]
}
