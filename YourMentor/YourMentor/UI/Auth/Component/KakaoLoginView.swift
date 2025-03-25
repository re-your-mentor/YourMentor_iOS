//
//  KakaoLoginView.swift
//  YourMentor
//
//  Created by 이다경 on 3/11/25.
//

import SwiftUI
import WebKit

struct KakaoLoginView: UIViewRepresentable {
    @Binding var isLoginSuccess: Bool
    @Binding var userId: Int?
    
    init(isLoginSuccess: Binding<Bool>, userId: Binding<Int?>) {
        self._isLoginSuccess = isLoginSuccess
        self._userId = userId
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        
        let loginURL = URL(string: "https://kauth.kakao.com/oauth/authorize?client_id=85c1c53c84f90c4bf17328e9561b3c40&redirect_uri=http://3.148.49.139:8000/auth/kakao/callback&response_type=code")!
        
        webView.load(URLRequest(url: loginURL))
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {}
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: KakaoLoginView
        
        init(_ parent: KakaoLoginView) {
            self.parent = parent
        }
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            if let url = navigationAction.request.url?.absoluteString, url.starts(with: "http://3.148.49.139:8000/auth/kakao/callback") {
                if let code = extractCode(from: url) {
                    print("인가 코드: \(code)")
                    requestAccessToken(authCode: code)
                }
                decisionHandler(.cancel)
                return
            }
            decisionHandler(.allow)
        }
        
        private func extractCode(from url: String) -> String? {
            guard let components = URLComponents(string: url),
                  let queryItems = components.queryItems else { return nil }
            return queryItems.first(where: { $0.name == "code" })?.value
        }
        
        private func requestAccessToken(authCode: String) {
            let url = URL(string: "https://kauth.kakao.com/oauth/token")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            
            let body = "grant_type=authorization_code&client_id=85c1c53c84f90c4bf17328e9561b3c40&redirect_uri=http://3.148.49.139:8000/auth/kakao/callback&code=\(authCode)&client_secret=TGhaSUeY85ZNjOBy81M6df6HSPRT2Nuz"
            
            request.httpBody = body.data(using: .utf8)
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    print("네트워크 요청 실패: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                
                if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    print("응답 JSON: \(json)")
                    
                    if let accessToken = json["access_token"] as? String {
                        print("Access Token: \(accessToken)")
//                        self.saveTokenToKeychain(accessToken)
                        self.fetchUserInfo(accessToken: accessToken) // 사용자 정보 요청
                    } else {
                        print("액세스 토큰 요청 실패: \(json)")
                    }
                } else {
                    print("JSON 파싱 실패")
                }
            }.resume()
        }
        
        private func fetchUserInfo(accessToken: String) {
            let url = URL(string: "https://kapi.kakao.com/v2/user/me")!
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")

            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    print("사용자 정보 요청 실패: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }

                if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    print("사용자 정보: \(json)")

                    if let kakaoId = json["id"] as? Int { // 카카오 snsId 추출
                        // 회원가입 또는 로그인 요청
                        self.registerUser(kakaoId: kakaoId, accessToken: accessToken) { success, userId in // userId를 registerUser에서 받아옴
                            if success, let userId = userId {
                                DispatchQueue.main.async {
                                    self.parent.isLoginSuccess = true
                                    self.parent.userId = userId // 서버에서 받은 userId 저장
                                }
                            } else {
                                print("회원가입/로그인 실패")
                                // 실패 처리 (예: 에러 메시지 표시)
                            }
                        }
                    } else {
                        print("사용자 ID 없음")
                    }
                } else {
                    print("사용자 정보 JSON 파싱 실패")
                }
            }.resume()
        }

        private func registerUser(kakaoId: Int, accessToken: String, completion: @escaping (Bool, Int?) -> Void) {
            let url = URL(string: "http://3.148.49.139:8000/auth/signup")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            let body: [String: Any] = [
                "snsId": kakaoId,
                "provider": "kakao",
                "nickname": "카카오사용자", // 실제 닉네임 값으로 수정 필요
                "profile_image": "기본이미지URL"
            ]

            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: body)
            } catch {
                print("JSON 변환 실패: \(error)")
                completion(false, nil) // 실패 시 userId를 nil로 전달
                return
            }

            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let httpResponse = response as? HTTPURLResponse,
                      let data = data,
                      error == nil else {
                    print("회원가입/로그인 네트워크 에러: \(error?.localizedDescription ?? "")")
                    completion(false, nil) // 실패 시 userId를 nil로 전달
                    return
                }

                if httpResponse.statusCode == 200 || httpResponse.statusCode == 201 { // 성공
                    if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                       let userId = json["userId"] as? Int {
                        completion(true, userId) // 성공 시 userId 전달
                    } else {
                        print("userId 추출 실패")
                        completion(false, nil) // 실패 시 userId를 nil로 전달
                    }
                } else if httpResponse.statusCode == 409 { // 이미 가입된 사용자
                     if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                        let userId = json["userId"] as? Int {
                        completion(true, userId) // 성공 시 userId 전달
                     } else {
                         print("userId 추출 실패 (기존 사용자)")
                         completion(false, nil) // 실패 시 userId를 nil로 전달
                     }

                } else {
                    print("회원가입/로그인 실패: \(httpResponse.statusCode)")
                    completion(false, nil) // 실패 시 userId를 nil로 전달
                }
            }.resume()
        }

    }
}
