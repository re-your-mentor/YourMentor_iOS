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
                                HashtagSelectionView()
                                    .frame(minHeight: 160)
                            }
                            Divider()
                            TextField("내용을 입력해주세요.", text: $content)
                                .font(.system(size: 15, weight: .medium))
                        }
                        .frame(width: 300)
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
            .frame(width: 300)
        }
    }
}

import SwiftUI

struct HashtagSelectionView: View {
    let hashtags = ["전체", "Android", "Server", "iOS", "Web", "Embedded", "Kotlin", "Java", "Swift", "JavaScript", "Arduino", "Figma", "협업", "프로젝트"]
    @State private var selectedHashtags: Set<String> = []

    var body: some View {
        VStack(spacing: 10) {
            FlowLayout(tags: hashtags, spacing: 10) { hashtag in
                Button(action: {
                    toggleSelection(for: hashtag)
                }) {
                    Text(hashtag)
                        .font(.system(size: 15, weight: .medium))
                        .padding(.vertical, 8)
                        .padding(.horizontal, 10)
                        .background(
                            RoundedRectangle(cornerRadius: 30)
                                .fill(selectedHashtags.contains(hashtag) ? Color.gray.opacity(0.2) : Color.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(selectedHashtags.contains(hashtag) ? Color.clear : Color.gray, lineWidth: 0.5)
                                )
                        )
                        .foregroundColor(selectedHashtags.contains(hashtag) ? Color.gray : Color.gray.opacity(0.7))
                }
            }
        }
    }

    private func toggleSelection(for hashtag: String) {
        if selectedHashtags.contains(hashtag) {
            selectedHashtags.remove(hashtag)
        } else {
            selectedHashtags.insert(hashtag)
        }
    }
}

struct FlowLayout<Tag: Hashable, Content: View>: View {
    let tags: [Tag]
    let spacing: CGFloat
    let content: (Tag) -> Content

    init(tags: [Tag], spacing: CGFloat, @ViewBuilder content: @escaping (Tag) -> Content) {
        self.tags = tags
        self.spacing = spacing
        self.content = content
    }

    var body: some View {
        GeometryReader { geometry in
            self.generateContent(in: geometry)
        }
    }

    private func generateContent(in geometry: GeometryProxy) -> some View {
        var currentX: CGFloat = 0
        var currentY: CGFloat = 0

        return ZStack(alignment: .topLeading) {
            ForEach(tags.indices, id: \.self) { index in
                content(tags[index])
                    .alignmentGuide(.leading) { dimension in
                        if abs(currentX - dimension.width) > geometry.size.width {
                            currentX = 0
                            currentY -= dimension.height + spacing
                        }
                        let result = currentX
                        if index == tags.indices.last {
                            currentX = 0
                        } else {
                            currentX -= dimension.width + spacing
                        }
                        return result
                    }
                    .alignmentGuide(.top) { _ in
                        let result = currentY
                        if index == tags.indices.last {
                            currentY = 0
                        }
                        return result
                    }
            }
        }
    }
}
//
//#Preview {
//    HashtagSelectionView()
//}

#Preview {
    UploadView()
}
