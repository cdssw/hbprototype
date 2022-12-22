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
            self.userInfo.isLogged = false
            let auth = AuthorizationResponse(accessToken: "", tokenType: "", refreshToken: "", expiresIn: 0, scope: "", jti: "")
            let _ = authorizationViewModel.modTokenOnKeyChain(auth: auth)
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
