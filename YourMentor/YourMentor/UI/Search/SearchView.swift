//
//  SearchView.swift
//  YourMentor
//
//  Created by 이다경 on 1/4/25.
//

import SwiftUI

struct SearchView: View {
    var body: some View {
        ZStack {
            Color.back
                .ignoresSafeArea(edges: .all)
            ScrollView(showsIndicators: false) {
                VStack {
                    ForEach(0..<4, id: \.self) { _ in
                        PostCell(title: "안드로이드 깃허브로 협업하는 방법에 대하여", date: Date())
                    }
                }
            }
        }
    }
}

#Preview {
    SearchView()
}
