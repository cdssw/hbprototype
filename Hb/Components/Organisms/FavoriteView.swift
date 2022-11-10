//
//  FavoriteView.swift
//  Hb
//
//  Created by DaeWan Choi on 2022/03/12.
//

import SwiftUI

struct FavoriteView: View {
    var image: String = ""
    var text: String = ""
    @State var checked: Bool = false
    var body: some View {
        Button(action: {
            self.checked.toggle()
        }) {
            VStack {
                Image(systemName: image)
                    .font(.system(size: 20))
                    .foregroundColor(checked ? Color(0x5C89FC) : Color(0xBDBDBD))
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(checked ? Color(0x5C89FC) : Color(0xBDBDBD), lineWidth: 5))
                Text(text)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(Color(0x797979))
            }
        }
    }
}

struct Favorite: Identifiable {
    var id = UUID()
    var image: String
    var text: String
    var checked: Bool = false
}

struct FavoriteView_Previews: PreviewProvider {
    private static var favoriteList: [Favorite] = [
        Favorite(image: "music.note", text: "음악"),
        Favorite(image: "desktopcomputer", text: "컴퓨터"),
        Favorite(image: "book.closed.fill", text: "책"),
        Favorite(image: "paintbrush.pointed.fill", text: "디자인"),
        Favorite(image: "pianokeys.inverse", text: "악기"),
        Favorite(image: "ferry.fill", text: "무역"),
        Favorite(image: "airplane", text: "여행"),
        Favorite(image: "cloud.sun.fill", text: "날씨"),
        Favorite(image: "camera.aperture", text: "사진"),
    ]
    
    static var previews: some View {
        VStack {
            ForEach(Array(stride(from:0, to: self.favoriteList.count, by: 3)), id: \.self) { index in
                HStack {
                    FavoriteView(image: favoriteList[index].image, text: favoriteList[index].text)
                    Spacer()
                    FavoriteView(image: favoriteList[index + 1].image, text: favoriteList[index + 1].text)
                    Spacer()
                    FavoriteView(image: favoriteList[index + 2].image, text: favoriteList[index + 2].text)
                }
                .padding(EdgeInsets(top: 10, leading: 50, bottom: 10, trailing: 50))
            }
        }
    }
}
