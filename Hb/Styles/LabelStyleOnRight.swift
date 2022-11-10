//
//  LabelStyleOnRight.swift
//  Hb
//
//  Created by DaeWan Choi on 2022/04/07.
//

import SwiftUI

struct LabelStyleOnRight: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack(alignment: .center, spacing: 8) {
            configuration.title
            configuration.icon
        }
    }
}
