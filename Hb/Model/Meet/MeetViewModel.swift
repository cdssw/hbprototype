//
//  MeetViewModel.swift
//  Hb
//
//  Created by DaeWan Choi on 2022/04/07.
//

import Foundation
import Combine
import Alamofire

class MeetViewModel: ObservableObject {
    var subscription = Set<AnyCancellable>()
    
    @Published var meetList = [Meet]()
    @Published var page: Int = 0
    
    init() {
        print(#fileID, #function, #line, "")
        // 생성자가 호출되면 바로 데이터를 조회
        let paging: Paging = Paging(page: self.page)
        getMeetList(paging)
    }
    
    func getMeetList(_ paging: Paging) {
        let listCount = self.meetList.count
        MeetService.getMeetList(paging).eraseToAnyPublisher()
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(#fileID, #function, #line, "error: \(error)")
                case .finished:
                    print(#fileID, #function, #line, "finished")
                }
            } receiveValue: { (result: [Meet]) in
                if result.count == 0{
                    self.page -= 1
                } else {
                    self.meetList += result
                    for i in 0..<result.count {
                        // 수신된 데이터 중 이미지가 있으면 파일서비스에 이미지 경로 요청
                        if result[i].imgList.count > 0 {
                            // 파일서비스 호출을 위한 param 설정
                            let body = FileReqeustBody(fileList: result[i].imgList)
                            let router = APIRouter(path: FilePath.postImagesPath, httpMethod: .post, parameters: body.toData, apiType: .service)
                            AF.request(router)
                                .responseDecodable(of: [File].self) { response in // File list로 바로 디코딩 처리
                                    if let file = response.value {
                                        // 이미지경로를 저장하되 기존 카운트 이후 추가 index 길이 만큼 offset해서 이미지 경로 설정
                                        // 얕은복사라서 append된 리스트에 반영됨
                                        self.meetList[listCount + i].img = Constant.IMAGE_SERVER + file[0].path + "/" + file[0].chgFileNm
                                    }
                                }
                        }
                    }
                }
            }.store(in: &subscription)
    }
}

