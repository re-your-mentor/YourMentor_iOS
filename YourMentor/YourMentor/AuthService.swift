//
//  AuthService.swift
//  YourMentor
//
//  Created by 이다경 on 1/25/25.
//

import Foundation
import Alamofire

class AuthService {
    
    static let shared = AuthService()
    private init() {}
    
    func join(email: String, nick: String, password: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        let url = APIConstants.joinURL
        let header: HTTPHeaders = ["Content-Type": "application/json"]
        
        let body: Parameters = [
            "email": email,
            "nick": nick,
            "password": password
        ]
        
        let dataRequest = AF.request(url,
                                     method: .post,
                                     parameters: body,
                                     encoding: JSONEncoding.default,
                                     headers: header)
        
        dataRequest.responseData { response in
            switch response.result {
            case .success(let data):
                guard let statusCode = response.response?.statusCode else {
                    completion(.pathErr)
                    return
                }
                
                if (200...299).contains(statusCode) {
                    do {
                        let decoder = JSONDecoder()
                        let decodedData = try decoder.decode(JoinResponse.self, from: data)
                        
                        completion(.success(decodedData))
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
            case .failure:
                completion(.networkFail)
            }
        }
    }
    
    func login(email: String, password: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        let url = APIConstants.loginURL
        let header: HTTPHeaders = ["Content-Type": "application/json"]
        
        let body: Parameters = [
            "email": email,
            "password": password
        ]
        
        let dataRequest = AF.request(url,
                                     method: .post,
                                     parameters: body,
                                     encoding: JSONEncoding.default,
                                     headers: header)
        
        dataRequest.responseData { response in
            switch response.result {
            case .success(let data):
                guard let statusCode = response.response?.statusCode else {
                    completion(.pathErr)
                    return
                }
                
                if (200...299).contains(statusCode) {
                    do {
                        let decoder = JSONDecoder()
                        let decodedData = try decoder.decode(LoginResponse.self, from: data)
                        
                        if let token = decodedData.token as? String{
                            self.savetokentokeychain(token)
                        }
                        
                        completion(.success(decodedData))
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
            case .failure:
                completion(.networkFail)
            }
        }
    }

    
    func logout(completion: @escaping (NetworkResult<Any>) -> Void) {
        let url = APIConstants.logoutURL
        let header: HTTPHeaders = ["Content-Type": "application/json"]
        
        let dataRequest = AF.request(url,
                                     method: .get,
                                     headers: header)
        
        dataRequest.responseData { response in
            switch response.result {
            case .success(let data):
                guard let statusCode = response.response?.statusCode else { return }
                
                if (200...299).contains(statusCode) {
                    completion(.success("로그아웃 성공"))
                } else {
                    if let responseString = String(data: data, encoding: .utf8) {
                        completion(.requestErr(responseString))
                    } else {
                        completion(.pathErr)
                    }
                }
            case .failure:
                completion(.networkFail)
            }
        }
    }
    
    func kakaologin(completion: @escaping (NetworkResult<Any>) -> Void) {
        let url = APIConstants.kakaoURL
        let header: HTTPHeaders = ["Content-Type": "application/json"]
        
        let dataRequest = AF.request(url,
                                     method: .get,
                                     headers: header)
        
        dataRequest.responseData { response in
            switch response.result {
            case .success(let data):
                guard let statusCode = response.response?.statusCode else { return }
                
                if (200...299).contains(statusCode) {
                    completion(.success("카카오톡 로그인 요청"))
                } else {
                    if let responseString = String(data: data, encoding: .utf8) {
                        completion(.requestErr(responseString))
                    } else {
                        completion(.pathErr)
                    }
                }
            case .failure:
                completion(.networkFail)
            }
        }
    }
    
    func googlelogin(completion: @escaping (NetworkResult<Any>) -> Void) {
        let url = APIConstants.googleURL
        let header: HTTPHeaders = ["Content-Type": "application/json"]
        
        let dataRequest = AF.request(url,
                                     method: .get,
                                     headers: header)
        
        dataRequest.responseData { response in
            switch response.result {
            case .success(let data):
                guard let statusCode = response.response?.statusCode else { return }
                
                if (200...299).contains(statusCode) {
                    completion(.success("구글 로그인 요청"))
                } else {
                    if let responseString = String(data: data, encoding: .utf8) {
                        completion(.requestErr(responseString))
                    } else {
                        completion(.pathErr)
                    }
                }
            case .failure:
                completion(.networkFail)
            }
        }
    }
    
    func savetokentokeychain(_ token: String) {
        let keychainQuery: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "jwtToken",
            kSecValueData as String: token.data(using: .utf8)!
        ]
        
        var itemCopy: AnyObject?
        let status = SecItemCopyMatching(keychainQuery as CFDictionary, &itemCopy)
        
        if status == errSecSuccess {
            let updateQuery: [String: Any] = [
                kSecValueData as String: token.data(using: .utf8)!
            ]
            
            let updateStatus = SecItemUpdate(keychainQuery as CFDictionary, updateQuery as CFDictionary)
            
            if updateStatus != errSecSuccess {
                print("Keychain update failed with status: \(updateStatus)")
            }
        } else {
            let addStatus = SecItemAdd(keychainQuery as CFDictionary, nil)
            
            if addStatus != errSecSuccess {
                print("Keychain add failed with status: \(addStatus)")
            }
        }
    }

}
