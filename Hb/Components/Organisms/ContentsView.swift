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
    @FocusState private var focusedField: FocusField?
    @ObservedObject var meetViewModel = MeetViewModel()
    @State private var isImage: Bool = true
    
    var meet: Meet
    
    var body: some View {
        ZStack {
            // image가 있으면 image 표시 적용된 ContentMeet 표시
            if self.meet.imgList.count > 0 {
                ContentMeet(meet: meet, isImage: $isImage)
                    .ignoresSafeArea()
                    .navigationBarBackButtonHidden(true)
                    .navigationBarItems(leading: HbBackButton(imageYn: self.isImage))
                    .navigationBarTitle("")
                    .navigationBarTitleDisplayMode(.inline)
                    .onAppear {
                        self.meetViewModel.getMeet(meet.id)
                    }
                    .navigationBarBackground {
                        // 네비게이션 배경을 image 표시영역에 따른 변경처리
                        if self.isImage {
                            Color.clear
                        } else {
                            Color.white
                        }
                    }
            } else {
                // image가 없으면 일반 형식으로 표시
                ContentMeet(meet: meet, isImage: $isImage)
                    .navigationBarBackButtonHidden(true)
                    .navigationBarItems(leading: HbBackButton(imageYn: self.isImage))
                    .navigationBarTitle("상세보기")
                    .navigationBarTitleDisplayMode(.inline)
                    .onAppear {
                        self.meetViewModel.getMeet(meet.id)
                    }
                    .navigationBarBackground {
                        // 배경은 흰색으로 고정
                        Color.white
                    }
            }
        }
    }
}

struct ContentMeet: View {
    var meet: Meet
    @Binding var isImage: Bool
    @State private var offsetY: CGFloat = .zero
    
    func setOffset(offset: CGFloat) -> some View {
        DispatchQueue.main.async {
            self.offsetY = offset
        }
        return EmptyView()
    }
    
    var body: some View {
        ZStack {
            ScrollView {
                // image 존재여부에 따른 ImageSlider 표시
                if self.meet.imgList.count > 0 {
                    GeometryReader { geometry in
                        let offset = geometry.frame(in: .global).minY
                        setOffset(offset: offset)
                        ZStack {
                            ImageSlider()
                        }
                        .frame(
                            width: geometry.size.width,
                            height: 400 + (offset > 0 ? offset : 0)
                        )
                        .offset(
                            y: (offset > 0 ? -offset: 0)
                        )
                    }
                    .frame(minHeight: 400)
                }
                VStack {
                    UserWithCost(meet: meet)
                    Divider()
                    TitleWithMessageAndAppl(meet: meet)
                    TimeAndLocation(meet: meet)
                    HStack {
                        Text(meet.content)
                            .foregroundColor(Color(0x797979))
                            .font(.body)
                        Spacer()
                    }
                    Spacer()
                }
                .padding(EdgeInsets(top: 10, leading: 20, bottom: 0, trailing: 20))
                GeometryReader { geometry in
                    // 스크롤의 현재 offset을 구해옴
                    let offset = geometry.frame(in: .named("scroll")).minY
                    Color.clear.preference(key: ScrollViewOffsetPreferenceKey.self, value: offset)
                }
            }
            .coordinateSpace(name: "scroll") // scroll offset조절을 위한 이름 정의
            .onPreferenceChange(ScrollViewOffsetPreferenceKey.self) { value in
                // scroll이 변경될때마다 체크하여 네비게이션 배경색 변경처리를 위한 변수 수정
                if value < 400 {
                    self.isImage = false
                } else {
                    self.isImage = true
                }
            }
            .overlay(
                Rectangle()
                    .foregroundColor(.black)
                    .frame(height: UIApplication.shared.windows.first?.safeAreaInsets.top)
                    .edgesIgnoringSafeArea(.all)
                    .opacity(offsetY > -400 ? 0 : 1)
                , alignment: .top
            )
        }
    }
}

struct UserWithCost: View {
    var meet: Meet
    
    var body: some View {
        HStack {
            if let avatar = meet.user.avatarPath {
                let path = Constant.IMAGE_SERVER + avatar
                AsyncImage(url: URL(string: path)) { image in
                    image.resizable()
                } placeholder: {
                    Text("")
                }
                .frame(width: 40, height: 40)
                .clipShape(RoundedRectangle(cornerRadius: 50))
                .overlay(
                    RoundedRectangle(cornerRadius: 50)
                        .stroke(Color(0xD3D3D3), lineWidth: 2)
                )
            } else {
                Image("avatar")
            }
            Text(meet.user.userNickNm)
                .font(.body)
                .fontWeight(.bold)
                .foregroundColor(Color(0x5B5656))
            Spacer()
            Text("￦ "+meet.cost.withCommas())
                .font(.subheadline)
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                .foregroundColor(Color(0x00AF31))
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color(0x007728), lineWidth: 1)
                        .frame(height: 26)
                )
        }
    }
}

struct TitleWithMessageAndAppl: View {
    var meet: Meet
    
    var body: some View {
        let modifyDt = meet.modifyDt.split(separator: " ")
        let yyyymmdd = modifyDt[0].split(separator: "-")
        let time = modifyDt[1].split(separator: ":")
        
        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 6) {
                Text(meet.title)
                    .font(.body)
                    .fontWeight(.bold)
                    .foregroundColor(Color(0x5B5656))
                Text(yyyymmdd[1] + "월 " + yyyymmdd[2] + "일 " + time[0...1].joined(separator: ":"))
                    .font(.caption)
                    .foregroundColor(Color(0x797979))
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
            }
            Spacer()
            HStack(spacing: 3) {
                Image("chat")
                Text(String(meet.application))
                    .foregroundColor(Color(0x797979))
                    .font(.subheadline)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
            }
            HStack(spacing: 3) {
                Image("add_account")
                Text(String(meet.recruitment))
                    .font(.subheadline)
                    .foregroundColor(Color(0x797979))
            }
        }
        
    }
}

struct TimeAndLocation: View {
    var meet: Meet
    
    var body: some View {
        HStack {
            Image("watch").padding(.leading, 1)
            Text(meet.term.startTm + "~" + meet.term.endTm)
                .foregroundColor(.blue)
                .font(.body)
            Text(Helper.util.decodeDetailDay(detailDay: meet.term.detailDay))
                .foregroundColor(.green)
            Spacer()
        }
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 1, trailing: 0))
        HStack {
            Image("location")
            Text(meet.address.address1)
                .foregroundColor(Color(0x797979))
                .font(.body)
            Spacer()
        }
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
        
    }
}

struct ContentsView_Previews: PreviewProvider {
    static var previews: some View {
        ContentsView(meet: Meet.getDummy())
            .environmentObject(UserInfo())
    }
}
