//
//  FileViewModel.swift
//  Hb
//
//  Created by 최대완 on 2022/12/06.
//

import Foundation
import Combine
import Alamofire

class FileViewModel: ObservableObject {
    var subscription = Set<AnyCancellable>()
    
    @Published var fileList:[File] = []
    
    func postImagesPath(_ imgList:[Int]) {
        let body = FileReqeustBody(fileList: imgList)
        FileService.postImagesPath(body)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(#fileID, #function, #line, "error: \(error)")
                case.finished:
                    print(#fileID, #function, #line, "finished")
                }
            } receiveValue: { (result:[File]) in
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
                    self.fileList = result
                }
            }.store(in: &subscription)
    }
}
