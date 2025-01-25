//
//  MyProfileEditView.swift
//  YourMentor
//
//  Created by 이다경 on 1/22/25.
//

import SwiftUI

struct MyEditView: View {
    @State var newnickname: String = ""
    @State private var selectedHashtags: Set<String> = []
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.back.ignoresSafeArea()
            
            VStack {
                
                Spacer()
                    .frame(height: 55)
                MyProfile()
                    .frame(maxWidth: 135)
                    .padding(.top, 45)
                
                VStack(alignment: .leading) {
                    Text("닉네임 작성")
                        .font(.system(size: 16, weight: .semibold))
                    TextField("이름을 입력해주세요.", text: $newnickname)
                        .autocapitalization(.none)
                        .padding(.leading)
                    Rectangle()
                        .frame(maxWidth: .infinity)
                        .frame(height: 1)
                }
                .frame(maxWidth: 295)
                .foregroundColor(.gray.opacity(0.6))
                .padding(.top, 40)
                
                VStack(alignment: .leading) {
                    Text("내가 선택한 관심 태그")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.gray.opacity(0.6))
                    HashtagSelection(selectedHashtags: $selectedHashtags)
                        .frame(maxHeight: 200)
                }
                .frame(maxWidth: 295)
                .padding(.top, 30)
                
                Spacer()
                
                Button {
                    
                } label: {
                    Text("수정하기")
                        .foregroundColor(.white)
                        .font(.system(size: 16, weight: .bold))
                        .frame(maxWidth: 295)
                        .frame(height: 50)
                        .background(
                            RoundedRectangle(cornerRadius: 30)
                                .fill(.main)
                        )
                }
            }
            HeadView()
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    MyEditView()
}
