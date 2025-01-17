//
//  HeadView.swift
//  YourMentor
//
//  Created by 이다경 on 1/17/25.
//

import SwiftUI

struct HeadView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image("backbutton")
                        .resizable()
                        .frame(width: 11, height: 20)
                        .padding(.leading, 30)
                }
                Spacer()
            }
        }
        .padding(.bottom, 20)
        .frame(maxWidth: .infinity)
        .frame(height: 70)
        .background(
            ZStack {
                Rectangle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [.black.opacity(0.3), .clear]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                Rectangle()
                    .fill(.white)
                    .padding(.bottom)
                    .ignoresSafeArea()
            }
        )
    }
}

#Preview {
    HeadView()
}
