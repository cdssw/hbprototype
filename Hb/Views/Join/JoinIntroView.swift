//
//  Intro.swift
//  Hb
//
//  Created by DaeWan Choi on 2022/03/11.
//

import SwiftUI

struct JoinIntroView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer().frame(height: 150)
                Text("환영합니다.")
                    .font(.largeTitle)
                    .foregroundColor(Color(0x797979))
                    .padding(.bottom, 30)
                Text("계정을 생성하여 모든 서비스를\n무료로 이용할 수 있습니다.")
                    .font(.headline)
                    .foregroundColor(Color(0x797979))
                    .multilineTextAlignment(.center)
                Spacer()
                Button(action: {
                }, label: {
                    NavigationLink(destination: JoinStep1View()) {
                        Text("회원가입 시작")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, minHeight: 60)
                    }
                }).buttonStyle(HbButtonStyleFill())
                Spacer().frame(height: 100)
            }
            .ignoresSafeArea()
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(Color(0x797979))
            })
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct JoinIntroView_Previews: PreviewProvider {
    static var previews: some View {
        JoinIntroView()
    }
}
