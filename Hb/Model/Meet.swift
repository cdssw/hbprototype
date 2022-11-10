//
//  Meet.swift
//  Hb
//
//  Created by DaeWan Choi on 2022/04/07.
//

import Foundation

class MeetPath {
    static let meetList = "/meet"
}

struct MeetResponse: Codable {
    var content: [Meet]
}

struct Meet: Codable, Identifiable {
    var id: Int
    var title: String
    var content: String
    var recruitment: Int
    var application: Int
    var cost: Int
    var costOption: Bool
    var address: Address
    var term: Term
    var imgList: [Int]
    var img: String?
    var approvalYn: Bool
    var approvalDt: String?
    var chatCnt: Int
    
    static func getDummy() -> Self {
        return Meet(id: 1, title: "Title Test", content: "Content Test", recruitment: 2, application: 0, cost: 50000, costOption: true, address: Address.getDummy(), term: Term.getDummy(), imgList: [2], approvalYn: false, chatCnt: 0)
    }
}

struct Term: Codable {
    var dtOption: Bool
    var startDt: String?
    var endDt: String?
    var tmOption: Bool
    var startTm: String
    var endTm: String
    var detailDay: Int
    
    static func getDummy() -> Self {
        return Term(dtOption: false, startDt: "2022-03-13", endDt: "2022-03-20", tmOption: true, startTm: "10:00", endTm: "16:00", detailDay: 40)
    }
}

struct Address: Codable {
    var address1: String
    var address2: String
    var sido: String
    var sgg: String
    static func getDummy() -> Self {
        return Address(address1: "서초구 서초동", address2: "서운로 62", sido: "서울특별시", sgg: "서초구")
    }
}

struct Paging: Codable {
    var page: Int
    var size: Int = 10
}
