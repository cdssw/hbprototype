//
//  MeetService.swift
//  Hb
//
//  Created by DaeWan Choi on 2022/11/11.
//

import Foundation
import Combine
import Alamofire

enum MeetService {
    static func getMeetList(_ paging: Paging) -> AnyPublisher<[Meet], Error> {
        let router = APIRouter(path: MeetPath.meetList, httpMethod: .get, parameters: paging.toData, apiType: .service)
        return AF.request(router)
            .publishDecodable(type: MeetResponse.self)
            .value()
            .map { $0.content }
            .mapError({ (afError: AFError) in
                return afError as Error
            })
            .eraseToAnyPublisher()
    }
    
    static func getMeet(_ id: Int) -> AnyPublisher<Meet, Error> {
        let router = APIRouter(path: MeetPath.meet+"\(id)", httpMethod: .get, parameters: nil, apiType: .service)
        return AF.request(router)
            .publishDecodable(type: Meet.self)
            .value()
            .mapError({ (afError: AFError) in
                return afError as Error
            })
            .eraseToAnyPublisher()
    }
}
