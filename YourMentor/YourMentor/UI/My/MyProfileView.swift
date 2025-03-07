//
//  MyProfileView.swift
//  YourMentor
//
//  Created by 이다경 on 3/6/25.
//

import SwiftUI

struct MyProfileView: View {
    @Binding var user: UserDetail?
    let service = APIConstants.baseURL+"/img/"
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 7) {
                    HStack {
                        Text((user?.nick ?? "") + "님")
                            .font(.system(size: 22, weight: .bold))
                        
                        NavigationLink(destination: MyEditView(
                            newnickname: user?.nick ?? "",
                            selectedHashtags: Set(user?.hashtags.map { $0.id } ?? []),
                            profileImageURL: service + (user?.profile_pic ?? ""),
                            userId: user?.user_id ?? 0
                        )) {
                            Image(systemName: "pencil")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .bold()
                                .foregroundColor(.gray)
                        }
                    }
                    
                    Text(verbatim: user?.email ?? "")
                        .font(.system(size: 18))
                        .foregroundColor(.subfont)
                }
                Spacer()
                
                let url = URL(string: service + (user?.profile_pic ?? ""))
                AsyncImage(url: url) { image in
                    image.resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: 84, height: 84)
                } placeholder: {
                    ProgressView()
                }
            }
            .frame(maxWidth: 295)
            .padding(.top)
            
            HStack {
                Spacer()
                Button(action: {
//                    logout()
                }) {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                        .resizable()
                        .frame(width: 22, height: 20)
                        .foregroundColor(.black.opacity(0.8))
                }
                .padding(.trailing, 40)
            }
            
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text("내가 선택한 관심태그")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.black.opacity(0.8))
                    HStack(spacing: 5) {
                        ForEach(user?.hashtags ?? []) { hashtag in
                            MyProfileHashtag(title: hashtag.name)
                        }
                    }
                }
                Spacer()
            }
            .frame(maxWidth: 295)
        }
    }
}
