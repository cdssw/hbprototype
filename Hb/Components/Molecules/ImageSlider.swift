//
//  ImageSlider.swift
//  Hb
//
//  Created by 최대완 on 2022/11/23.
//

import SwiftUI

struct ImageSlider: View {
    private let images = [Constant.IMAGE_SERVER + "avatar/2022-11-23/b74fd2f1-d7fe-409b-92af-67f9fa94c688.jpg", Constant.IMAGE_SERVER + "avatar/2022-11-23/b74fd2f1-d7fe-409b-92af-67f9fa94c688.jpg"]
    
    @State private var page = 0
    
    var body: some View {
        TabView(selection: $page) {
            ForEach(0..<images.count, id:\.self) { index in
                AsyncImage(url: URL(string: images[index])) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Text("")
                }.tag(index)
            }
        }
        .tabViewStyle(PageTabViewStyle())
    }
}

struct ImageSlider_Previews: PreviewProvider {
    static var previews: some View {
        ImageSlider()
            .previewLayout(.fixed(width: 400, height: 300))
    }
}
