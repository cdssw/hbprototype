//
//  NavigationBarModifier.swift
//  Hb
//
//  Created by 최대완 on 2022/12/01.
//

import SwiftUI

struct NavigationBarModifier<Background>: ViewModifier where Background: View {
    let background: () -> Background
    
    init(@ViewBuilder background: @escaping () -> Background) {
        // 기본 네비게이션 배경을 투명처리
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = .clear

        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance

        self.background = background
    }

    func body(content: Content) -> some View {
        ZStack {
            content
            VStack {
                background()
                    .edgesIgnoringSafeArea([.top, .leading, .trailing])
                    .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 0, alignment: .center)
                Spacer()
            }
            .animation(.default) // safeArea 표시를 애니메이션 처리
        }
    }
}

public extension View {
    // view에서 확장메서드 네비게이션 배경 변경 처리 (safeArea임)
    func navigationBarBackground<Background: View>(@ViewBuilder _ background: @escaping () -> Background) -> some View {
        modifier(NavigationBarModifier(background: background))
    }
}
