//
//  LoginView.swift
//  Hb
//
//  Created by DaeWan Choi on 2022/03/06.
//

import SwiftUI
struct IntroView: View {
    @EnvironmentObject var userInfo: UserInfo
    @StateObject var viewRouter = ViewRouter()
    @State private var showingAlert: Bool = false
    @State private var showJoin: Bool = false
    
    var body: some View {
        if userInfo.isLogged {
            HomeView(viewRouter: viewRouter)
//            HomeView()
        } else {
            NavigationView {
                VStack {
                    Spacer()
                    Text("해바")
                        .font(.system(size: 50))
                        .fontWeight(.bold)
                        .padding(30)
                    
                    Button(action: {
                        self.showingAlert = true
                    }) {
                        Text("구글로 로그인")
                            .fontWeight(.bold)
                    }
                    .alert(isPresented: $showingAlert) {
                        //Alert(title: Text("Title"), message: Text("This is a Alert"), dismissButton: .default(Text("OK")))
                        Alert(title: Text("Title"), message: Text("This is a Alert"), primaryButton: .destructive(Text("OK")), secondaryButton: .cancel())
                    }
                    .buttonStyle(Hb2ButtonStyle())
                    
                    Button(action: {
                    }) {
                        Text("카카오톡으로 로그인")
                            .fontWeight(.bold)
                    }
                    .buttonStyle(Hb2ButtonStyle())
                    
                    Button(action: {
                    }) {
                        Text("네이버로 로그인")
                            .fontWeight(.bold)
                    }
                    .buttonStyle(Hb2ButtonStyle())
                    
                    Button(action: {
                    }) {
                        NavigationLink(destination: LoginView()) {
                            Text("로그인")
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity, maxHeight: 60) // text사이즈를 버튼사이즈 만큼 늘려서 tap되게 설정
                        }
                    }
                    .buttonStyle(HbButtonStyleFill())
                    Spacer()
                    
                    Button(action: {
                        self.showJoin.toggle()
                    }) {
                        Text("무료로 회원가입")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, maxHeight: 60)
                    }
                    .buttonStyle(HbButtonStyleFill())
                    .fullScreenCover(isPresented: $showJoin, content: JoinIntroView.init)
                    Spacer().frame(height: 100)
                }
                .ignoresSafeArea()
            }
            .accentColor(.black)
        }
    }
}

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView()
            .environmentObject(UserInfo())
    }
}
