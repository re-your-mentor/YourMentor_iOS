//
//  UserService.swift
//  YourMentor
//
//  Created by 이다경 on 2/15/25.
//

import Foundation
import Alamofire
import UIKit

class UserService {
    static let shared = UserService()
    private init() {}
    
    func UserDetail(userId: Int, completion: @escaping (NetworkResult<UserDetail>) -> Void) {
        let url = APIConstants.userdetailURL(userId: userId)
        print("Request URL: \(url)")

        let header: HTTPHeaders = ["Content-Type": "application/json"]

        AF.request(url, method: .get, headers: header).responseData { response in
            switch response.result {
            case .success(let data):
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("서버 응답 JSON: \(jsonString)")
                } else {
                    print("응답 데이터를 문자열로 변환할 수 없습니다.")
                }

                do {
                    let decoder = JSONDecoder()
                    let userDetail = try decoder.decode(YourMentor.UserDetail.self, from: data)
                    completion(.success(userDetail))
                } catch {
                    print("디코딩 오류: \(error.localizedDescription)")
                    if let jsonString = String(data: data, encoding: .utf8) {
                        print("서버 응답 JSON: \(jsonString)")
                    }
                    
                }
            case .failure(let error):
                print("서버 요청 실패: \(error.localizedDescription)")
                if let data = response.data, let jsonString = String(data: data, encoding: .utf8) {
                    print("서버 응답 JSON: \(jsonString)")
                }
                
            }
        }
    }
}
