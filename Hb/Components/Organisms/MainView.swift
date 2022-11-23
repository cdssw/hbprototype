//
//  MainView.swift
//  Hb
//
//  Created by DaeWan Choi on 2022/04/12.
//

import SwiftUI

struct MainView: View{
    // 로딩시 데이터 조회
    @ObservedObject var meetViewModel = MeetViewModel()
    
    init() {
        print(#fileID, #function, #line, "")
        // 생성자가 호출되면 바로 데이터를 조회
        let paging: Paging = Paging(page: meetViewModel.page)
        meetViewModel.getMeetList(paging)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HeaderView()
                ScrollView {
                    LazyVStack {
                        ForEach(Array(zip(meetViewModel.meetList.indices, meetViewModel.meetList)), id:\.0) { index, meet in
                            NavigationLink(destination: ContentsView(meet: meet)) {
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
            }
            .navigationBarHidden(true)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
