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
    
    func UserDetail(userId: Int?, completion: @escaping (NetworkResult<UserDetail>) -> Void) {
        let url = APIConstants.userdetailURL(userId: userId)
        let header: HTTPHeaders = ["Content-Type": "application/json"]
        
        AF.request(url, method: .get, headers: header).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let userDetail = try JSONDecoder().decode(YourMentor.UserDetail.self, from: data)
                    completion(.success(userDetail))
                } catch {
                    print("디코딩 오류: \(error.localizedDescription)")
                }
            case .failure(let error):
                if let data = response.data, let jsonString = String(data: data, encoding: .utf8) {
                    print("서버 응답 JSON: \(jsonString)")
                }
                print("사용자 상세 조회 실패: \(error.localizedDescription)")
            }
        }
    }

}
