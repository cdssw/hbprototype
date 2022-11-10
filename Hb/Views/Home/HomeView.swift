
//  HomeView.swift
//  Hb
//
//  Created by DaeWan Choi on 2022/03/13.
//

import SwiftUI

struct HomeView: View {
    @StateObject var meetViewModel = MeetViewModel()
    @StateObject var viewRouter: ViewRouter
    @State var currentTab: String = "Home"
    
    init(viewRouter: ViewRouter) {
        _viewRouter = StateObject(wrappedValue: viewRouter)
        UITabBar.appearance().backgroundColor = .white
    }
    
    var body: some View {
        TabView {
            VStack {
                MainView()
                    .padding(.bottom, 5)
                Rectangle()
                    .fill(.clear)
                    .frame(height: 10)
                    .overlay(Divider(), alignment: .top)
                    .padding([.leading, .trailing])
            }
            .tabItem {
                GeometryReader { geometry in
                    TabBarIcon(viewRouter: viewRouter, assignedPage: .home, width: geometry.size.width/5, height: geometry.size.height/35, systemIconName: "house")
                }
            }
            VStack {
                Text("Liked")
                    .frame(maxHeight: .infinity)
                Rectangle()
                    .fill(.clear)
                    .frame(height: 10)
                    .overlay(Divider(), alignment: .top)
                    .padding([.leading, .trailing])
            }
            .tabItem {
                GeometryReader { geometry in
                    TabBarIcon(viewRouter: viewRouter, assignedPage: .liked, width: geometry.size.width/5, height: geometry.size.height/35, systemIconName: "star")
                }
            }
            VStack {
                Text("Chat")
                    .frame(maxHeight: .infinity)
                Rectangle()
                    .fill(.clear)
                    .frame(height: 10)
                    .overlay(Divider(), alignment: .top)
                    .padding([.leading, .trailing])
            }
            .tabItem {
                GeometryReader { geometry in
                    TabBarIcon(viewRouter: viewRouter, assignedPage: .chat, width: geometry.size.width/5, height: geometry.size.height/35, systemIconName: "message")
                }
            }
            VStack {
                Text("User")
                    .frame(maxHeight: .infinity)
                Rectangle()
                    .fill(.clear)
                    .frame(height: 10)
                    .overlay(Divider(), alignment: .top)
                    .padding([.leading, .trailing])
            }
            .tabItem {
                GeometryReader { geometry in
                    TabBarIcon(viewRouter: viewRouter, assignedPage: .user, width: geometry.size.width/5, height: geometry.size.height/35, systemIconName: "person")
                }
            }
        }
    }
}

struct TabBarIcon: View {
    @StateObject var viewRouter: ViewRouter
    let assignedPage: Page
    let width, height: CGFloat
    let systemIconName: String
    var tabName: String?
    
    var body: some View {
        VStack {
            Image(systemName: systemIconName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: width, height: height)
                .padding(.top, 10)
            if let name = tabName {
                Text(name)
                    .font(.footnote)
            }
            Spacer()
        }
        .foregroundColor(viewRouter.currentPage == assignedPage ? .red : .gray)
        .padding(.horizontal, -6)
        .onTapGesture {
            viewRouter.currentPage = assignedPage
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewRouter: ViewRouter())
    }
}
