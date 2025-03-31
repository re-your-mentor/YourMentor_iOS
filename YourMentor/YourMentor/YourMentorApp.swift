//
//  YourMentorApp.swift
//  YourMentor
//
//  Created by 이다경 on 12/24/24.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth

@main
struct YourMentorApp: App {
    init() {
        KakaoSDK.initSDK(appKey: "b49a35c093e311cea0ca4f6c7374be85")
    }
    var body: some Scene {
        WindowGroup {
            LoginView()
                .onOpenURL { url in
                    if AuthApi.isKakaoTalkLoginUrl(url) {
                        AuthController.handleOpenUrl(url: url)
                    }
                }
        }
    }
}
