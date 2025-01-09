//
//  InterestTagsView.swift
//  YourMentor
//
//  Created by 이다경 on 1/9/25.
//

import SwiftUI

struct InterestTagsView: View {
    @State private var selectedTags: Set<String> = []
    
    let tags = [
        "안드로이드", "서버", "iOS", "웹", "임베디드",
        "Kotlin", "Java", "Swift", "SwiftUI",
        "JavaScript", "Arduino", "Figma", "협업", "프로젝트"
    ]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("관심 태그를 선택해주세요!")
                    .font(.system(size: 22, weight: .bold))
                
                TagGridView(tags: tags, selectedTags: $selectedTags)
                
                Button(action: {
                    print("선택된 태그: \(selectedTags)")
                }) {
                    Text("선택 완료")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(selectedTags.isEmpty ? Color.gray : Color.blue)
                        .cornerRadius(10)
                }
                .disabled(selectedTags.isEmpty)
                .padding(.horizontal, 20)
            }
            .padding()
        }
    }
}

struct TagGridView: View {
    let tags: [String]
    @Binding var selectedTags: Set<String>
    
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 3), spacing: 10) {
            ForEach(tags, id: \.self) { tag in
                TagButton(tag: tag, isSelected: selectedTags.contains(tag)) {
                    if selectedTags.contains(tag) {
                        selectedTags.remove(tag)
                    } else {
                        selectedTags.insert(tag)
                    }
                }
            }
        }
        .padding(.horizontal)
    }
}

struct TagButton: View {
    let tag: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(tag)
                .font(.system(size: 14, weight: .medium))
                .padding(.vertical, 7)
                .padding(.horizontal, 13)
                .background(
                    isSelected ? Color.main : Color.white
                )
                .foregroundColor(isSelected ? .white : .gray)
                .cornerRadius(15)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(isSelected ? Color.clear : Color.gray, lineWidth: 1)
                )
        }

    }
}

#Preview {
    InterestTagsView()
}
