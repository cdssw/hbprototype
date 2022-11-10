//
//  KeyboardDismiss.swift
//  Hb
//
//  Created by DaeWan Choi on 2022/03/07.
//

import SwiftUI

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
