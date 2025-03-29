//
//  APIConstants.swift
//  YourMentor
//
//  Created by 이다경 on 1/24/25.
//

import Foundation

struct APIConstants {
//    static let baseURL = "http://3.136.244.4:8000"
    static let baseURL = "http://3.148.49.139:8000"
    
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
    
    // 게시물 작성
    static let postURL = baseURL + "/post"
    
    // 이미지 업로드
    static let imguploadURL = baseURL + "/upload/img"
    
    // 전체 게시물 리스트
    static let postlistURL = baseURL + "/"
    
    // 게시물 이미지 조회
    static func postimageURL(img: String) -> String {
        return postURL + "/img/\(img)"
    }
    
    // 게시물 상세(get) & 수정(put) & 삭제(del)
    static func postdetailURL(id: Int) -> String {
        return postURL + "/\(id)"
    }
    
    static func heartclick(postId: Int) -> String {
        return postURL + "/\(postId)/like"
    }
    
    // 댓글 생성
    static let commentURL = baseURL + "/comment"
    
    // 댓글 삭제
    static func commentdeleteURL(commentId: Int) -> String {
        return commentURL + "/\(commentId)"
    }
    
    // 유저
    static let userURL = baseURL + "/user"
    
    // 유저 조회
    static func userdetailURL(userId: Int) -> String {
        return userURL + "/profile/\(userId)"
    }
    
    // 유저 프로필 업데이트
    static let userprofileupdateURL = userURL + "/edit/profile"
    
    // 유저 닉네임 업데이트
    static let usernickupdateURL = userURL + "/edit/nick"
    
    // 유저 태그 추가 & 삭제
    static let usertagURL = userURL + "/tag"
    
    // 채팅
    static let chatURL = baseURL + "/chat"
    
    // 채팅방 생성 & 조회
    static let chatroomURL = chatURL + "/rooms"
    
    // 채팅방 정보 수정 & 삭제
    static func chatroomupdataURL(id: Int) -> String {
        return chatroomURL + "/\(id)"
    }
    
    // 채팅방 참여
    static func chatroomjoinURL(roomId: Int) -> String {
        return chatroomURL + "/\(roomId)/join"
    }
}
