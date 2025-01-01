//
//  Profile.swift
//  YourMentor
//
//  Created by 이다경 on 12/29/24.
//

import SwiftUI

struct OutgoingProfile: View {
    var body: some View {
        Image("outprofile")
            .resizable()
            .renderingMode(.original)
            .clipShape(Circle())
            .frame(maxWidth: 55, maxHeight: 55)

    }
}

struct IncomingProfile: View {
    var body: some View {
        Image("inprofile")
            .resizable()
            .renderingMode(.original)
            .clipShape(Circle())
            .frame(maxWidth: 55, maxHeight: 55)
    }
}

#Preview {
    IncomingProfile()
}
