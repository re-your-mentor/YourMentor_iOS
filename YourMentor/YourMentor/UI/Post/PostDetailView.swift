//
//  PostDetailView.swift
//  YourMentor
//
//  Created by 이다경 on 1/5/25.
//

import SwiftUI

struct PostDetailView: View {
    var id: Int
    var title: String
    var date: Date
    var nickname: String
    var content: String
    var hashtag: [String]
    var img: String?
    
    @State private var postdetail: PostDetail?
    @State private var comments: [Comment] = []
    
    @State private var comment: String = ""
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    @State private var heartclick = false
    let token = PostService.shared.LoadtokenFromKeychain()
    
    var body: some View {
        ZStack(alignment: .top) {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    Spacer()
                        .frame(height: 55)
                    if let img = img, !img.isEmpty, let url = URL(string: img) {
                        AsyncImage(url: url) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .frame(height: 200)
                            case .success(let image):
                                NavigationLink(destination: PostImageDetailView(img: img)) {
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(height: 200)
                                        .clipped()
                                }
                            case .failure:
                                Color.notimage
                                    .frame(height: 200)
                            @unknown default:
                                Color.notimage
                                    .frame(height: 200)
                            }
                        }
                    } else {
                        Color.notimage
                            .frame(height: 200)
                    }
                    
                    VStack(spacing: 15) {
                        VStack {
                            VStack(spacing: 3) {
                                Text(title)
                                    .font(.system(size: 17, weight: .bold))
                                    .frame(maxWidth: .infinity, alignment: .leading)
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
                            HStack {
                                HStack(spacing: 5) {
                                    ForEach(hashtag, id: \.self) { tag in
                                        Hashtag(title: tag)
                                    }
                                }
                                Spacer()
                                Button {
                                    heartclick.toggle()
                                    saveHeartState()
                                    if heartclick {
                                        heartfill()
                                    } else {
                                        heartempty()
                                    }
                                } label: {
                                    if !heartclick {
                                        Image("emptyheart")
                                    } else {
                                        Image("fillheart")
                                    }
                                }
                            }
                        }
                        VStack(alignment: .leading, spacing: 5) {
                            HStack {
                                Text(nickname + "님의 작성글")
                                    .font(.system(size: 14, weight: .medium))
                                Spacer()
                            }
                            Divider()
                                .padding(.bottom, 10)
                            Text(content)
                                .font(.system(size: 15, weight: .medium))
                        }
                    }
                    .frame(maxWidth: 300)
                    .padding(.vertical, 25)
                    
                    Rectangle()
                        .frame(height: 7)
                        .foregroundColor(.back)
                    
                    VStack(spacing: 25) {
                        VStack(alignment: .leading) {
                            Text("댓글")
                                .font(.system(size: 13, weight: .medium))
                                .padding(.leading)
                            ZStack {
                                TextField("댓글을 작성해주세요.", text: $comment)
                                    .autocapitalization(.none)
                                    .font(.system(size: 14, weight: .medium))
                                    .frame(height: 45)
                                    .padding(.leading)
                                    .background(
                                        RoundedRectangle(cornerRadius: 20)
                                            .foregroundColor(.back)
                                    )
                                HStack {
                                    Spacer()
                                    Button {
                                        commentcreate()
                                    } label: {
                                        Image(systemName: "paperplane")
                                            .resizable()
                                            .frame(maxWidth: 15, maxHeight: 15)
                                            .foregroundColor(.gray)
                                            .padding(.trailing)
                                    }
                                }
                            }
                        }
                        VStack(alignment: .leading, spacing: 25) {
                            CommentSection(comments: comments, postId: id, fetchPostDetail: fetchPostDetail)
                        }
                    }
                    .frame(maxWidth: 300)
                    .padding(.top, 25)
                }
            }
            
            HeadView()
                .zIndex(1)
            
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            loadHeartState()
            fetchPostDetail()
        }
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter.string(from: date)
    }
    
    private func fetchPostDetail() {
        PostService.shared.PostDetail(postid: id) { result in
            switch result {
            case .success(let fetchedPostResponse):
                if let postDetail = fetchedPostResponse.post {
                    self.comments = postDetail.comments
                } else {
                    print("PostDetail이 없습니다.")
                }
            default:
                print("게시물 목록 조회 실패")
            }
        }
    }
    
    private func saveHeartState() {
        UserDefaults.standard.set(heartclick, forKey: "heartState_\(id)")
    }

    private func loadHeartState() {
        heartclick = UserDefaults.standard.bool(forKey: "heartState_\(id)")
    }
    
    private func heartfill() {
        PostService.shared.Heartfill(postId: id, token: token!) { result in
            switch result {
            case .success(let response):
                print("좋아요 추가됨: \(response)")
            case .requestErr(let message):
                alertMessage = message as? String ?? "댓글 생성 실패"
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
    
    private func heartempty() {
        PostService.shared.Heartempty(postId: id, token: token!) { result in
            switch result {
            case .success(let response):
                print("좋아요 삭제됨: \(response)")
            case .requestErr(let message):
                alertMessage = message as? String ?? "댓글 생성 실패"
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

    private func commentcreate() {
        PostService.shared.Commentcreate(
            postId: id,
            content: comment,
            token: token!
        ) { result in
            switch result {
            case .success(let response):
                print("댓글 생성 성공: \(response)")
                comment = ""
                fetchPostDetail()
            case .requestErr(let message):
                alertMessage = message as? String ?? "댓글 생성 실패"
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
