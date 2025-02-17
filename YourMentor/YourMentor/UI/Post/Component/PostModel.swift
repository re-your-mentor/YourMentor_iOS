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
    let likeCount: Int?
    let img: String?
    let userId: Int
    let createdAt: String
    let updatedAt: String?
    let Hashtags: [PostCreateHashtags]
}

struct PostCreateHashtags: Codable {
    let id: Int
    let name: String
    let createdAt: String
    let updatedAt: String?
}

struct PostListResponse: Codable {
    let count: Int
    let posts: [Posts]
}

struct Posts: Codable, Identifiable {
    let id: Int
    let title: String
    let content: String
    let img: String?
    let userId: Int
    let createdAt: String
    let updatedAt: String
    let likesCount: Int
    let User: user
    let Hashtags: [hashtags]
}

struct hashtags: Codable, Hashable, Identifiable {
    let id: Int
    let name: String
}

struct user: Codable {
    let id: Int
    let nick: String
}

struct PostResponse: Codable {
    let success: Bool
    let post: PostDetail?
}

struct PostDetail: Codable, Identifiable {
    let id: Int
    let title: String
    let content: String
    let img: String?
    let createdAt: String
    let updatedAt: String?
    let user: user
    let hashtags: [hashtags]
    let comments: [Comment]
}

struct Comment: Codable, Identifiable {
    let id: Int
    let reply_to: Int?
    let content: String
    let createdAt: String
    let user: CommentUser
}

struct CommentUser: Codable {
    let id: Int
    let nick: String
}

struct CommentResponse: Codable {
    let message: String
    let comment: CommentCreated
}

struct CommentCreated: Codable, Identifiable {
    let id: Int
    let content: String
    let postId: Int
    let reply_to: Int?
    let user_nick: String
    let createdAt: String
    let updatedAt: String
}

struct CommentDeleteResponse: Codable {
    let message: String
}

struct PostEditResponse: Codable {
    let post: [PostEdit]
}

struct PostEdit: Codable {
    let success: Bool
    let id: Int
    let title: String
    let content: String
    let img: String?
}

struct PostDeleteResponse: Codable {
    let success: Bool
    let message: String
}

struct UserPosts: Codable, Identifiable {
    let id: Int
    let title: String
    let content: String
    let img: String?
    let likesCount: Int
    let hashtags: [hashtags]
    let createdAt: String
}

struct UserTagResponse: Codable {
    let success: Bool
    let user: User
    let addedHashtags: [hashtags]
}
