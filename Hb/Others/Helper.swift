//
//  Utility.swift
//  Hb
//
//  Created by DaeWan Choi on 2022/04/08.
//

import Foundation

class Helper {
    static var util: Helper = {
        return Helper()
    }()
    
    func decodeDetailDay(detailDay: Int) -> String {
        var str: String = ""
        switch detailDay {
        case 128:
            str += "협의"
        case 127:
            str += "매일"
        case 65:
            str += "주말"
        case 62:
            str += "주중"
        default:
            var l = ""
            l = detailDay & 64 > 0 ? "일" : ""
            l += detailDay & 32 > 0 ? l != "" ? "/월" : "월" : ""
            l += detailDay & 16 > 0 ? l != "" ? "/화" : "화" : ""
            l += detailDay  & 8 > 0 ? l != "" ? "/수" : "수" : ""
            l += detailDay & 4 > 0 ? l != "" ? "/목" : "목" : ""
            l += detailDay & 2 > 0 ? l != "" ? "/금" : "금" : ""
            l += detailDay & 1 > 0 ? l != "" ? "/토" : "토" : ""
            str += l
        }
        return str
    }
}
