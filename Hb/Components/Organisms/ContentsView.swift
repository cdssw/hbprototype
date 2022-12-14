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
    @StateObject var meetViewModel: MeetViewModel = MeetViewModel()
    @StateObject var fileViewModel: FileViewModel = FileViewModel()
    @State private var isImage: Bool = true
    
    var meetId: Int
    
    var body: some View {
        ZStack {
            // image가 있으면 image 표시 적용된 ContentMeet 표시
            if let meet = meetViewModel.meet {
                if meet.imgList.count > 0 {
                    ContentMeet(meet: meet, fileViewModel: fileViewModel, isImage: $isImage)
                        .navigationBarBackButtonHidden(true)
                        .navigationBarItems(leading: HbBackButton(imageYn: self.isImage))
                        .navigationBarTitle("")
                        .navigationBarTitleDisplayMode(.inline)
                        .onAppear() {
                            self.fileViewModel.postImagesPath(meet.imgList)
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
                    ContentMeet(meet: meet, fileViewModel: fileViewModel, isImage: $isImage)
                        .navigationBarBackButtonHidden(true)
                        .navigationBarItems(leading: HbBackButton(imageYn: false))
                        .navigationBarTitle("상세보기")
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationBarBackground {
                            Color.white
                        }
                }
            } else {
                GeometryReader { geometry in
                    Color.white
                        .frame(height: geometry.size.height)
                }
                .edgesIgnoringSafeArea(.all)
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: HbBackButton(imageYn: self.isImage))
                .navigationBarTitle("")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackground {
                    Color.clear
                }
                .animation(.default, value: UUID())
            }
        }
        .onAppear() {
            self.meetViewModel.getMeet(meetId)
        }
    }
}

struct ContentMeet: View {
    var meet: Meet
    private let height: CGFloat = 400
    @ObservedObject var fileViewModel: FileViewModel
    @Binding var isImage: Bool
    @State private var offsetY: CGFloat = .zero
    @State var isFullImage: Bool = false
    
    var body: some View {
        ObservableScrollView(scrollOffset: $offsetY) { proxy in
            // image 존재여부에 따른 ImageSlider 표시
            if self.meet.imgList.count > 0 {
                GeometryReader { geometry in
                    let offset = geometry.frame(in: .global).minY
                    ZStack {
                        ImageSlider(fileViewModel: fileViewModel)
                    }
                    .frame(
                        width: geometry.size.width,
                        height: height + (offset > 0 ? offset : 0)
                    )
                    .offset(
                        y: (offset > 0 ? -offset: 0)
                    )
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onEnded { value in
                                self.isFullImage = true
                            }
                    )
                }
                .frame(minHeight: height)
            }
            LazyVStack(pinnedViews: [.sectionHeaders]) {
                Section(header: UserWithCost(meet: meet)) {
                    VStack {
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
                }
            }
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
        }
        .onChange(of: offsetY, perform: { newValue in
            if offsetY > 260 {
                self.isImage = false
            } else {
                self.isImage = true
            }
        })
        .overlay(
            Rectangle()
                .foregroundColor(.white)
                .frame(height: (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.safeAreaInsets.top)
                .edgesIgnoringSafeArea(.all)
                .opacity(offsetY > -height ? 0 : 1)
            , alignment: .top
        )
        .fullScreenCover(isPresented: $isFullImage, content: {
            FullImageSlider(fileViewModel: fileViewModel)
        })
    }
}

struct UserWithCost: View {
    var meet: Meet
    
    var body: some View {
        VStack {
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
            Divider()
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .frame(height: 60)
        .background(Rectangle().foregroundColor(.white))
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
        ContentsView(meetId: Meet.getDummy().id)
//        ContentsView(meet: Meet.getDummy())
            .environmentObject(UserInfo())
    }
}
