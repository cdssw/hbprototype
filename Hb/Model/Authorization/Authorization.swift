//
//  Authorization.swift
//  Hb
//
//  Created by 최대완 on 2022/12/12.
//

import Foundation

class AuthorizationPath {
    static let login = "/oauth/token"
}

struct AuthorizationResponse: Codable {
    let accessToken, tokenType, refreshToken: String
    let expiresIn: Int
    let scope, jti: String

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case refreshToken = "refresh_token"
        case expiresIn = "expires_in"
        case scope, jti
    }
}

struct LoginData: Codable {
    var grantType: String
    var clientId: String
    var scope: String
    var common: String
    var username: String
    var password: String
    
    enum CodingKeys: String, CodingKey {
        case grantType = "grant_type"
        case clientId = "client_id"
        case scope, common, username, password
    }
}
