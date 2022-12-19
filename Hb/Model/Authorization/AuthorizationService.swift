//
//  AuthorizationService.swift
//  Hb
//
//  Created by 최대완 on 2022/12/12.
//

import Foundation
import Combine
import Alamofire

enum AuthorizationService {
    static func login(username: String, password: String) -> AnyPublisher<AuthorizationResponse, Error> {
        let loginData: LoginData = LoginData(grantType: "password", clientId: "auth_id", scope: "read", common: "common", username: username, password: password)
        let router = APIRouter(path: AuthorizationPath.login, httpMethod: .post, parameters: loginData.toData, apiType: .auth)
        return AF.request(router)
            .authenticate(username: "auth_id", password: "auth_secret")
            .publishDecodable(type: AuthorizationResponse.self)
            .value()
            .mapError({ (afError: AFError) in
                return afError as Error
            })
            .eraseToAnyPublisher()
    }
}
