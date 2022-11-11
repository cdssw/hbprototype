//
//  FileService.swift
//  Hb
//
//  Created by DaeWan Choi on 2022/11/11.
//

import Foundation
import Combine
import Alamofire

enum FileService {
    static func postImagesPath(_ body: FileReqeustBody) -> AnyPublisher<[File], Error> {
        let router = APIRouter(path: FilePath.postImagesPath, httpMethod: .post, parameters: body.toData, apiType: .service)
        return AF.request(router)
            .publishDecodable(type: [File].self)
            .value()
            .mapError({ (afError: AFError) in
                return afError as Error
            })
            .eraseToAnyPublisher()
    }
}
