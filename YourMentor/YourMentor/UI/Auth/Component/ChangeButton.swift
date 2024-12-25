//
//  ChangeButton.swift
//  YourMentor
//
//  Created by 이다경 on 12/25/24.
//

import SwiftUI

struct ChangeButton: View {
    var auth: String
    
    var body: some View {
        VStack {
            Text(auth)
                .font(.system(size: 14))
                .fontWeight(.semibold)
                .foregroundStyle(.black)
        }
        .padding(.horizontal)
        .padding(.vertical, 7)
        .overlay(
            RoundedRectangle(cornerRadius: 30)
                .stroke(Color.gray.opacity(0.5), lineWidth: 1.5)
        )
    }
}

#Preview {
    ChangeButton(auth: "Sign up")
}
