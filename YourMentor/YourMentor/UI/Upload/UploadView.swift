//
//  UploadView.swift
//  YourMentor
//
//  Created by 이다경 on 1/5/25.
//

import SwiftUI

struct UploadView: View {
    @State private var tag: String = ""
    @State private var title: String = ""
    @State private var content: String = ""
    @State private var selectedHashtags: Set<String> = []

    
    var body: some View {
        VStack {
            ZStack(alignment: .top) {
                ScrollView(showsIndicators: false) {
                    VStack {
                        VStack(spacing: 0) {
                            Spacer()
                                .frame(height: 55)
                            Button {
                                
                            } label: {
                                VStack {
                                    Image(systemName: "photo.badge.plus")
                                        .resizable()
                                        .frame(maxWidth: 105, maxHeight: 75)
                                    Text("이미지 업로드하기")
                                        .fontWeight(.bold)
                                }
                                .foregroundColor(.gray.opacity(0.5))
                                .frame(maxWidth: .infinity)
                                .frame(height: 200)
                                .background(
                                    Rectangle()
                                        .foregroundColor(.gray.opacity(0.3))
                                )
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 30) {
                            VStack(alignment: .leading) {
                                TextField("제목을 입력해주세요.", text: $title)
                                    .autocapitalization(.none)
                                    .font(.system(size: 17))
                                Text("\(title.count)/40자")
                                    .foregroundColor(title.count > 40 ? .red : .gray.opacity(0.7))
                                    .font(.system(size: 14))
                            }
                            .fontWeight(.bold)
                            VStack(alignment: .leading) {
                                Text("#태그를 선택해주세요.")
                                    .font(.system(size: 15, weight: .semibold))
                                    .foregroundColor(.gray.opacity(0.7))
                                HashtagSelection(selectedHashtags: $selectedHashtags)
                                    .frame(minHeight: 160)
                            }
                            Divider()
                            TextField("내용을 입력해주세요.", text: $content)
                                .autocapitalization(.none)
                                .font(.system(size: 15, weight: .medium))
                        }
                        .frame(maxWidth: 300)
                        .padding(.vertical, 25)
                        Spacer()
                    }
                }
                HeadView()
            }
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
            .padding(.bottom)
            .frame(maxWidth: 300)
        }
    }
}

#Preview {
    UploadView()
}
