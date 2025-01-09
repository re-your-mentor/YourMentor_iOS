//
//  Button.swift
//  YourMentor
//
//  Created by 이다경 on 12/25/24.
//

import SwiftUI

struct KakaoButton: View {

    var body: some View {
        Image("KakaoLogo")
            .padding()
            .background(
                Circle()
                    .fill(.kakao)
            )
    }
}

#Preview {
    KakaoButton()
}
