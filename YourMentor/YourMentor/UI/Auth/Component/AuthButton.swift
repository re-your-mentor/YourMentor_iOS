//
//  Button.swift
//  YourMentor
//
//  Created by 이다경 on 12/25/24.
//

import SwiftUI

struct AuthButton: View {
    var text: String
    
    var body: some View {
        VStack {
            Text(text)
                .font(.system(size: 16).bold())
                .foregroundStyle(.white)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 50)
        .background(Color.main)
        .cornerRadius(30)
        .padding(.horizontal)
    }
}

#Preview {
    AuthButton(text: "next")
}
