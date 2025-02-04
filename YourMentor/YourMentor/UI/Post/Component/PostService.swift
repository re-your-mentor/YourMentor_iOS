//
//  Service.swift
//  YourMentor
//
//  Created by 이다경 on 1/30/25.
//

import Foundation
import Alamofire
import UIKit

class PostService {
    
    static let shared = PostService()
    private init() {}
    
    func Imageupload(_ image: UIImage, token: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        let url = APIConstants.imguploadURL
        let header: HTTPHeaders = [
            "Content-Type": "multipart/form-data",
            "Authorization": "Bearer \(token)"
        ]
        
        AF.upload(multipartFormData: { multipartFormData in
            if let imageData = image.jpegData(compressionQuality: 0.8) {
                multipartFormData.append(imageData,
                                         withName: "img",
                                         fileName: "img.jpg",
                                         mimeType: "img/jpeg")
            }
        }, to: url, headers: header)
        .responseData { response in
            switch response.result {
            case .success(let data):
                guard let statusCode = response.response?.statusCode else {
                    completion(.pathErr)
                    return
                }
                
                if (200...299).contains(statusCode) {
                    do {
                        let decoder = JSONDecoder()
                        let decodedData = try decoder.decode(ImageUploadResponse.self, from: data)
                        if decodedData.success {
                            completion(.success(decodedData.img))
                        } else {
                            completion(.requestErr("이미지 업로드 실패"))
                        }
                    } catch {
                        completion(.pathErr)
                    }
                } else {
                    do {
                        let decoder = JSONDecoder()
                        let decodedError = try decoder.decode(ErrorResponse.self, from: data)
                        completion(.requestErr(decodedError.message))
                    } catch {
                        completion(.pathErr)
                    }
                }

            case .failure(let error):
                if let errorResponse = response.data {
                    do {
                        let decoder = JSONDecoder()
                        let decodedError = try decoder.decode(ErrorResponse.self, from: errorResponse)
                        completion(.requestErr(decodedError.message))
                    } catch {
                        completion(.networkFail)
                    }
                } else {
                    completion(.networkFail)
                }
            }
        }
    }
    
    func PostcreateWithoutImage(title: String, content: String, token: String, completion: @escaping (NetworkResult<PostCreateResponse>) -> Void) {
        let url = APIConstants.postURL
        let header: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(token)"
        ]
        
        let body: [String: Any] = [
            "title": title,
            "content": content
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

                    if (200...299).contains(statusCode) {
                        do {
                            let decoder = JSONDecoder()
                            let responseData = try decoder.decode(PostCreateResponse.self, from: data)
                            completion(.success(responseData))
                        } catch {
                            print("JSON 디코딩 오류: \(error)")
                            completion(.pathErr)
                        }
                    } else {
                        completion(.requestErr("서버 오류: \(statusCode)"))
                    }
                case .failure(let error):
                    print("네트워크 요청 실패: \(error.localizedDescription)")
                    completion(.networkFail)
                }
            }
    }

    func PostcreateWithImage(title: String, content: String, image: UIImage, token: String, completion: @escaping (NetworkResult<PostCreateResponse>) -> Void) {
        Imageupload(image, token: token) { result in
            switch result {
            case .success(let imgURL):
                let url = APIConstants.postURL
                let header: HTTPHeaders = [
                    "Content-Type": "application/json",
                    "Authorization": "Bearer \(token)"
                ]
                
                let body: [String: Any] = [
                    "title": title,
                    "content": content,
                    "img": imgURL
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

                            if (200...299).contains(statusCode) {
                                do {
                                    let decoder = JSONDecoder()
                                    let responseData = try decoder.decode(PostCreateResponse.self, from: data)
                                    completion(.success(responseData))
                                } catch {
                                    print("JSON 디코딩 오류: \(error)")
                                    if let jsonString = String(data: data, encoding: .utf8) {
                                        print("원본 JSON: \(jsonString)")
                                    }
                                    completion(.pathErr)
                                }
                            } else {
                                completion(.requestErr("서버 오류: \(statusCode)"))
                            }
                        case .failure(let error):
                            print("네트워크 요청 실패: \(error.localizedDescription)")
                            completion(.networkFail)
                        }
                    }

            case .requestErr(let message):
                completion(.requestErr(message))
            case .pathErr:
                completion(.pathErr)
            case .networkFail:
                completion(.networkFail)
            case .serverErr:
                completion(.serverErr)
            }
        }
    }
    
    func Postcreate(title: String, content: String, image: UIImage?, token: String, completion: @escaping (NetworkResult<PostCreateResponse>) -> Void) {
        if let image = image {
            PostcreateWithImage(title: title, content: content, image: image, token: token, completion: completion)
        } else {
            PostcreateWithoutImage(title: title, content: content, token: token, completion: completion)
        }
    }
    
    func LoadtokenFromKeychain() -> String? {
        let keychainQuery: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "jwtToken",
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(keychainQuery as CFDictionary, &dataTypeRef)

        if status == errSecSuccess, let retrievedData = dataTypeRef as? Data {
            return String(data: retrievedData, encoding: .utf8)
        }
        return nil
    }
    
    
    func Postlist(completion: @escaping (NetworkResult<[Posts]>) -> Void) {
        let url = APIConstants.postlistURL
        let header: HTTPHeaders = ["Content-Type": "application/json"]

        AF.request(url, method: .get, headers: header).responseDecodable(of: [Posts].self) { response in
            switch response.result {
            case .success(let postList):
                completion(.success(postList))
            case .failure(let error):
                if let data = response.data, let jsonString = String(data: data, encoding: .utf8) {
                    print("서버 응답 JSON: \(jsonString)")
                }
                print("게시물 목록 조회 실패: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchPostDetail(postid: Int, completion: @escaping (NetworkResult<PostResponse>) -> Void) {
        let url = APIConstants.postdetailURL(id: postid)
        let header: HTTPHeaders = ["Content-Type": "application/json"]

        AF.request(url, method: .get, headers: header).responseDecodable(of: PostResponse.self) { response in
            switch response.result {
            case .success(let postDetail):
                completion(.success(postDetail))
            case .failure(let error):
                print("\(error.localizedDescription)")
//                completion("error")
            }
        }
    }
    
    
}
