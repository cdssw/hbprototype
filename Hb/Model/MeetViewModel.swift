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
    @Published var loaded: Bool = false
    
    init() {
        print(#fileID, #function, #line, "")
        // 생성자가 호출되면 바로 데이터를 조회
        let paging: Paging = Paging(page: self.page)
        getMeetList(paging)
    }
    
    func getMeetList(_ paging: Paging) {
        print(#fileID, #function, #line, "")
        let meetRouter = APIRouter(path: MeetPath.meetList, httpMethod: .get, parameters: paging.toData, apiType: .service)
        // 기존 리스트 카운트 저장
        let listCount = self.meetList.count
        AF.request(meetRouter)
            .publishDecodable(type: MeetResponse.self)
            .compactMap { $0.value }
            .map { $0.content }
            .sink(receiveCompletion: { completion in
                self.loaded = true
                print("receive complete")
            }, receiveValue: { receivedValue in
                self.loaded = false
                if receivedValue.count == 0 {
                    // 수신된 카운트가 0이면 이전 페이지값으로 되돌림
                    self.page -= 1
                } else {
                    // 기존 리스트에 수신된 데이터 추가
                    self.meetList += receivedValue
                    for i in 0..<receivedValue.count {
                        // 수신된 데이터 중 이미지가 있으면 파일서비스에 이미지 경로 요청
                        if receivedValue[i].imgList.count > 0 {
                            let body = FileReqeustBody(fileList: receivedValue[i].imgList)
                            let fileRouter = APIRouter(path: FilePath.postImagesPath, httpMethod: .post, parameters: body.toData, apiType: .service)
                            AF.request(fileRouter)
                                .responseDecodable(of: [File].self) { response in
                                    if let file = response.value {
                                        // 이미지경로를 저장하되 기존 카운트 이후 추가index 길이 만큼 offset해서 이미지 경로 설정
                                        // 얕은복사라서 append된 리스트에 반영됨
                                        self.meetList[listCount + i].img = "https://img-server.duckdns.org/images/" + file[0].path + "/" + file[0].chgFileNm
                                    }
                                }
                        }
                    }
                }
            }).store(in: &subscription)
    }
}

