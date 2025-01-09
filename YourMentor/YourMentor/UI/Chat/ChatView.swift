//
//  ChatView.swift
//  YourMentor
//
//  Created by 이다경 on 12/29/24.
//

import SwiftUI

struct ChatView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 30) {
                    HStack(alignment: .top) {
                        VStack {
                            IncomingProfile()
                            Text("신고")
                                .foregroundColor(.gray)
                                .font(.system(size: 12))
                        }
                        VStack(alignment: .leading, spacing: 13) {
                            HStack {
                                Text("이즈리얼")
                                    .fontWeight(.semibold)
                                    .padding(.leading)
                                Image(systemName: "light.beacon.max")
                                    .foregroundColor(.gray)
                            }
                            IncomingBubble(char: "안녕하세요!")
                            IncomingBubble(char: "이번에 안드로이드 프로젝트를 하게 되었는데 코드에서 오류가 생겨서 도저히 어떡해야할지 모르겠어요ㅠㅜ")
                            IncomingBubble(char: "혹시 실례가 아니라면 안드로이드 프로젝트 코드 좀 봐주실 수 있으실까요?")
                        }
                    }
                    HStack(alignment: .top) {
                        VStack(alignment: .trailing, spacing: 13) {
                            Text("요네")
                                .fontWeight(.semibold)
                                .padding(.trailing)
                            OutgoingBubble(char: "녜..? 전 iOS전공인데요 ㄹㅇㅋㅋ")
                            OutgoingBubble(char: "안드 취업도 안돼는거 왜함..?? 개 어이 없네")
                            OutgoingBubble(char: "어\n이\n없\n당ㅋ")
                        }
                        OutgoingProfile()
                    }
                }
                .frame(maxWidth: 370)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button(action: {
                            dismiss()
                        }) {
                            HStack {
                                Image(systemName: "chevron.backward")
                                Text("돌아가기")
                            }
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        }
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ChatView()
}
