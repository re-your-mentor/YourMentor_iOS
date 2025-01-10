//
//  Signup_Tag.swift
//  YourMentor
//
//  Created by 이다경 on 1/9/25.
//

import SwiftUI

struct Signup_Tag: View {
    @EnvironmentObject var userData: UserData
    @Environment(\.dismiss) private var dismiss
    @State private var selectedTags: Set<String> = []
    
    let primaryTags = [
        "안드로이드", "서버", "iOS", "웹", "임베디드",
        "Kotlin", "Java", "Swift", "SwiftUI",
        "JavaScript", "Arduino"
    ]
    let secondaryTags = [
        "Figma", "협업", "프로젝트"
    ]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 45) {
                Text("\(userData.nicname)님께서 편안한 멘토맨티 서비스를\n위해 관심있는 태그를 클릭해주세요!")
                    .font(.system(size: 21, weight: .semibold))
                
                TagGridView(tags: primaryTags, selectedTags: $selectedTags)
                TagGridView(tags: secondaryTags, selectedTags: $selectedTags)
                
                ZStack {
                    if !selectedTags.isEmpty {
                        NavigationLink(destination: SignupSuccessView()) {
                            Text("다음")
                                .font(.system(size: 15, weight: .black))
                                .foregroundStyle(.white)
                                .padding(.horizontal, 15)
                                .padding(.vertical, 7)
                                .background(
                                    RoundedRectangle(cornerRadius: 30)
                                        .fill(.main)
                                )
                        }
                    } else {
                        Text("")
                            .padding(.horizontal, 15)
                            .padding(.vertical, 7)
                    }
                }
                .frame(height: 44)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image("backbutton")
                            .resizable()
                            .frame(width: 12, height: 22)
                            .padding(.leading, 7)
                            .foregroundColor(.black)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct TagGridView: View {
    let tags: [String]
    @Binding var selectedTags: Set<String>
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ForEach(tags.chunked(into: 4), id: \.self) { chunk in
                HStack(spacing: 10) {
                    ForEach(chunk, id: \.self) { tag in
                        TagButton(tag: tag, isSelected: selectedTags.contains(tag)) {
                            if selectedTags.contains(tag) {
                                selectedTags.remove(tag)
                            } else {
                                selectedTags.insert(tag)
                            }
                        }
                    }
                }
            }
        }
        .padding(.horizontal)
    }
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        var chunkedArray: [[Element]] = []
        for i in stride(from: 0, to: count, by: size) {
            let chunk = Array(self[i..<Swift.min(i + size, count)])
            chunkedArray.append(chunk)
        }
        return chunkedArray
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
    Signup_Tag()
        .environmentObject(UserData())
}
