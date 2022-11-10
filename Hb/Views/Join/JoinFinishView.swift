//
//  JoinFinishView.swift
//  Hb
//
//  Created by DaeWan Choi on 2022/03/12.
//

import SwiftUI

struct JoinFinishView: View {
    var body: some View {
        VStack {
            Spacer().frame(height: 150)
            Text("회원가입 완료")
                .font(.largeTitle)
                .foregroundColor(Color(0x797979))
                .padding(.bottom, 30)
            Text("회원가입이 완료되었습니다.\n지금 바로 서비스를 이용할 수 있습니다.")
                .font(.headline)
                .foregroundColor(Color(0x797979))
                .multilineTextAlignment(.center)
            Spacer()
            Button(action: {
                UIApplication.shared.windows.first?.rootViewController?.dismiss(animated: true)
            }, label: {
                Text("로그인")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, minHeight: 60)
            }).buttonStyle(HbButtonStyleFill())
            Spacer().frame(height: 100)
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}

struct JoinFinishView_Previews: PreviewProvider {
    static var previews: some View {
        JoinFinishView()
    }
}
