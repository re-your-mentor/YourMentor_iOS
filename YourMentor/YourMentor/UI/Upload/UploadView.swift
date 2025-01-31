//
//  UploadView.swift
//  YourMentor
//
//  Created by 이다경 on 1/5/25.
//

import SwiftUI
import PhotosUI

struct UploadView: View {
    @State private var tag: String = ""
    @State private var title: String = ""
    @State private var content: String = ""
    @State private var selectedHashtags: Set<String> = []
    
    @State private var selectedImage: UIImage?
    @State private var showingImagePicker = false
    @State private var uploadedImageURL: String?
    
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        VStack {
            ZStack(alignment: .top) {
                ScrollView(showsIndicators: false) {
                    VStack {
                        VStack(spacing: 0) {
                            Spacer().frame(height: 55)
                            
                            Button {
                                showingImagePicker = true
                            } label: {
                                if let selectedImage = selectedImage {
                                    Image(uiImage: selectedImage)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(height: 200)
                                        .clipped()
                                        .cornerRadius(10)
                                } else {
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
                                    .background(Rectangle().foregroundColor(.gray.opacity(0.3)))
                                }
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
                ImgUpload()
            } label: {
                Text("업로드 하기")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(
                        RoundedRectangle(cornerRadius: 30)
                            .fill(.main)
                    )
            }
            .padding(.bottom)
            .frame(maxWidth: 300)
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $selectedImage)
        }
    }
    
    private func ImgUpload() {
        guard let image = selectedImage else { return }
        Service.shared.uploadimage(image) { result in
            switch result {
            case .success(let imageName):
                uploadedImageURL = imageName
            case .requestErr(let message):
                alertMessage = message as? String ?? "오류가 발생했습니다."
                showAlert = true
            case .pathErr:
                alertMessage = "잘못된 경로 요청입니다."
                showAlert = true
            case .serverErr:
                alertMessage = "서버 오류가 발생했습니다."
                showAlert = true
            case .networkFail:
                alertMessage = "네트워크 연결에 실패했습니다."
                showAlert = true
            }
        }
    }
}

#Preview {
    UploadView()
}
