//
//  JoinStep4View.swift
//  Hb
//
//  Created by DaeWan Choi on 2022/03/12.
//

import SwiftUI

struct JoinStep4View: View {
    @State private var disabled: Bool = true
    @State private var userNm: String = ""
    @State private var phoneNo: String = ""
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
                Spacer().frame(height: 100)
                HStack {
                    Text("회원님의 기본정보를 입력하세요.")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(Color(0x797979))
                        .padding(25)
                    Spacer()
                }
                HStack {
                    Text("이름")
                        .font(.subheadline)
                        .foregroundColor(Color(0x797979))
                    Spacer()
                }
                .padding(.leading, 25)
                TextField("이름을 입력하세요.", text: $userNm)
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
                    .onChange(of: self.userNm) { [] (newText) in
                        self.disabled = newText != "" && self.phoneNo != "" ? false : true
                    }
                    .padding(.bottom, 10)

                HStack {
                    Text("휴대폰 번호")
                        .font(.subheadline)
                        .foregroundColor(Color(0x797979))
                    Spacer()
                }
                .padding(.leading, 25)
                TextField("휴대폰번호를 입력하세요.", text: $phoneNo)
                    .keyboardType(.numberPad)
                    .textFieldStyle(HbTextFieldStyle())
                    .onChange(of: self.phoneNo) { [] (newText) in
                        self.disabled = newText != "" && self.userNm != "" ? false : true
                    }
                    .padding(.bottom, 10)
                
                Spacer()
                Button(action: {
                }, label: {
                    NavigationLink(destination: JoinStep5View()) {
                        Text("다음")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, minHeight: 60)
                    }
                })
                    .buttonStyle(disabled ? HbButtonStyleFill(bgColor: Color.gray) : HbButtonStyleFill())
                    .disabled(disabled)
                
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

struct JoinStep4View_Previews: PreviewProvider {
    static var previews: some View {
        JoinStep4View()
    }
}
