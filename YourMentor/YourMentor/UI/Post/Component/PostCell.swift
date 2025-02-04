//
//  ListView.swift
//  YourMentor
//
//  Created by 이다경 on 12/29/24.
//

import SwiftUI

struct PostCell: View {
    var title: String
    var date: Date
    
    @State private var showMenu: Bool = false
    @State private var showAlert: Bool = false
    @State private var isSheetPresented: Bool = false
    
    var body: some View {
        VStack(spacing: 10) {
            VStack(spacing: 3) {
                HStack {
                    Text(title)
                        .font(.system(size: 14, weight: .semibold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Button(action: {
                        isSheetPresented.toggle()
                    }) {
                        Image(systemName: "ellipsis")
                            .resizable()
                            .frame(width: 11, height: 3)
                            .rotationEffect(.degrees(90))
                            .foregroundColor(.gray)
                            .padding(2)
                    }
                    .contentShape(Rectangle())
                }
                
                HStack(spacing: 1) {
                    Image(systemName: "clock")
                        .resizable()
                        .frame(maxWidth: 10, maxHeight: 10)
                    Text(formattedDate(date))
                        .font(.system(size: 10, weight: .semibold))
                }
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .foregroundColor(.black)
            .padding(.bottom, 10)
            
            HStack {
                HStack(spacing: 5) {
                    ForEach(0..<3, id: \.self) { _ in
                        Hashtag(title: "SwiftUI")
                    }
                }
                Spacer()
            }
        }
        .padding()
        .frame(maxWidth: 300)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray.opacity(0.5), lineWidth: 0.5)
                )
        )
        .sheet(isPresented: $isSheetPresented) {
                VStack {
                    Button("수정하기") {
                    }
                    .padding(7)
                    Divider()
                    Button("삭제하기") {
                        showAlert = true
                    }
                    .padding(7)
                }
                .foregroundColor(.gray)
                .presentationDetents([.height(100)])
            }
        .alert("정말로 게시물을 삭제하시겠습니까?", isPresented: $showAlert) {
            Button("네", role: .destructive) {
                
            }
            Button("아니요", role: .cancel) {
                
            }
        }
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter.string(from: date)
    }
}

#Preview {
    PostCell(title: "안드로이드 깃허브로 협업하는 방법에 대하여", date: Date())
}
