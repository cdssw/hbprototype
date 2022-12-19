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
            kSecAttrAccount: "accessToken",
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
            kSecAttrAccount: "accessToken"
        ]
        let updateQuery: [CFString: Any] = [kSecValueData: auth.accessToken.data(using: String.Encoding.utf8)!]
        let status = SecItemUpdate(prevQuery as CFDictionary, updateQuery as CFDictionary)
        if status == errSecSuccess {
            return true
        } else {
            return false
        }
    }
}
