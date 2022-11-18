//
//  ContentView.swift
//  Hb
//
//  Created by DaeWan Choi on 2022/04/13.
//

import SwiftUI

struct ContentsView: View {
    @EnvironmentObject var userInfo: UserInfo
    @StateObject private var keyboardHandler = KeyboardHandler()
    @State private var isFocused: Bool = false
    @FocusState private var focusedField: FocusField?
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Image(systemName: "person.fill")
                        .font(.system(size: 20))
                        .foregroundColor(Color(0xBDBDBD))
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color(0xBDBDBD), lineWidth: 5))
                    Text("HK")
                        .font(.body)
                        .fontWeight(.bold)
                        .foregroundColor(Color(0x5B5656))
                    Spacer()
                    Text("￦ 30,000")
                        .font(.subheadline)
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                        .foregroundColor(Color(0x00AF31))
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color(0x007728), lineWidth: 1)
                                .frame(height: 26)
                        )
                }
                Divider()
                HStack(spacing: 0) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Test")
                            .font(.body)
                            .fontWeight(.bold)
                            .foregroundColor(Color(0x5B5656))
                        Text("10월 11일 11:30")
                            .font(.caption)
                            .foregroundColor(Color(0x797979))
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                    }
                    Spacer()
                    HStack(spacing: 3) {
                        Image(systemName: "message")
                            .font(.subheadline)
                            .foregroundColor(Color(0x797979))
                        Text("10")
                            .foregroundColor(Color(0x797979))
                            .font(.subheadline)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                    }
                    HStack(spacing: 3) {
                        Image(systemName: "person.badge.plus")
                            .font(.subheadline)
                            .foregroundColor(Color(0x797979))
                        Text("2")
                            .font(.subheadline)
                            .foregroundColor(Color(0x797979))
                    }
                }
                HStack {
                    Image(systemName: "clock")
                        .font(.body)
                        .foregroundColor(Color(0x797979))
                    Text("10:00~16:00")
                        .foregroundColor(.blue)
                        .font(.body)
                    Text("월/수")
                        .foregroundColor(.green)
                        .font(.body)
                    Spacer()
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                HStack {
                    Image(systemName: "map")
                        .font(.body)
                        .foregroundColor(Color(0x797979))
                    Text("address")
                        .foregroundColor(Color(0x797979))
                        .font(.body)
                    Spacer()
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
                HStack {
                    Text("Content12212121212 12121")
                        .foregroundColor(Color(0x797979))
                        .font(.body)
                    Spacer()
                }
                    Spacer()
            }
            .padding(EdgeInsets(top: 10, leading: 20, bottom: 0, trailing: 20))
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: HbBackButton())
        .navigationBarTitle("상세보기")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ContentsView_Previews: PreviewProvider {
    static var previews: some View {
        ContentsView()
            .environmentObject(UserInfo())
    }
}
