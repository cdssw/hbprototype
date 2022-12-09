//
//  MainView.swift
//  Hb
//
//  Created by DaeWan Choi on 2022/04/12.
//

import SwiftUI

struct MainView: View{
    @ObservedObject var meetViewModel: MeetViewModel = MeetViewModel()
    
    init() {
        let paging: Paging = Paging(page: meetViewModel.page)
        meetViewModel.getMeetList(paging)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HeaderView()
                ScrollView {
                    PullToRefresh(coordinateSpaceName: "pullToRefresh") {
                        let paging: Paging = Paging(page: 0)
                        meetViewModel.getMeetList(paging)
                    }
                    LazyVStack {
                        ForEach(Array(zip(meetViewModel.meetList.indices, meetViewModel.meetList)), id:\.0) { index, meet in
                            NavigationLink(destination: ContentsView(meetId: meet.id)) {
                                CardView(meet: meet)
                                    .onAppear {
                                        // 마지막 index가 표시되면 다음 페이지를 로딩한다.
                                        if index % 10 == 9 {
                                            meetViewModel.page += 1
                                            let paging: Paging = Paging(page: meetViewModel.page)
                                            meetViewModel.getMeetList(paging)
                                        }
                                    }
                            }
                        }
                    }
                }
                .padding(.top, 5)
                .coordinateSpace(name: "pullToRefresh")
            }
            .navigationBarHidden(true)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct PullToRefresh: View {
    var coordinateSpaceName: String
    var onRefresh: () -> Void
    @State var needRefresh: Bool = false
    
    var body: some View {
        GeometryReader { proxy in
            if(proxy.frame(in: .named(coordinateSpaceName)).minY > 50) {
                Spacer()
                    .onAppear() {
                        needRefresh = true
                        onRefresh()
                    }
            } else if(proxy.frame(in: .named(coordinateSpaceName)).minY < 1) {
                Spacer()
                    .onAppear() {
                        if needRefresh {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                needRefresh = false
                            }
                        }
                    }
            }
            HStack {
                Spacer()
                if needRefresh {
                    ProgressView()
                } else {
                    Text("당겨서 새로고침")
                        .foregroundColor(Color(0x797979))
                        .animation(.default)
                }
                Spacer()
            }
        }
        .padding(.top, -50)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
