//
//  ChatView.swift
//  YourMentor
//
//  Created by 이다경 on 12/29/24.
//

import SwiftUI

struct ChatView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 50) {
            HStack(alignment: .top, spacing: 0) {
                VStack {
                    IncomingProfile()
                    Text("신고")
                        .foregroundColor(.gray)
                        .font(.system(size: 12))
                }
                VStack(alignment: .leading, spacing: 10) {
                    VStack(alignment: .leading, spacing: 5) {
                        HStack {
                            Text("이즈리얼")
                                .fontWeight(.semibold)
                                .padding(.leading)
                            Image(systemName: "light.beacon.max")
                                .foregroundColor(.gray)
                        }
                        IncomingBubble(char: "안녕하세요!")
                    }
                    IncomingBubble(char: "이번에 바텀 프로젝트를 하게 되었는데 서폿한테 오류가 생겨서 도저히 어떡해야할지 모르겠어요ㅠㅜ")
                    IncomingBubble(char: "혹시 실례가 아니라면 바텀 프로젝트 서폿 좀 봐주실 수 있으실까요?")
                }
            }
            HStack(alignment: .top, spacing: 0) {
                VStack(alignment: .trailing, spacing: 10) {
                    VStack(alignment: .trailing, spacing: 5) {
                        Text("요네")
                            .fontWeight(.semibold)
                            .padding(.trailing)
                        OutgoingBubble(char: "네..? 전 미드전공인데요 ㄹㅇㅋㅋ")
                    }
                    OutgoingBubble(char: "원딜 취업도 안돼는거 왜함..?? 개 어이 없네")
                    OutgoingBubble(char: "어\n이\n없\n다")
                }
                OutgoingProfile()
            }
            HStack(alignment: .top, spacing: 0) {
                VStack {
                    IncomingProfile()
                    Text("신고")
                        .foregroundColor(.gray)
                        .font(.system(size: 12))
                }
                VStack(alignment: .leading, spacing: 10) {
                    VStack(alignment: .leading, spacing: 5) {
                        HStack {
                            Text("이즈리얼")
                                .fontWeight(.semibold)
                                .padding(.leading)
                            Image(systemName: "light.beacon.max")
                                .foregroundColor(.gray)
                        }
                        IncomingBubble(char: "원딜도 취업 할수있다고 ㅠㅠ")
                    }
                }
            }
        }
    }
}

#Preview {
    ChatView()
}
