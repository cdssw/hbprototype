//
//  ViewRouter.swift
//  Hb
//
//  Created by DaeWan Choi on 2022/04/12.
//

import Foundation

class ViewRouter: ObservableObject {
    @Published var currentPage: Page = .home
}

enum Page {
    case home
    case liked
    case chat
    case user
}
