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

struct PostResponse: Codable {
    let success: Bool
    let post: PostDetail
}

struct PostDetail: Codable {
    let id: Int
    let title: String
    let content: String
    let img: String?
    let userId: Int
    let updatedAt: String
    let createdAt: String
}
