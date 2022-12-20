//
//  UserView.swift
//  Hb
//
//  Created by 최대완 on 2022/12/19.
//

import SwiftUI

struct UserView: View {
    @EnvironmentObject var userInfo: UserInfo
    @EnvironmentObject var authorizationViewModel: AuthorizationViewModel
    
    var body: some View {
        Button(action: {
            authorizationViewModel.delTokenOnKeyChain(key: Constant.ACCESS_TOKEN)
            self.userInfo.isLogged = false
        }) {
            Text("로그아웃")
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
