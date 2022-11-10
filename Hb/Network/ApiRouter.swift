//
//  ApiRouter.swift
//  Hb
//
//  Created by DaeWan Choi on 2022/04/07.
//

import Foundation
import Alamofire

// URLRequestConvertible 프로토콜을 구현
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
    
    // Rest호출시 ApiRouter를 생성하고 request를 호출한다.
    // 생성자
    init(path: String, httpMethod: HTTPMethod? = .get, parameters: Data? = nil, apiType: APIType = .service) {
        self.path = path
        self.httpMethod = httpMethod ?? .get
        self.parameters = parameters
        self.apiType = apiType
    }
    
    // AF.request()를 호출하면 아래 함수가 호출
    func asURLRequest() throws -> URLRequest {
        // 2. base URL + path
        let fullURL = apiType.baseURL + path
        // url encoding 처리 후 string 리턴
        let encodedURL = fullURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        // url string을 기반으로 URLComponent를 생성
        var urlComponent = URLComponents(string: encodedURL)!
        
        // 3. get이면 query parameter를 셋팅한다.
        if httpMethod == .get, let params = parameters {
            if let dictionary = try? JSONSerialization.jsonObject(with: params, options: []) as? [String: Any] {
                // URLQueryItem 배열을 만들고 받은 파라메터를 encoding하여 설정한다.
                var queries = [URLQueryItem]()
                for (name, value) in dictionary {
                    // RFC3896을 따르는 encoding 처리
                    let encodedValue = "\(value)".addingPercentEncodingForRFC3986()
                    let queryItem = URLQueryItem(name: name, value: encodedValue)
                    queries.append(queryItem)
                }
                urlComponent.percentEncodedQueryItems = queries
            }
        }
        
        // 4. request 생성
        var request = try URLRequest(url: urlComponent.url!, method: httpMethod)
        
        // 5. post이면 json param 추가
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
