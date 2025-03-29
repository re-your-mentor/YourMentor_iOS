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
    let creator: roomscreator
    let hashtags: [chathashtags]
    let createdAt: String
}

struct roomscreator: Codable {
    let id: Int
    let nick: String
    let profile_pic: String
}

struct room: Codable, Identifiable {
    let id: Int
    let name: String
    let description: String
    let userId: Int
    let createdAt: String
    let updatedAt: String
    let deletedAt: String?
    let creator: roomcreator
    let hashtags: [chathashtags]
}

struct roomcreator: Codable {
    let id: Int
    let email: String
    let nick: String
    let profile_pic: String?
}

struct ChatroomResponse: Codable {
    let room: room
}

struct chathashtags: Codable {
    let id: Int
    let name: String
    let createdAt: String
    let updatedAt: String
}
