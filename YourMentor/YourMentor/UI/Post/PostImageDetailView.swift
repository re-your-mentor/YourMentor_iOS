//
//  PostImageDetailVIew.swift
//  YourMentor
//
//  Created by 이다경 on 2/6/25.
//

import SwiftUI

struct PostImageDetailView: View {
    @Environment(\.dismiss) private var dismiss
    var img: String?

    var body: some View {
        ZStack {
            Color.black
                .opacity(0.8)
                .ignoresSafeArea()
            VStack {
                if let img = img, !img.isEmpty, let url = URL(string: img) {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(height: 200)
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(height: 10)
                        case .failure:
                            Color.notimage
                                .frame(height: 200)
                        @unknown default:
                            Color.notimage
                                .frame(height: 200)
                        }
                    }
                } else {
                    Color.notimage
                        .frame(height: 200)
                }
            }
            VStack {
                HStack {
                    Spacer()
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 20, height: 20)
                            .padding(.trailing, 25)
                    }
                }
                Spacer()
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    PostImageDetailView()
}
