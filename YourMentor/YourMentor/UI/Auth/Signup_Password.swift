//
//  Signup_Password.swift
//  YourMentor
//
//  Created by 이다경 on 1/9/25.
//

import SwiftUI

struct Signup_Password: View {
    @State private var pass: String = ""
    @State private var passcheck: String = ""
    @State private var showpass = false
    @State private var showpasscheck = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 45) {
                Image("key")
                Text("비밀번호를 입력해주세요!")
                    .font(.system(size: 21, weight: .semibold))
                HStack {
                    Group {
                        if showpass {
                            TextField("비밀번호를 작성해주세요!", text: $pass)
                                .submitLabel(.done)
                        } else {
                            SecureField("비밀번호를 작성해주세요!", text: $pass)
                                .submitLabel(.done)
                        }
                    }
                    .autocapitalization(.none)
                    .frame(minHeight: 20)
                    
                    Button(action: {
                        self.showpass.toggle()
                    }, label: {
                        Image(systemName: showpass ? "eye" : "eye.slash")
                            .foregroundColor(.gray)
                    })
                }
                .font(.system(size: 14))
                .padding(.leading)
                .padding(.bottom, 7)
                .overlay(
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray),
                    alignment: .bottom
                )
                .padding(.horizontal, 50)
                ZStack {
                    if !pass.isEmpty {
                        HStack {
                            Group {
                                if showpasscheck {
                                    TextField("비밀번호를 확인해주세요!", text: $passcheck)
                                        .submitLabel(.done)
                                } else {
                                    SecureField("비밀번호를 확인해주세요!", text: $passcheck)
                                        .submitLabel(.done)
                                }
                            }
                            .autocapitalization(.none)
                            .frame(minHeight: 20)
                            
                            Button(action: {
                                self.showpasscheck.toggle()
                            }, label: {
                                Image(systemName: showpasscheck ? "eye" : "eye.slash")
                                    .foregroundColor(.gray)
                            })
                        }
                        .font(.system(size: 14))
                        .padding(.leading)
                        .padding(.bottom, 7)
                        .overlay(
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(.gray),
                            alignment: .bottom
                        )
                        .padding(.horizontal, 50)
                    } else {
                        Text("")
                            .padding(.horizontal, 15)
                            .padding(.vertical, 7)
                    }
                }
                .frame(height: 20)
                ZStack {
                    if !passcheck.isEmpty {
                        NavigationLink(destination: SignupView()) {
                            Text("다음")
                                .font(.system(size: 15, weight: .black))
                                .foregroundStyle(.white)
                                .padding(.horizontal, 15)
                                .padding(.vertical, 7)
                                .background(
                                    RoundedRectangle(cornerRadius: 30)
                                        .fill(.main)
                                )
                        }
                    } else {
                        Text("")
                            .padding(.horizontal, 15)
                            .padding(.vertical, 7)
                    }
                }
                .frame(height: 44)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image("backbutton")
                            .resizable()
                            .frame(width: 12, height: 22)
                            .padding(.leading, 7)
                            .foregroundColor(.black)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    Signup_Password()
}
