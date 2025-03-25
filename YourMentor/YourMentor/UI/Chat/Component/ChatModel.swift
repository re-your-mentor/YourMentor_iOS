//
//  AuthModel.swift
//  YourMentor
//
//  Created by 이다경 on 3/24/25.
//

import Foundation

struct Chatroom: Codable {
    let rooms: [rooms]
    let totalRooms: Int
    let totalPages: Int
    let currentPage: Int
}

struct rooms: Codable, Identifiable {
    let id: Int
    let name: String
    let description: String
    let userId: Int
    let createdAt: String
    let updatedAt: String
    let creator: creator
    let hashtags: [hashtags]
}

struct creator: Codable {
    let nick: String
}

struct chathashtag: Codable {
    let id: Int
    let title: String
}

struct ChatroomResponse: Codable {
    let room: Chatroom
}

struct Creator: Codable {
    let id: Int
    let email: String
    let nick: String
    let profile_pic: String
}
