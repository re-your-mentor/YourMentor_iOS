//
//  NetworkResult.swift
//  YourMentor
//
//  Created by 이다경 on 1/25/25.
//

import Foundation

enum NetworkResult<T> {
    case success(T) // 서버 통신 성공
    case requestErr(String) // 요청 에러가 발생
    case pathErr // 경로 에러
    case serverErr // 서버의 내부 에러
    case networkFail // 네트워크 연결실패
}
