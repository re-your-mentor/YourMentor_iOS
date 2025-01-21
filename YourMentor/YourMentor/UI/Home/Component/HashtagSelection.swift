//
//  HashtagSelectionView.swift
//  YourMentor
//
//  Created by 이다경 on 1/22/25.
//

import SwiftUI

struct HashtagSelection: View {
    let hashtags = ["전체", "Android", "Server", "iOS", "Web", "Embedded", "Kotlin", "Java", "Swift", "JavaScript", "Arduino", "Figma", "협업", "프로젝트"]
    @Binding var selectedHashtags: Set<String>


    var body: some View {
        VStack(spacing: 10) {
            FlowLayout(tags: hashtags, spacing: 7) { hashtag in
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
