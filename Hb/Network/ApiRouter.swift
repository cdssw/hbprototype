//
//  ApiRouter.swift
//  Hb
//
//  Created by DaeWan Choi on 2022/04/07.
//

import Foundation
import Alamofire

class APIRouter: URLRequestConvertible {
    // 1. APIType 정의
    enum APIType {
        case auth
        case service
        
        var baseURL: String {
            switch self {
            case .auth:
                switch environmentMode {
                case .dev: return "https://auth.dev"
                case .stg: return "https://auth.stg"
                case .prd: return "https://auth.prd"
                }
            case .service:
                return "https://cdssw.duckdns.org:9000"
            }
        }
    }
    
    var path: String
    var httpMethod: HTTPMethod
    var parameters: Data?
    var apiType: APIType
    
    init(path: String, httpMethod: HTTPMethod? = .get, parameters: Data? = nil, apiType: APIType = .service) {
        self.path = path
        self.httpMethod = httpMethod ?? .get
        self.parameters = parameters
        self.apiType = apiType
    }
    
    func asURLRequest() throws -> URLRequest {
        // 2. base URL + path
        let fullURL = apiType.baseURL + path
        let encodedURL = fullURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        var urlComponent = URLComponents(string: encodedURL)!
        
        // 3. get > query param 추가
        if httpMethod == .get, let params = parameters {
            if let dictionary = try? JSONSerialization.jsonObject(with: params, options: []) as? [String: Any] {
                var queries = [URLQueryItem]()
                for (name, value) in dictionary {
                    let encodedValue = "\(value)".addingPercentEncodingForRFC3986()
                    let queryItem = URLQueryItem(name: name, value: encodedValue)
                    queries.append(queryItem)
                }
                urlComponent.percentEncodedQueryItems = queries
            }
        }
        
        // 4. request 생성
        var request = try URLRequest(url: urlComponent.url!, method: httpMethod)
        
        // 5. post > json param 추가
        if httpMethod == .post, let params = parameters {
            request.httpBody = params
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        
        // 6. print to console
        print("[REQUEST]")
        print("URI: \(request.url?.absoluteString ?? "nil")")
        print("Body: \(request.httpBody?.toPrettyPrintedString ?? "")")
        
        return request
    }
}
