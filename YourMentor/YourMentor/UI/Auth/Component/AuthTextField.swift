//
//  SignupField.swift
//  YourMentor
//
//  Created by 이다경 on 12/25/24.
//

import SwiftUI

struct AuthTextField: View {
    @Binding var text: String
    var placeholder: String
    var imageName: String
    var title: String
    
    var body: some View {
        VStack {
            HStack {
                TextField(placeholder, text: $text)
                    .font(.system(size: 13))
                    .autocapitalization(.none)
                    .padding(.leading, 5)
                Image(systemName: imageName)
                    .foregroundColor(.gray)
                    .padding(.trailing, 5)
            }
            .padding(.horizontal)
            .padding(.vertical, 13)
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(Color.gray.opacity(0.5), lineWidth: 1.5)
            )
            .overlay(
                VStack {
                    HStack {
                        Text(title)
                            .padding(.horizontal, 7)
                            .font(.system(size: 12))
                            .bold()
                            .foregroundStyle(.gray)
                            .background(.white)
                            .padding(.leading, 25)
                        Spacer()
                    }
                    .offset(y: -7)
                    Spacer()
                }
            )
        }
        .padding(.horizontal)
    }
}

#Preview {
    SignupView()
}
