//
//  APIConstants.swift
//  YourMentor
//
//  Created by 이다경 on 1/24/25.
//

import Foundation

struct APIConstants {
    static let baseURL = "http://18.118.1.93:8000"
    
    // auth
    static let authURL = baseURL + "/auth"
    
    // 회원가입
    static let joinURL = authURL + "/join"
    
    // 로그인
    static let loginURL = authURL + "/login"
    
    // 로그아웃
    static let logoutURL = authURL + "/logout"
    
    // 카카오톡 로그인 요청
    static let kakaoURL = authURL + "/kakao"
    
    // 카카오톡 로그인 콜백
    static let kakaocallbackURL = kakaoURL + "/callback"
    
    // 구글 로그인 요청
    static let googleURL = authURL + "/google"
    
    // 구글 로그인 콜백
    static let googlecallbackURL = googleURL + "/callback"
    
    // 게시물
    static let postURL = baseURL + "/post"
    
    // 댓글 생성
    static func comment(teacherId: String, id: String) -> String {
        return postURL + "/teacher=\(teacherId)/\(id)"
    }
}
