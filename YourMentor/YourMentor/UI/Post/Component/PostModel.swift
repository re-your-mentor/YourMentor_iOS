//
//  Model.swift
//  YourMentor
//
//  Created by 이다경 on 1/30/25.
//

import Foundation

struct ImageUploadResponse: Codable {
    let success: Bool
    let img: String
}

struct PostCreateResponse: Codable {
    let success: Bool
    let post: PostCreated
}

struct PostCreated: Codable, Identifiable {
    let id: Int
    let title: String
    let content: String
    let img: String?
    let createdAt: String
    let updatedAt: String?
    let userId: Int
}

struct PostListResponse: Codable {
    let posts: [Posts]
}

struct Posts: Codable, Identifiable {
    let id: Int
    let title: String
    let content: String
    let img: String?
    let createdAt: String
    let user: user
    let hashtags: [String]
}

struct PostResponse: Codable {
    let success: Bool
    let post: PostDetail
}

struct PostDetail: Codable, Identifiable {
    let id: Int
    let title: String
    let content: String
    let img: String?
    let createdAt: String
    let updatedAt: String?
    let user: user
    let hashtags: [String]
    let comments: [Comment]
}

struct user: Codable {
    let id: Int
    let nick: String
    let img: String?
}

struct Comment: Codable {
    // 댓글 모델 추가 필요
}
