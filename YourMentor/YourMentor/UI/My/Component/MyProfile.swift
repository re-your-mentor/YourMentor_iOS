//
//  Profile.swift
//  YourMentor
//
//  Created by 이다경 on 1/3/25.
//

import SwiftUI

struct MyProfile: View {
    var email: String
    
    var body: some View {
        VStack(spacing: 0) {
            Image("outprofile")
                .resizable()
                .renderingMode(.original)
                .clipShape(Circle())
                .frame(maxWidth: 145, maxHeight: 145)
            Text(email)
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(.white)
                .padding(.horizontal, 20)
                .background(
                    RoundedRectangle(cornerRadius: 30)
                        .foregroundColor(.email)
                        .frame(height: 40)
                )
        }
    }
}

#Preview {
    MyProfile(email: "wlals6691@gmail.com")
}
