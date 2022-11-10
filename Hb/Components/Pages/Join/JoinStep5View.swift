//
//  JoinStep5View.swift
//  Hb
//
//  Created by DaeWan Choi on 2022/03/12.
//

import SwiftUI

struct JoinStep5View: View {
    @State private var search: String = ""
    @StateObject private var keyboardHandler = KeyboardHandler()
    @State private var isFocused: Bool = false
    @State private var showFinish: Bool = false
    @FocusState private var focusedField: FocusField?
    
    let favoriteList: [Favorite] = [
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
    
    var body: some View {
        ZStack {
            Color.white.opacity(0.1)
                .onTapGesture { // 아무데나 tap해도 키보드 숨기기
                    self.isFocused = false
                    self.hideKeyboard()
                }
                .gesture( // 아래로 제스쳐하면 키보드 숨기기
                    DragGesture(minimumDistance: 0, coordinateSpace: .local).onEnded({ gesture in
                        if gesture.translation.height > 0 {
                            self.isFocused = false
                            self.hideKeyboard()
                        }
                    })
                )
            VStack {
                Spacer().frame(height: 100)
                HStack {
                    Text("관심있는 분야를 선택하세요.")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(Color(0x797979))
                        .padding(25)
                    Spacer()
                }
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField("검색", text: $search)
                        .focused($focusedField, equals: .field)
                        .onTapGesture {
                            self.isFocused = true
                        }
                }
                .padding(EdgeInsets(top: 15, leading: 35, bottom: 15, trailing: 25))
                .overlay(RoundedRectangle(cornerRadius: 6)
                            .stroke()
                            .foregroundColor(Color(0x797979))
                            .padding(EdgeInsets(top: 0, leading: 25, bottom: 0, trailing: 25))
                )
                
                ScrollView() {
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
                .padding(.top, 10)
                
                Spacer()
                Button(action: {
                    self.showFinish.toggle()
                }, label: {
                    Text("다음")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, minHeight: 60)
                })
                    .buttonStyle(HbButtonStyleFill())
                    .fullScreenCover(isPresented: $showFinish, content: JoinFinishView.init)
                
                Spacer().frame(height: 100)
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            
        } // ZStack
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: HbBackButton())
        .navigationBarTitle("회원가입")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct JoinStep5View_Previews: PreviewProvider {
    static var previews: some View {
        JoinStep5View()
    }
}
