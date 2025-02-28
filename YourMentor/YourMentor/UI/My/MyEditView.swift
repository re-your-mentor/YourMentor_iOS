//
//  MyProfileEditView.swift
//  YourMentor
//
//  Created by 이다경 on 1/22/25.
//

import SwiftUI
import PhotosUI

struct MyEditView: View {
    var newnickname: String
    var selectedHashtags: Set<Int>
    var profileImageURL: String
    
    @State private var showingImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var selectedImageFileName: String?
    
    @State private var editedNickname: String
    @State private var editedHashtags: Set<Int>
    @State private var isImageUpdated = false
    @State private var isUpdating = false
    
    let token = PostService.shared.LoadtokenFromKeychain()

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
                Spacer().frame(height: 55)
                
                if let selectedImage = selectedImage {
                    Image(uiImage: selectedImage)
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: 135, height: 135)
                        .padding(.top, 45)
                } else {
                    AsyncImage(url: URL(string: profileImageURL)) { image in
                        image.resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                            .frame(width: 135, height: 135)
                            .padding(.top, 45)
                    } placeholder: {
                        ProgressView()
                            .frame(maxWidth: 135)
                            .padding(.top, 45)
                    }
                }
                
                Button {
                    if isImageUpdated {
                        updateProfileImageToServer()
                    } else {
                        showingImagePicker = true
                    }
                } label: {
                    Text(isImageUpdated ? "확인" : "이미지변경")
                        .foregroundColor(.white)
                        .font(.system(size: 13, weight: .semibold))
                        .frame(height: 35)
                        .padding(.horizontal, 15)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.main)
                        )
                }
                .disabled(isUpdating)
                
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
                                .fill(Color.main)
                        )
                }
            }
            HeadView()
        }
        .navigationBarBackButtonHidden(true)
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $selectedImage, fileName: $selectedImageFileName)
        }
        .onChange(of: selectedImage) { newImage in
            if newImage != nil {
                isImageUpdated = true
            }
        }
    }
    
    private func updateProfileImageToServer() {
        guard let selectedImage = selectedImage, let fileName = selectedImageFileName else { return }
        isUpdating = true

        UserService.shared.UserProfileUpdate(token: token ?? "", profile_pic: fileName) { result in
            switch result {
            case .success(let response):
                print("프로필 이미지 업데이트 성공: \(response)")
                isImageUpdated = false
            default:
                print("프로필 이미지 업데이트 실패")
            }
            isUpdating = false
        }
    }
}
