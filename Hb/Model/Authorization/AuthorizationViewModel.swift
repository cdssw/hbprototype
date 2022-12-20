//
//  AuthorizationViewModel.swift
//  Hb
//
//  Created by 최대완 on 2022/12/12.
//

import Foundation
import Combine
import Alamofire

class AuthorizationViewModel: ObservableObject {
    var subscription = Set<AnyCancellable>()
    
    var loginSuccess = PassthroughSubject<(), Never>()
    var loginFailure = PassthroughSubject<(), Never>()
    
    func login(username: String, password: String) {
        AuthorizationService.login(username: username, password: password)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.loginFailure.send()
                    print(#fileID, #function, #line, "error: \(error)")
                case.finished:
                    print(#fileID, #function, #line, "finished")
                }
            } receiveValue: { (result: AuthorizationResponse) in
                let rst = self.addTokenOnKeyChain(auth: result)
                if rst {
                    self.loginSuccess.send()
                } else {
                    self.loginFailure.send()
                }
            }.store(in: &subscription)
    }
    
    func addTokenOnKeyChain(auth: AuthorizationResponse) -> Bool {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: Constant.ACCESS_TOKEN,
            kSecValueData: auth.accessToken.data(using: String.Encoding.utf8)!
        ]
        let status = SecItemAdd(query as CFDictionary, nil)
        if status == errSecSuccess {
            return true
        } else if status == errSecDuplicateItem {
            return self.modTokenOnKeyChain(auth: auth)
        } else {
            return false
        }
    }
    
    func modTokenOnKeyChain(auth: AuthorizationResponse) -> Bool {
        let prevQuery: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: Constant.ACCESS_TOKEN
        ]
        let updateQuery: [CFString: Any] = [kSecValueData: auth.accessToken.data(using: String.Encoding.utf8)!]
        let status = SecItemUpdate(prevQuery as CFDictionary, updateQuery as CFDictionary)
        if status == errSecSuccess {
            return true
        } else {
            return false
        }
    }
    
    func getTokenOnKeyChain() -> String {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: Constant.ACCESS_TOKEN,
            kSecReturnAttributes: true,
            kSecReturnData: true
        ]
        var item: CFTypeRef?
        if SecItemCopyMatching(query as CFDictionary, &item) != errSecSuccess {
            print("read failed")
            return ""
        }
        
        guard let existingItem = item as? [String: Any] else { return "" }
        guard let data = existingItem[kSecValueData as String] as? Data else { return "" }
        guard let apiKey = String(data: data, encoding: .utf8) else { return "" }
        
        return apiKey
    }
    
    func delTokenOnKeyChain(key: String) -> Void {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        if status == errSecSuccess {
            print("deleted")
        } else {
            print("delete failed")
        }
    }
}
