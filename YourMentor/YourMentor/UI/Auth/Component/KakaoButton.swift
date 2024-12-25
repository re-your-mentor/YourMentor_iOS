//
//  Button.swift
//  YourMentor
//
//  Created by 이다경 on 12/25/24.
//

import SwiftUI

struct KakaoButton: View {
    var auth: String
    
    var body: some View {
        HStack(spacing: 15) {
            Image("KakaoLogo")
            Text("Kakao "+auth)
                .font(.system(size: 14).bold())
        }
        .frame(maxWidth: .infinity)
        .frame(height: 50)
        .background(Color.kakao)
        .cornerRadius(30)
        .padding(.horizontal)
    }
}

#Preview {
    KakaoButton(auth: "signup")
}
