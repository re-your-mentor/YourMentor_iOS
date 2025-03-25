//
//  WebView.swift
//  YourMentor
//
//  Created by 이다경 on 3/11/25.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    @Binding var authCode: String?
    @Binding var isLoginSuccess: Bool

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}

    func makeCoordinator() -> Coordinator {
        return Coordinator(authCode: $authCode, isLoginSuccess: $isLoginSuccess)
    }

    class Coordinator: NSObject, WKNavigationDelegate {
        @Binding var authCode: String?
        @Binding var isLoginSuccess: Bool

        init(authCode: Binding<String?>, isLoginSuccess: Binding<Bool>) {
            _authCode = authCode
            _isLoginSuccess = isLoginSuccess
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            if let url = webView.url, url.absoluteString.contains("YOUR_REDIRECT_URI") {
                if let code = extractCode(from: url) {
                    authCode = code
                    isLoginSuccess = true
                }
            }
        }

        private func extractCode(from url: URL) -> String? {
            guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
                  let queryItems = components.queryItems else { return nil }
            return queryItems.first(where: { $0.name == "code" })?.value
        }
    }
}
