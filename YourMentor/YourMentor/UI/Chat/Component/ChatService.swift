//
//  ChatService.swift
//  YourMentor
//
//  Created by 이다경 on 3/23/25.
//

import Foundation
import Alamofire
import UIKit

class ChatService {
    
    static let shared = ChatService()
    private init() {}
    
    func Chatroomadd(name: String, description: String, token: String, hashtags: [Int], completion: @escaping (NetworkResult<ChatroomResponse>) -> Void) {
        let url = APIConstants.chatroomURL
        let header: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(token)"
        ]

        let body: [String: Any] = [
            "name": name,
            "description": description,
            "hashtags": hashtags
        ]

        AF.request(url, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    print("서버 응답: \(String(data: data, encoding: .utf8) ?? "데이터 없음")")

                    guard let statusCode = response.response?.statusCode else {
                        completion(.pathErr)
                        return
                    }

                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase

                        if (200...299).contains(statusCode) {
                            let responseData = try decoder.decode(ChatroomResponse.self, from: data)
                            completion(.success(responseData))
                        } else if statusCode == 400 {
                            if let responseMessage = String(data: data, encoding: .utf8), responseMessage.contains("You already have a room") {
                                completion(.requestErr("이미 존재하는 채팅방입니다."))
                            } else {
                                completion(.requestErr("잘못된 요청입니다."))
                            }
                        } else {
                            completion(.requestErr("서버 오류: \(statusCode)"))
                        }
                    } catch {
                        print("JSON 디코딩 오류: \(error.localizedDescription)")
                        completion(.pathErr)
                    }

                case .failure(let error):
                    print("네트워크 요청 실패: \(error.localizedDescription)")
                    completion(.networkFail)
                }
            }
    }
    
    func Chatroomlist(token: String, completion: @escaping (NetworkResult<Chatroom>) -> Void) {
        let url = APIConstants.chatroomURL
        let header: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(token)"
        ]
        
        AF.request(url, method: .get, headers: header).responseDecodable(of: Chatroom.self) { response in
            switch response.result {
            case .success(let chatroom):
                completion(.success(chatroom))
            case .failure(let error):
                if let data = response.data, let jsonString = String(data: data, encoding: .utf8) {
                    print("서버 응답 JSON: \(jsonString)")
                }
                print("채팅방 목록 조회 실패: \(error.localizedDescription)")
                completion(.networkFail)
            }
        }
    }


}
