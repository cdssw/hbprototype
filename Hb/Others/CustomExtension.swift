//
//  CustomExtension.swift
//  Hb
//
//  Created by 최대완 on 2022/11/23.
//

import Foundation

extension Int {
    func withCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: self))!
    }
}
