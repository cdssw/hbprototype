//
//  File.swift
//  Hb
//
//  Created by DaeWan Choi on 2022/04/08.
//

import Foundation

class FilePath {
    static let postImagesPath = "/file/images/path"
}

struct FileResponse: Codable {
    var content: [File]
}

struct File: Codable, Identifiable, Hashable {
    var id: Int
    var path: String
    var orgFileNm: String
    var chgFileNm: String
    
    static func getDummy() -> Self {
        return File(id: 1, path: "image/2022-03-13", orgFileNm: "OrgFileNm", chgFileNm: "ChgFileNm")
    }
}

struct FileReqeustBody: Codable {
    var fileList: [Int]
}
