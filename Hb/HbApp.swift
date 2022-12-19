//
//  HbApp.swift
//  Hb
//
//  Created by DaeWan Choi on 2022/03/05.
//

import SwiftUI

@main
struct HbApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(UserInfo())
                .environmentObject(AuthorizationViewModel())
        }
    }
}
