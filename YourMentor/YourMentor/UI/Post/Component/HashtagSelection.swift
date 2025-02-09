//
//  HashtagSelectionView.swift
//  YourMentor
//
//  Created by 이다경 on 1/22/25.
//

import SwiftUI

struct HashtagSelection: View {
    let Hashtags = [
        hashtags(id: 1, name: "Android"),
        hashtags(id: 2, name: "Server"),
        hashtags(id: 3, name: "iOS"),
        hashtags(id: 4, name: "Web"),
        hashtags(id: 5, name: "Embedded"),
        hashtags(id: 6, name: "Kotlin"),
        hashtags(id: 7, name: "Java"),
        hashtags(id: 8, name: "Swift"),
        hashtags(id: 9, name: "JavaScript"),
        hashtags(id: 10, name: "Arduino"),
        hashtags(id: 11, name: "Figma"),
        hashtags(id: 12, name: "협업"),
        hashtags(id: 13, name: "프로젝트")
    ]
    @Binding var selectedHashtags: Set<Int>
    
    
    var body: some View {
        VStack(spacing: 10) {
            FlowLayout(tags: Hashtags, spacing: 7) { hashtag in
                Button(action: {
                    toggleSelection(for: hashtag)
                }) {
                    Text(hashtag.name)
                        .font(.system(size: 15, weight: .medium))
                        .padding(.vertical, 8)
                        .padding(.horizontal, 10)
                        .background(
                            RoundedRectangle(cornerRadius: 30)
                                .fill(selectedHashtags.contains(hashtag.id) ? Color.gray.opacity(0.2) : Color.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(selectedHashtags.contains(hashtag.id) ? Color.clear : Color.gray, lineWidth: 0.5)
                                )
                        )
                        .foregroundColor(selectedHashtags.contains(hashtag.id) ? Color.gray : Color.gray.opacity(0.7))
                }
            }
        }
    }
    
    private func toggleSelection(for hashtag: hashtags) {
        if selectedHashtags.contains(hashtag.id) {
            selectedHashtags.remove(hashtag.id)
        } else {
            selectedHashtags.insert(hashtag.id)
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
