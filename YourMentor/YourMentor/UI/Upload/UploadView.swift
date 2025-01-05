//
//  UploadView.swift
//  YourMentor
//
//  Created by 이다경 on 1/5/25.
//

import SwiftUI

struct UploadView: View {
    @State private var tag: String = ""
    @State private var nicname: String = ""
    @State private var title: String = ""
    @State private var content: String = ""
    
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .frame(maxWidth: .infinity)
                    .frame(height: 200)
                    .foregroundColor(.back)
                Rectangle()
                    .frame(maxWidth: .infinity)
                    .frame(height: 200)
                    .foregroundColor(.gray.opacity(0.3))
                    .padding(.horizontal, 25)
                VStack {
                    Image(systemName: "photo.badge.plus")
                        .resizable()
                        .frame(maxWidth: 105, maxHeight: 75)
                    Text("이미지 업로드하기")
                        .fontWeight(.bold)
                }
                .foregroundColor(.gray)
            }
            VStack(spacing: 10) {
                VStack(alignment: .leading) {
                    TextField("제목을 입력해주세요.", text: $title)
                    Text("\(title.count)/40자")
                        .foregroundColor(title.count > 40 ? .red : .gray)
                }
                .font(.system(size: 17, weight: .bold))
                TextField("태그를 입력해주세요.", text: $tag)
                    .padding(.leading)
                    .padding(.vertical, 13)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.back)
                    )
                TextField("닉네임을 입력해주세요.", text: $nicname)
                Divider()
                TextField("내용을 입력해주세요.", text: $content)
            }
            .padding(.horizontal, 25)
            .padding(.vertical, 30)
            Spacer()
            Button {
                
            } label: {
                Text("업로드 하기")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(
                        RoundedRectangle(cornerRadius: 30)
                            .fill(.email)
                    )
            }
            .padding(.horizontal, 25)
            .padding(.bottom)
        }
    }
}

#Preview {
    UploadView()
}
