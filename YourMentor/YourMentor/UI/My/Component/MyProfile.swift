//
//  Profile.swift
//  YourMentor
//
//  Created by 이다경 on 1/3/25.
//

import SwiftUI

struct MyProfile: View {
    
    var body: some View {
            Image("outprofile")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(Circle())
    }
}

#Preview {
    MyProfile()
}
