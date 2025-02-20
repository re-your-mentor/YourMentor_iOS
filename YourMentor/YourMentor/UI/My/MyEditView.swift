//
//  MyProfileEditView.swift
//  YourMentor
//
//  Created by 이다경 on 1/22/25.
//

import SwiftUI

struct MyEditView: View {
    var newnickname: String
        var selectedHashtags: Set<Int>
        var profileImageURL: String

        @State private var editedNickname: String
        @State private var editedHashtags: Set<Int>

        init(newnickname: String, selectedHashtags: Set<Int>, profileImageURL: String) {
            self.newnickname = newnickname
            self.selectedHashtags = selectedHashtags
            self.profileImageURL = profileImageURL
            
            _editedNickname = State(initialValue: newnickname)
            _editedHashtags = State(initialValue: selectedHashtags)
        }
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.back.ignoresSafeArea()
            
            VStack {
                
                Spacer()
                    .frame(height: 55)
                
//                Button {
//                    showingImagePicker = true
//                } label: {
//                    if let selectedImage = selectedImage {
//                        Image(uiImage: selectedImage)
//                            .resizable()
//                            .scaledToFill()
//                            .frame(height: 200)
//                            .clipped()
//                            .cornerRadius(10)
//                    } else {
//                        VStack {
//                            Image(systemName: "photo.badge.plus")
//                                .resizable()
//                                .frame(maxWidth: 105, maxHeight: 75)
//                            Text("이미지 업로드하기")
//                                .fontWeight(.bold)
//                        }
//                        .foregroundColor(.gray.opacity(0.5))
//                        .aspectRatio(contentMode: .fit)
//                        .clipShape(Circle())
//                        .background(Rectangle().foregroundColor(.gray.opacity(0.3)))
//                    }
//                }
                
                AsyncImage(url: URL(string: profileImageURL)) { image in
                                   image.resizable()
                                       .scaledToFill()
                                       .clipShape(Circle())
                                       .frame(width: 135, height: 135)
                               } placeholder: {
                                   ProgressView()
                               }
                               .frame(maxWidth: 135)
                               .padding(.top, 45)
//                MyProfile()
//                    .frame(maxWidth: 135)
//                    .padding(.top, 45)
                
                VStack(alignment: .leading) {
                    Text("닉네임 작성")
                        .font(.system(size: 16, weight: .semibold))
                    TextField("이름을 입력해주세요.", text: $editedNickname)
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
                    HashtagSelection(selectedHashtags: $editedHashtags)
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
//        .sheet(isPresented: $showingImagePicker) {
//            ImagePicker(image: $selectedImage)
//        }
    }
//    
//    private func Imageload(from url: String) {
//            guard let imageURL = URL(string: url) else { return }
//            
//            DispatchQueue.global(qos: .background).async {
//                if let imageData = try? Data(contentsOf: imageURL), let uiImage = UIImage(data: imageData) {
//                    DispatchQueue.main.async {
//                        self.profileImage = uiImage
//                    }
//                }
//            }
//        }
}
