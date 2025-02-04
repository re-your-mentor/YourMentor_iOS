//
//  AuthModel.swift
//  YourMentor
//
//  Created by 이다경 on 1/25/25.
//

import Foundation

struct JoinResponse: Codable {
    let success: Bool
    let message: String
    let user: User
    let token: String
}

struct User: Codable {
    let id: Int
    let email: String
    let nick: String
}

struct LoginResponse: Codable {
    let success: Bool
    let message: String
    let user: User
    let token: String
}


struct ErrorResponse: Codable {
    let success: Bool
    let message: String
}
