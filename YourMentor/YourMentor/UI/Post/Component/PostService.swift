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
    
    func Imageupload(_ image: UIImage, token: String, completion: @escaping (NetworkResult<String>) -> Void) {
        let url = APIConstants.imguploadURL
        let header: HTTPHeaders = [
            "Content-Type": "multipart/form-data",
            "Authorization": "Bearer \(token)"
        ]
        
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            completion(.pathErr)
            return
        }
        
        let tempDirectory = FileManager.default.temporaryDirectory
        let fileURL = tempDirectory.appendingPathComponent("upload.jpg")
        
        do {
            try imageData.write(to: fileURL)
        } catch {
            print("이미지 파일 저장 오류: \(error)")
            completion(.pathErr)
            return
        }
        
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(fileURL, withName: "img", fileName: "upload.jpg", mimeType: "image/jpeg")
        }, to: url, headers: header)
        .responseDecodable(of: ImageUploadResponse.self) { response in
            switch response.result {
            case .success(let decodedData):
                if decodedData.success {
                    completion(.success(decodedData.img))
                } else {
                    completion(.requestErr("이미지 업로드 실패"))
                }
            case .failure(let error):
                print("네트워크 오류: \(error.localizedDescription)")
                if let data = response.data {
                    do {
                        let decodedError = try JSONDecoder().decode(ErrorResponse.self, from: data)
                        completion(.requestErr(decodedError.message))
                    } catch {
                        completion(.pathErr)
                    }
                } else {
                    completion(.networkFail)
                }
            }
        }
    }
    
    func PostcreateWithoutImage(title: String, content: String, token: String, hashtags: [Int], completion: @escaping (NetworkResult<PostCreateResponse>) -> Void) {
        let url = APIConstants.postURL
        let header: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(token)"
        ]
        
        let body: [String: Any] = [
            "title": title,
            "content": content,
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
    
    func PostcreateWithImage(title: String, content: String, image: UIImage, token: String, hashtags: [Int], completion: @escaping (NetworkResult<PostCreateResponse>) -> Void) {
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
                    "img": imgURL,
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
    
    func Postcreate(title: String, content: String, image: UIImage?, token: String, hashtags: [Int], completion: @escaping (NetworkResult<PostCreateResponse>) -> Void) {
        if let image = image {
            PostcreateWithImage(title: title, content: content, image: image, token: token, hashtags: hashtags, completion: completion)
        } else {
            PostcreateWithoutImage(title: title, content: content, token: token, hashtags: hashtags, completion: completion)
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
                let sortedPosts = postList.sorted { $0.createdAt > $1.createdAt }
                completion(.success(sortedPosts))
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
            }
        }
    }
    
    func Postedit(postID: Int, title: String, content: String, image: UIImage?, token: String, hashtags: [Int], completion: @escaping (NetworkResult<PostCreateResponse>) -> Void) {
        let updatePost: (String?) -> Void = { imageUrl in
            let url = "\(APIConstants.baseURL)/post/\(postID)"
            let headers: HTTPHeaders = [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(token)"
            ]
            
            let body: [String: Any] = [
                "title": title,
                "content": content,
                "img": imageUrl ?? NSNull(),
                "hashtags": hashtags
            ]
            
            AF.request(url, method: .put, parameters: body, encoding: JSONEncoding.default, headers: headers)
                .responseData { response in
                    switch response.result {
                    case .success(let data):
                        if let jsonString = String(data: data, encoding: .utf8) {
                            print("서버 응답: \(jsonString)")
                        }
                        
                        do {
                            let decodedData = try JSONDecoder().decode(PostCreateResponse.self, from: data)
                            completion(.success(decodedData))
                        } catch {
                            print("JSON 디코딩 오류: \(error.localizedDescription)")
                            completion(.pathErr)
                        }
                    case .failure(let error):
                        print("네트워크 오류: \(error.localizedDescription)")
                        if let data = response.data {
                            do {
                                let decodedError = try JSONDecoder().decode(ErrorResponse.self, from: data)
                                completion(.requestErr(decodedError.message))
                            } catch {
                                completion(.pathErr)
                            }
                        } else {
                            completion(.networkFail)
                        }
                    }
                }
        }
        
        if let image = image {
            Imageupload(image, token: token) { result in
                switch result {
                case .success(let imageUrl):
                    updatePost(imageUrl)
                default:
                    completion(.requestErr("이미지 업로드 실패"))
                }
            }
        } else {
            updatePost(nil)
        }
    }
    
    
    func Postdelete(postid: Int, token: String, completion: @escaping (NetworkResult<PostDeleteResponse>) -> Void) {
        let url = APIConstants.postdetailURL(id: postid)
        let header: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(token)"
        ]
        
        AF.request(url, method: .delete, headers: header).responseDecodable(of: PostDeleteResponse.self) { response in
            if let statusCode = response.response?.statusCode {
                print("응답 코드\n\(statusCode)")
            } else {
                print("응답 코드 없음")
            }
            
            if let responseData = response.data {
                let responseString = String(data: responseData, encoding: .utf8) ?? "응답 본문 디코딩 실패"
                print("응답 본문\n\(responseString)")
            } else {
                print("응답 본문 없음")
            }
            
            switch response.result {
            case .success(let postDelete):
                if !postDelete.success {
                    print("삭제 실패\n\(postDelete.message)")
                    completion(.requestErr(postDelete.message))
                    return
                }
                print("삭제 성공\n\(postDelete)")
                completion(.success(postDelete))
                
            case .failure(let error):
                print("네트워크 요청 실패\n\(error.localizedDescription)")
                
                if let statusCode = response.response?.statusCode {
                    switch statusCode {
                    case 400:
                        completion(.requestErr("잘못된 요청입니다."))
                    case 401:
                        completion(.requestErr("인증이 필요합니다."))
                    case 403:
                        completion(.requestErr("삭제 권한이 없습니다."))
                    case 404:
                        completion(.pathErr)
                    case 500...599:
                        completion(.serverErr)
                    default:
                        completion(.networkFail)
                    }
                } else {
                    completion(.networkFail)
                }
            }
        }
    }
    
}
