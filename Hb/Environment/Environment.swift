//
//  UserInfo.swift
//  Hb
//
//  Created by DaeWan Choi on 2022/03/13.
//

import SwiftUI

class UserInfo: ObservableObject {
    @Published var isLogged: Bool = false
}

enum EnvironmentMode {
    case dev
    case stg
    case prd
}

let environmentMode: EnvironmentMode = .dev
