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
    
    func UserProfileUpdate(token: String, profile_pic: String, completion: @escaping (NetworkResult<UserprofileUpdateRespone>) -> Void) {
        let url = APIConstants.userprofileupdateURL
        let header: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(token)"
        ]
        
        let body: [String: Any] = [
            "profile_pic": profile_pic
        ]
        
        AF.request(url, method: .put, parameters: body, encoding: JSONEncoding.default, headers: header)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    if let jsonString = String(data: data, encoding: .utf8) {
                        print("서버 응답 JSON: \(jsonString)")
                    }
                    
                    do {
                        let decodedData = try JSONDecoder().decode(UserprofileUpdateRespone.self, from: data)
                        completion(.success(decodedData))
                    } catch {
                        print("JSON 디코딩 오류: \(error.localizedDescription)")
                    }
                    
                case .failure(let error):
                    print("서버 요청 실패: \(error.localizedDescription)")
                    if let data = response.data, let jsonString = String(data: data, encoding: .utf8) {
                        print("서버 응답 JSON: \(jsonString)")
                    }
                }
            }
    }
    
    func UserNickUpdate(token: String, nick: String, completion: @escaping (NetworkResult<UserNickUpdateRespone>) -> Void) {
        let url = APIConstants.usernickupdateURL
        let header: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(token)"
        ]
        
        let body: [String: Any] = [
            "edit_nick": nick
        ]
        
        AF.request(url, method: .put, parameters: body, encoding: JSONEncoding.default, headers: header)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    if let jsonString = String(data: data, encoding: .utf8) {
                        print("서버 응답 JSON: \(jsonString)")
                    }
                    
                    do {
                        let decodedData = try JSONDecoder().decode(UserNickUpdateRespone.self, from: data)
                        completion(.success(decodedData))
                    } catch {
                        print("JSON 디코딩 오류: \(error.localizedDescription)")
                    }
                    
                case .failure(let error):
                    print("네트워크 요청 실패: \(error.localizedDescription)")
                }
            }
    }
    
    func UserTagAdd(token: String, userId: Int, hashtags: [Int], completion: @escaping (NetworkResult<UsertagAddResponse>) -> Void) {
        let url = APIConstants.usertagURL
        let header: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(token)"
        ]
        
        let body: [String: Any] = [
            "userId": userId,
            "hashtags": hashtags
        ]
        
        AF.request(url, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    if let jsonString = String(data: data, encoding: .utf8) {
                        print("서버 응답 JSON: \(jsonString)")
                    }
                    
                    do {
                        let decodedData = try JSONDecoder().decode(UsertagAddResponse.self, from: data)
                        completion(.success(decodedData))
                    } catch {
                        print("JSON 디코딩 오류: \(error.localizedDescription)")
                    }
                    
                case .failure(let error):
                    print("네트워크 요청 실패: \(error.localizedDescription)")
                }
            }
    }
    
    func UserTagRemove(token: String, userId: Int, hashtags: [Int], completion: @escaping (NetworkResult<UsertagRemoveResponse>) -> Void) {
        let url = APIConstants.usertagURL
        let header: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(token)"
        ]
        
        let body: [String: Any] = [
            "userId": userId,
            "hashtags": hashtags
        ]
        
        AF.request(url, method: .delete, parameters: body, encoding: JSONEncoding.default, headers: header)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    if let jsonString = String(data: data, encoding: .utf8) {
                        print("서버 응답 JSON: \(jsonString)")
                    }
                    
                    do {
                        let decodedData = try JSONDecoder().decode(UsertagRemoveResponse.self, from: data)
                        completion(.success(decodedData))
                    } catch {
                        print("JSON 디코딩 오류: \(error.localizedDescription)")
                    }
                    
                case .failure(let error):
                    print("네트워크 요청 실패: \(error.localizedDescription)")
                }
            }
    }
}
