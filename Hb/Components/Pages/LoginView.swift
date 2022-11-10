//
//  LoginView.swift
//  Hb
//
//  Created by DaeWan Choi on 2022/03/06.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var userInfo: UserInfo
    @State private var username: String = ""
    @State private var password: String = ""
    @StateObject private var keyboardHandler = KeyboardHandler()
    @State private var isFocused: Bool = false
    @FocusState private var focusedField: FocusField?
    
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
                Text("해바")
                    .font(.system(size: 50))
                    .fontWeight(.bold)
                Spacer()
                    .frame(height: 50)
                TextField("아이디를 입력하세요.", text: $username)
                    .keyboardType(.emailAddress)
                    .textFieldStyle(HbTextFieldStyle())
                    .focused($focusedField, equals: .field)
                    .onTapGesture {
                        self.isFocused = true
                    }
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                            self.focusedField = .field
                            self.isFocused = true
                        }
                    }
                SecureField("비밀번호를 입력하세요.", text: $password)
                    .textFieldStyle(HbTextFieldStyle())
                    .onTapGesture {
                        self.isFocused = true
                    }
                Spacer().frame(height: 30)
                Button(action: {
                    self.userInfo.isLogged = true
                }) {
                    Text("로그인")
                        .fontWeight(.bold)
                }
                .buttonStyle(HbButtonStyleFill())
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .animation(.default, value: UUID())
            .padding(.bottom, isFocused ? keyboardHandler.keyboardHeight : 100)
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: HbBackButton())
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(UserInfo())
    }
}
