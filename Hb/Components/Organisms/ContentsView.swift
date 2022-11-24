//
//  ContentView.swift
//  Hb
//
//  Created by DaeWan Choi on 2022/04/13.
//

import SwiftUI

struct ContentsView: View {
    var meet: Meet
    @EnvironmentObject var userInfo: UserInfo
    @StateObject private var keyboardHandler = KeyboardHandler()
    @State private var isFocused: Bool = false
    @FocusState private var focusedField: FocusField?
    @ObservedObject var meetViewModel = MeetViewModel()
    @State var show: Bool = false
    let appearance = UINavigationBarAppearance()
   
    init(meet: Meet) {
        self.meet = meet
        
        if self.show == false {
            // 네비게이션바 투명처리
            appearance.configureWithTransparentBackground()
            appearance.backgroundColor = .clear
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        } else {
            appearance.configureWithDefaultBackground()
            appearance.backgroundColor = .systemBackground
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
    }
    var body: some View {
        return ZStack {
            ScrollView {
                VStack {
                    ImageSlider().frame(height: 300)
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
                    GeometryReader { proxy in
                        let offset = proxy.frame(in: .named("scroll")).minY
                        Color.clear.preference(key: ScrollViewOffsetPreferenceKey.self, value: offset)
                    }
                }
            }
            .coordinateSpace(name: "scroll")
            .onPreferenceChange(ScrollViewOffsetPreferenceKey.self) { value in
                if value < 400 {
                    print(value)
                    self.show = true
                } else {
                    self.show = false
                }
            }
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: HbBackButton(imageYn: true))
        .navigationBarTitle(meet.imgList.count==0 ? "" : "상세보기")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            self.meetViewModel.getMeet(meet.id)
        }
        .id(self.show)
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
